all: upgrade

upgrade:
	docker-compose run sentry sentry upgrade; docker-compose up -d