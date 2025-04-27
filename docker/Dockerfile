# Using latest Ubuntu image as base
FROM ubuntu:latest

# Setting environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Package descriptions:
# build-essential - Compiler and build tools
# git - Version control system
# libssl-dev - SSL development libraries
# zlib1g-dev - Compression library
# libreadline-dev - Command line editing library
# libyaml-dev - YAML parser and emitter
# libsqlite3-dev - SQLite development files
# libxml2-dev - XML parsing library
# libxslt1-dev - XSLT processing library
# libcurl4-openssl-dev - HTTP client library
# libffi-dev - Foreign Function Interface library
# software-properties-common - Manage software repositories
# sqlite3 - SQLite database engine
# curl - Command line tool for transferring data
# wget - Internet file downloader
# telnet - Telnet client
# procps - System and process monitoring utilities
# nodejs - JavaScript runtime
# npm - Node.js package manager

# Updating packages and installing necessary dependencies
RUN apt-get update && apt-get install -y \
    # Build essentials and development tools
    build-essential \
    git \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    software-properties-common \
    \
    # Database
    sqlite3 \
    \
    # Network utilities
    curl \
    wget \
    telnet \
    \
    # System monitoring
    procps \
    \
    # JavaScript runtime
    nodejs \
    npm \
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