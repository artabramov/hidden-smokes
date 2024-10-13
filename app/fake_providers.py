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

USER_LOGIN_DIGITS_NUMBER = 2
USER_SIGNATURE_WORDS_COUNT = 2
USER_CONTACTS_WORDS_COUNT = 16
COLLECTION_NAME_WORDS_NUMBER = 4
COLLECTION_SUMMARY_WORDS_NUMBER = 16
MEMBER_NAME_WORDS_NUMBER = 4
MEMBER_SUMMARY_WORDS_NUMBER = 16
MEMBER_CONTACTS_WORDS_NUMBER = 16
DATAFILE_SUMMARY_WORDS_NUMBER = 16
DATAFILE_TAGS_COUNT = 8
COMMENT_CONTENT_WORDS_NUMBER = 16
OPTION_KEY_WORDS_NUMBER = 2
OPTION_VALUE_WORDS_NUMBER = 4

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


class UserSignatureProvider(BaseProvider):
    def user_signature(self):
        """
        Generate a user signature by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=USER_SIGNATURE_WORDS_COUNT)


class UserContactsProvider(BaseProvider):
    def user_contacts(self):
        """
        Generate a user contacts by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=USER_CONTACTS_WORDS_COUNT)


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


class MemberNameProvider(BaseProvider):
    def member_name(self):
        """
        Generate a member name by creating a random sentence with
        Faker and removing the trailing period.
        """
        return fake.sentence(nb_words=MEMBER_NAME_WORDS_NUMBER).rstrip(".")


class MemberSummaryProvider(BaseProvider):
    def member_summary(self):
        """
        Generate a member summary by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=MEMBER_SUMMARY_WORDS_NUMBER)


class MemberContactsProvider(BaseProvider):
    def member_contacts(self):
        """
        Generate a member contacts by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=MEMBER_CONTACTS_WORDS_NUMBER)


class DatafileNameProvider(BaseProvider):
    def datafile_name(self):
        return f"{fake.word()}.{fake.file_extension()}"


class DatafileSummaryProvider(BaseProvider):
    def datafile_summary(self):
        """
        Generate a datafile summary by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=DATAFILE_SUMMARY_WORDS_NUMBER)


class DatafileTagsProvider(BaseProvider):
    def datafile_tags(self):
        """
        Generate a list of datafile tags by creating random words with
        Faker. The number of tags can be controlled by a constant.
        """
        tags = [fake.word() for _ in range(DATAFILE_TAGS_COUNT)]
        return ", ".join(tags)

class CommentContentProvider(BaseProvider):
    def comment_content(self):
        """
        Generate a comment content by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=COMMENT_CONTENT_WORDS_NUMBER)


class OptionKeyProvider(BaseProvider):
    def option_key(self):
        """
        Generate a optionkey by creating random words with Faker divided
        by underscore. The number of tags can be controlled by
        a constant.
        """
        fake_words = [fake.word() for _ in range(OPTION_KEY_WORDS_NUMBER)]
        return "_".join(fake_words)


class OptionValueProvider(BaseProvider):
    def option_value(self):
        """
        Generate an option value by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=OPTION_VALUE_WORDS_NUMBER)


fake.add_provider(UserLoginProvider)
fake.add_provider(UserSignatureProvider)
fake.add_provider(UserContactsProvider)
fake.add_provider(CollectionNameProvider)
fake.add_provider(CollectionSummaryProvider)
fake.add_provider(MemberNameProvider)
fake.add_provider(MemberSummaryProvider)
fake.add_provider(MemberContactsProvider)
fake.add_provider(DatafileNameProvider)
fake.add_provider(DatafileSummaryProvider)
fake.add_provider(DatafileTagsProvider)
fake.add_provider(CommentContentProvider)
fake.add_provider(OptionKeyProvider)
fake.add_provider(OptionValueProvider)
