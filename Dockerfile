FROM elixir:1.18-alpine AS build

RUN apk add --no-cache build-base git

ENV MIX_ENV=prod \
    LANG=C.UTF-8

WORKDIR /app

COPY mix.exs mix.lock ./
COPY config config

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get --only prod \
 && mix deps.compile


COPY lib lib

RUN mix ash.codegen --name prod
RUN mix compile
RUN mix release


FROM alpine:latest AS runtime

RUN apk add --no-cache libstdc++ openssl ncurses-libs ca-certificates \
    && addgroup -g 1001 -S appgroup \
    && adduser -S appuser -u 1001 -G appgroup

ENV LANG=C.UTF-8 \
    MIX_ENV=prod \
    HOME=/app

WORKDIR /app

COPY --from=build --chown=appuser:appgroup /app/_build/prod/rel/ice ./

USER appuser

CMD bin/ice eval "Ice.Release.setup()" && exec bin/ice start
