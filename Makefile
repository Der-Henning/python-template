install:
	pip install -r requirements-dev.txt

test:
	python -m pytest --cov src/

lint:
	pre-commit run -a

image:
	docker build --tag python-template:latest .
