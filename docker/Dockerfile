# Using latest Ubuntu image as base
FROM ubuntu:latest

# Setting environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Updating packages and installing necessary dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    libffi-dev \
    nodejs \
    npm \
    procps \
    wget \
    telnet \
    && rm -rf /var/lib/apt/lists/*

# Installing rbenv and ruby-build
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Installing latest Ruby 3 version
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
RUN rbenv install 3.2.2 && \
    rbenv global 3.2.2 && \
    gem install bundler

# Checking Ruby and Bundler versions
RUN ruby -v && bundler -v

# Creating working directory
WORKDIR /app

# Default command
CMD ["bash"] 