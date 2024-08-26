"""Fake data generators."""

from faker import Faker
from faker.providers import BaseProvider
import shortuuid

fake = Faker()


class UserLoginProvider(BaseProvider):
    def user_login(self):
        return shortuuid.ShortUUID().random(length=16).lower()


class CollectionNameProvider(BaseProvider):
    def collection_name(self):
        return fake.sentence(nb_words=4).rstrip(".")


# class CollectionSummaryProvider(BaseProvider):
#     def collection_summary(self):
#         return fake.sentence(nb_words=16)


fake.add_provider(UserLoginProvider)
fake.add_provider(CollectionNameProvider)
# fake.add_provider(CollectionSummaryProvider)
