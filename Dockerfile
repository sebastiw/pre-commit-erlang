FROM erlang:26.0-alpine

RUN apk update && apk add --no-cache git
