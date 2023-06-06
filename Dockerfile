FROM erlang:24-alpine

ARG USER_ID
ARG GROUP_ID

# Install git and create nonroot user
RUN apk update && apk add --no-cache git; \
    addgroup -g $GROUP_ID nonroot; \
    adduser -u $USER_ID -S nonroot -G nonroot --disabled-password

# Get rebar3
WORKDIR /rebar3
ADD https://s3.amazonaws.com/rebar3/rebar3 ./
ENV PATH="${PATH}:/rebar3"

# Use the nonroot user
USER nonroot
