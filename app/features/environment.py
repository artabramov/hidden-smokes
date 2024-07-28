import configparser
from app.features.steps.steps import *
from app.features.steps.response_steps import *


def before_all(context):
    context.global_params = {}
    context.config_params = {}

    config_parser = configparser.ConfigParser()
    config_parser.read("/smokes/behave.ini")
    for config_param in config_parser["behave.userdata"]:
        context.config_params[config_param] = config_parser["behave.userdata"][config_param]


def before_scenario(context, scenario):
    context.request_headers = {}
    context.request_placeholders = {}
    context.request_params = {}
    context.request_files = {}

    context.response_code = 0
    context.response_params = {}
