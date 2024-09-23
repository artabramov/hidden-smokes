import configparser
from app.features.steps.auth_steps import *
from app.features.steps.request_steps import *
from app.features.steps.response_steps import *


def before_all(context):
    context.global_params = {}
    context.config_params = {}

    config_parser = configparser.ConfigParser()
    config_parser.read("/smokes/behave.ini")
    for config_param in config_parser["behave.userdata"]:
        context.config_params[config_param] = config_parser["behave.userdata"][config_param]


def before_scenario(context, scenario):
    # reset request body param
    context.request_headers = {}
    context.request_path = {}
    context.request_query = {}
    context.request_body = {}
    context.request_files = {}

    # reset response data
    context.response_code = 0
    context.response_params = {}
    context.response_content = None
