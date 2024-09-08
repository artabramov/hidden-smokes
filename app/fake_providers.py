"""
Extends the Faker library with custom data providers for generating
various types of fake data, allowing for flexible and configurable
data generation suitable for testing and development. Constants in
this module define parameters such as digit counts and word lengths
for the generated data.
"""

import random
import string
from faker import Faker
from faker.providers import BaseProvider

fake = Faker()

USER_LOGIN_DIGITS_NUMBER = 4
COLLECTION_NAME_WORDS_NUMBER = 4
COLLECTION_SUMMARY_WORDS_NUMBER = 16

class UserLoginProvider(BaseProvider):
    def user_login(self):
        """
        Generate a user login by creating a name with Faker, converting
        it to lowercase, removing spaces, and appending a specified
        number of random digits.
        """
        user_login = fake.name().lower().replace(" ", "").replace(".", "")
        random_digits = "".join(random.choices(
            string.digits, k=USER_LOGIN_DIGITS_NUMBER))
        return user_login + random_digits


class CollectionNameProvider(BaseProvider):
    def collection_name(self):
        """
        Generate a collection name by creating a random sentence with
        Faker and removing the trailing period.
        """
        return fake.sentence(nb_words=COLLECTION_NAME_WORDS_NUMBER).rstrip(".")


class CollectionSummaryProvider(BaseProvider):
    def collection_summary(self):
        """
        Generate a collection summary by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=COLLECTION_SUMMARY_WORDS_NUMBER)


fake.add_provider(UserLoginProvider)
fake.add_provider(CollectionNameProvider)
fake.add_provider(CollectionSummaryProvider)
