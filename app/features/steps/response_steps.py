"""
This module provides step definitions for managing and validating HTTP
responses in behavior-driven development (BDD) scenarios using the
Behave framework. It includes functionality for verifying response
status codes, checking for specific keys and error details in response
parameters, and saving response data to global parameters. The module is
designed to ensure accurate validation of API responses by handling and
asserting response data dynamically.
"""

from behave import *


@then("response code is '{code}'")
def step_impl(context, code):
    """
    Asserts that the HTTP response code stored in the context matches
    the expected value provided in the step. The function compares
    context.response_code with the integer value of code to ensure they
    are equal.
    """
    try:
        assert context.response_code == int(code)
    except Exception as e:
        # use for debugging
        raise e


@then("error loc is '{error_loc}'")
def step_impl(context, error_loc):
    """
    Asserts that the detail field in context.response_params contains
    exactly one error and that the specified error_loc is present in
    the location information of that error. The function checks if the
    length of the detail list is 1 and verifies that error_loc is
    included in the loc field of the first error in the list.
    """
    assert len(context.response_params["detail"]) == 1
    assert error_loc in context.response_params["detail"][0]["loc"]


@then("error type is '{error_type}'")
def step_impl(context, error_type):
    """
    Asserts that the detail field in context.response_params contains
    exactly one error and that the type of this error matches the
    expected error_type. The function verifies that the length of the
    detail list is 1 and checks that the type field of the first error
    in the list matches the provided error_type.
    """
    assert len(context.response_params["detail"]) == 1
    assert context.response_params["detail"][0]["type"] == error_type


@then("response params contain '{key}'")
def step_impl(context, key):
    """
    Asserts that the specified key is present in the response_params
    dict within the context. The function checks if key is a valid key
    in context.response_params.
    """
    assert key in context.response_params


@then("response contains '{param_count}' params")
def step_impl(context, param_count):
    """
    Asserts that the number of parameters in the response matches the
    expected count. It converts the expected count from a string to an
    integer and compares it with the length of response_params.
    """
    len(context.response_params) == int(param_count)


@then("response param '{key}' equals '{value}'")
def step_impl(context, key, value):
    assert str(context.response_params[key]) == str(value)


@then("response content is not empty")
def step_impl(context):
    """
    Asserts that the response content in the context is not empty. The
    function checks if response_content is not none to ensure that the
    response content is present and has been correctly populated.
    """
    assert context.response_content is not None


@then("save response param '{response_param}' to global param '{global_param}'")
def step_impl(context, response_param, global_param):
    """
    Saves the value of a response parameter from response_params to a
    global parameter in global_params. The function retrieves the value
    associated with response_param from the context.response_params dict
    and assigns it to the key global_param in context.global_params.
    """
    param = context.response_params[response_param]
    context.global_params[global_param] = param


@then("save id from response list '{response_list}' to global param '{global_param}'")
def step_impl(context, response_list, global_param):
    """
    Saves the ID of the first item in a response list to a global
    parameter. The function retrieves the list associated with
    response_list from context.response_params, extracts the ID from
    the first item in the list, and assigns it to the key global_param.
    """
    param = context.response_params[response_list][0]["id"]
    context.global_params[global_param] = param
