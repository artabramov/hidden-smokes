import json
import requests, pyotp
from behave import *
import jwt

REQUEST_HEADERS = {"accept": "application/json"}


@given("auth with user role '{user_role}'")
def step_impl(context, user_role):
    if user_role + "_token" not in context.global_params:
        # user login
        url = context.config_params["base_url"] + "auth/login/"
        params = {
            "user_login": context.config_params[user_role + "_login"],
            "user_password": context.config_params[user_role + "_password"],
        }
        response = requests.get(url, headers=REQUEST_HEADERS, params=params)

        # retrieve token
        url = context.config_params["base_url"] + "auth/token/"
        mfa_secret = context.config_params[user_role + "_mfa_secret"]
        user_totp = pyotp.TOTP(mfa_secret).now()
        params = {
            "user_login": context.config_params[user_role + "_login"],
            "user_totp": user_totp,
        }
        response = requests.get(url, headers=REQUEST_HEADERS, params=params)

        # decode token
        response_params = json.loads(response.text)
        user_token = response_params["user_token"]
        token_payload = jwt.decode(user_token, context.config_params["jwt_secret"],
                                   algorithms=context.config_params["jwt_algorithm"])
        context.global_params[user_role + "_id"] = token_payload["user_id"]
        context.global_params[user_role + "_token"] = user_token
