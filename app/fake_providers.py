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
PARTNER_SUMMARY_WORDS_NUMBER = 16
DOCUMENT_SUMMARY_WORDS_NUMBER = 16
DOCUMENT_TAGS_COUNT = 8
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
    def user_capture(self):
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


class PartnerSummaryProvider(BaseProvider):
    def partner_summary(self):
        """
        Generate a partner summary by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=PARTNER_SUMMARY_WORDS_NUMBER)


class DocumentNameProvider(BaseProvider):
    def document_name(self):
        return f"{fake.word()}.{fake.file_extension()}"


class DocumentSummaryProvider(BaseProvider):
    def document_summary(self):
        """
        Generate a document summary by creating a random sentence with
        Faker consisting of a specified number of words.
        """
        return fake.sentence(nb_words=DOCUMENT_SUMMARY_WORDS_NUMBER)


class DocumentTagsProvider(BaseProvider):
    def document_tags(self):
        """
        Generate a list of document tags by creating random words with
        Faker. The number of tags can be controlled by a constant.
        """
        tags = [fake.word() for _ in range(DOCUMENT_TAGS_COUNT)]
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
fake.add_provider(PartnerSummaryProvider)
fake.add_provider(DocumentNameProvider)
fake.add_provider(DocumentSummaryProvider)
fake.add_provider(DocumentTagsProvider)
fake.add_provider(CommentContentProvider)
fake.add_provider(OptionKeyProvider)
fake.add_provider(OptionValueProvider)
