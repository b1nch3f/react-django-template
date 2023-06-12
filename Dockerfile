# Development Build 2/8/2023
# build fails on aarch64 without --platform flag
FROM --platform=linux/amd64 ubuntu:22.04

ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
    apt-get install -y curl wget sudo && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs &&\
    apt-get install -y libhdf5-dev git python3-dev libmysqlclient-dev default-libmysqlclient-dev build-essential python3-pip python3-tk unixodbc-dev r-base lsb-release dos2unix gnupg2 && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/21.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt update && \
    apt-get update -y && \
    ACCEPT_EULA=Y apt-get install -y sudo odbcinst msodbcsql18 redis-server

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY package.json .
RUN npm install

WORKDIR /app
COPY . .

RUN npm run build

EXPOSE 8080

ENTRYPOINT python3 entrypoint.py
