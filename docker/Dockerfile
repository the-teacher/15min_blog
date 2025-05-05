# Using base image instead of Ubuntu
FROM iamteacher/blog_15min.base:latest

# Working directory
WORKDIR /app

# Rails user is already created in the base image and has access to the /app directory
USER rails:rails

# Installing required gems for the blog
RUN gem install rails

# Default command
CMD ["bash"] 