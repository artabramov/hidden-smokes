FROM python:3.11

ADD . /smokes
WORKDIR /smokes
RUN chmod -R 777 /smokes

RUN pip3 install behave==1.2.6
RUN pip3 install requests==2.31.0
RUN pip3 install pyotp==2.9.0
RUN pip3 install PyJWT==2.8.0
RUN pip3 install Faker==24.11.0
RUN pip3 install shortuuid==1.0.13
RUN pip3 freeze > /smokes/requirements.txt

RUN git config --global user.email "notdepot@gmail.com"
RUN git config --global user.name "Artem Abramov"

CMD tail -f /dev/null
