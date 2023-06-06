FROM erlang:24-alpine

# Install git and create nonroot user
RUN apk update && apk add --no-cache git; \
    addgroup -S nonroot; \
    adduser -S nonroot -G nonroot --disabled-password

# Get rebar3
WORKDIR /rebar3
ADD https://s3.amazonaws.com/rebar3/rebar3 ./
ENV PATH="${PATH}:/rebar3"

# Use the nonroot user
USER nonroot
