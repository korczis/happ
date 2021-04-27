# Extend from the official Elixir image
FROM elixir:latest

# Install OS dependencies
RUN apt-get update && \
  apt-get install -y postgresql-client cmake

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

COPY mix.exs .
COPY mix.lock .

# Get dependencies
RUN mix deps.get

# Compile dependencies
RUN mix deps.compile

# Copy project sources
COPY . .

# Compile the project
RUN mix do compile

# Entrypoint
CMD ["/app/entrypoint.sh"]
