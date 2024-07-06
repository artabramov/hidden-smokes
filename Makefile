install:
	docker build --no-cache -t hide-smokes .
	docker run --name hide-smokes -dit hide-smokes
