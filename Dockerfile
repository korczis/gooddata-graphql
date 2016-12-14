FROM elixir

# Switch to directory with sources
WORKDIR /src

RUN apt-get update \
  && apt-get install -y inotify-tools

# Copy required stuff
ADD . .

RUN mix local.rebar --force \
  && mix local.hex --force \
  && mix deps.get \
  && mix deps.compile \
  && mix compile

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

RUN export NVM_DIR="/root/.nvm" \
  && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  \
  && nvm install 6.6.0 \
  && npm install

RUN MIX_ENV=prod mix compile

ADD .docker/start.sh /start.sh

CMD ["/start.sh"]