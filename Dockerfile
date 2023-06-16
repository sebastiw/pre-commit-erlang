FROM erlang:26.0-alpine

ARG USER_ID=1000
ARG GROUP_ID=1000

# Install git and create nonroot user
RUN apk update && apk add --no-cache git; \
    addgroup -g $GROUP_ID nonroot; \
    adduser -u $USER_ID -S nonroot -G nonroot --disabled-password

# Get rebar3
WORKDIR /rebar3
ADD https://s3.amazonaws.com/rebar3/rebar3 ./
ENV PATH="${PATH}:/rebar3"

# Create /src directory and set ownership to nonroot user
RUN mkdir /src && chown $USER_ID:$GROUP_ID /src

# Use the nonroot user
USER nonroot
