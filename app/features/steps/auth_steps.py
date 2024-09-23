"""
This module contains step definitions for user authentication and token
management in behavior-driven development (BDD) scenarios using the
Behave framework. It includes functionality for authenticating users
based on their roles by logging in, retrieving authentication tokens,
and decoding them to extract user-specific information. The module
manages user tokens and IDs by storing them in global parameters for
use in subsequent steps, facilitating dynamic and role-based
authentication during testing.
"""

import json
import requests, pyotp
from behave import *
import jwt

REQUEST_HEADERS = {"accept": "application/json"}


@given("auth with user role '{user_role}'")
def step_impl(context, user_role):
    """
    Authenticates a user based on the specified user_role by performing
    login and token retrieval. The function first checks if a token for
    the given user_role already exists in global_params. If not, it logs
    in the user by sending a request with the user's login credentials,
    then retrieves an authentication token using a TOTP generated from
    the user's MFA secret. The token is decoded to extract the user ID,
    and both the user ID and token are stored in global_params for use
    in subsequent steps.
    """
    if user_role + "_token" not in context.global_params:
        # user login
        url = context.config_params["internal_base_url"] + "auth/login"
        body_params = {
            "user_login": context.config_params[user_role + "_login"],
            "user_password": context.config_params[user_role + "_password"],
        }
        response = requests.post(url, headers=REQUEST_HEADERS,
                                 json=body_params)

        # retrieve token
        url = context.config_params["internal_base_url"] + "auth/token/"
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
