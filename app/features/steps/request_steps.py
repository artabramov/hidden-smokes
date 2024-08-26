import json
import requests, pyotp
from behave import *
from app.fake_providers import fake

REQUEST_HEADERS = {"accept": "application/json"}
AUTH_HEADER = "Authorization"
AUTH_PREFIX = "Bearer "


@given("set request token from global param '{global_param}'")
def step_impl(context, global_param):
    auth_header = AUTH_PREFIX + context.global_params[global_param]
    context.request_headers[AUTH_HEADER] = auth_header


@given("set request token from response param '{response_param}'")
def step_impl(context, response_param):
    auth_header = AUTH_PREFIX + context.response_params[response_param]
    context.request_headers[AUTH_HEADER] = auth_header


@given("set request placeholder '{request_placeholder}' from global param '{global_param}'")
def step_impl(context, request_placeholder, global_param):
    param = context.global_params[global_param]
    context.request_placeholders[request_placeholder] = param


@given("set request param '{request_param}' from value '{value}'")
def step_impl(context, request_param, value):
    if value == "none":
        if request_param in context.request_params:
            del context.request_params[request_param]

    elif value == "empty":
        context.request_params[request_param] = ""

    elif value == "spaces":
        context.request_params[request_param] = " " * 8

    elif value == "tabs":
        context.request_params[request_param] = "   " * 8

    else:
        context.request_params[request_param] = value


@given("set request param '{request_param}' from fake '{fake_provider}'")
def step_impl(context, request_param, fake_provider):
    context.request_params[request_param] = getattr(fake, fake_provider)()


@given("set request param '{request_param}' from config param '{config_param}'")
def step_impl(context, request_param, config_param):
    context.request_params[request_param] = context.config_params[config_param]


@given("generate request param 'user_totp' from config param '{config_param}'")
def step_impl(context, config_param):
    mfa_key = context.config_params[config_param]
    context.request_params["user_totp"] = pyotp.TOTP(mfa_key).now()


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
