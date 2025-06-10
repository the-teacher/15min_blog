# Using base image instead of Ubuntu
FROM iamteacher/blog_15min.base:latest

# Working directory
WORKDIR /app

# YJIT is a new JIT compiler for Ruby that can significantly improve performance
# Enable YJIT (Ruby's Just-In-Time compiler) for better performance
ENV RUBY_YJIT_ENABLE=1
ENV RUBYOPT="--yjit"

# Install sqlite3
USER root
RUN apt-get update && apt-get install -y sqlite3

# Rails user is already created in the base image and has access to the /app directory
USER rails:rails

# Update gem system to the latest version
RUN gem update --system 3.6.8

# Installing required gems for the blog
RUN gem install rails

WORKDIR /app/blog_15min

# Default command
CMD ["bash"]
