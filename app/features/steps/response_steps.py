from behave import *


@then("response code is '{code}'")
def step_impl(context, code):
    assert context.response_code == int(code)


@then("error loc is '{error_loc}'")
def step_impl(context, error_loc):
    assert len(context.response_params["detail"]) == 1
    assert error_loc in context.response_params["detail"][0]["loc"]


@then("error type is '{error_type}'")
def step_impl(context, error_type):
    assert len(context.response_params["detail"]) == 1
    assert context.response_params["detail"][0]["type"] == error_type


@then("response params contain '{key}'")
def step_impl(context, key):
    assert key in context.response_params
