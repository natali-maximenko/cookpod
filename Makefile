.PHONY: start migrate server default credo format test

default: format credo test

start: migrate server

migrate:
	mix ecto.migrate

server:
	mix phx.server

credo:
	mix credo --strict

format:
	mix format --check-formatted

test:
	mix coveralls