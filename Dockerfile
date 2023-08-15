# Use an official Ruby runtime as the base image
FROM ruby:3.2.0

# Set the working directory in the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gem dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
