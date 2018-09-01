FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN apt-get update && \
  apt-get install --yes build-essential inotify-tools postgresql-client

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT /app/entrypoint.sh

