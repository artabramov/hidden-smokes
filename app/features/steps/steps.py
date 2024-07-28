import json
import requests, pyotp
from behave import *
import jwt
from app.fake import fake

REQUEST_HEADERS = {"accept": "application/json"}


@given("set request param '{request_param}' from value '{value}'")
def step_impl(context, request_param, value):
    if value == "None":
        if request_param in context.request_params:
            del context.request_params[request_param]

    elif value == "empty":
        context.request_params[request_param] = ""

    elif value == "whitespaces":
        context.request_params[request_param] = " " * 8

    else:
        context.request_params[request_param] = value


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
