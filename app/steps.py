import json
import requests, pyotp
from behave import *
import jwt
from app.fake import fake

REQUEST_HEADERS = {"accept": "application/json"}


@when("send '{request_method}' request to url '{request_url}'")
def step_impl(context, request_method, request_url):
    for placeholder in context.request_placeholders:
        request_url = request_url.replace(":" + placeholder, str(context.request_placeholders[placeholder]))
    url = context.config_params["base_url"] + request_url
    headers = context.request_headers
    headers["accept"] = "application/json"
    params = context.request_params

    if request_method == "POST":
        response = requests.post(url, headers=headers, params=params, files=context.request_files)

    elif request_method == "GET":
        response = requests.get(url, headers=headers, params=params)

    elif request_method == "PUT":
        response = requests.put(url, headers=headers, params=params)

    elif request_method == "DELETE":
        response = requests.delete(url, headers=headers, params=params)

    context.response_code = response.status_code
    context.response_params = json.loads(response.text)

    context.request_headers = {}
    context.request_params = {}


@then("response code is <{code}>")
def step_impl(context, code):
    assert context.response_code == int(code)
