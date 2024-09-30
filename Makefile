install:
	docker build --no-cache -t hidden-smokes .
	docker run --name hidden-smokes -dit hidden-smokes
