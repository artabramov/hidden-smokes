"""Fake data generators."""

from faker import Faker
from faker.providers import BaseProvider
import shortuuid

fake = Faker()


class UserLoginProvider(BaseProvider):
    def user_login(self):
        return shortuuid.ShortUUID().random(length=16).lower()


fake.add_provider(UserLoginProvider)
