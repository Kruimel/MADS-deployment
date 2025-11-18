PHONY: run

dist/slanggen-0.4-py3-none-any.whl: dist/slanggen-0.4-py3-none-any.whl
	mkdir -p dist
	uv build --wheel

run: stop dist/slanggen-0.4-py3-none-any.whl
	@echo "running docker file"
	docker compose up --build -d
	@echo "container is running, open on: http://0.0.0.0:80"
	
stop:
	@echo "stopping and removing container"
	docker compose down
