.PHONY:
broker:
	@docker compose \
		-f ./compose.yaml \
		up -d broker

.PHONY: test
test: broker
	@echo "Running the tests"
	@go test ./... -v -coverprofile=coverage_sheet.md
	@docker compose \
		-f ./compose.yaml \
		down broker

.PHONY: run
run:
	@docker compose \
		-f ./compose.yaml \
		up --build

.PHONY: coverage
coverage: test
	@go tool cover -html=coverage_sheet.md