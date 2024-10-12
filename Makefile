install:
	cp --force ~/.ssh/id_rsa ./.ssh
	cp --force ~/.ssh/id_rsa.pub ./.ssh

	docker build --no-cache -t hidden-smokes .
	docker run --name hidden-smokes -dit hidden-smokes
