build:
	mkdir -p build
	jam compile -i app/main -o build/application.js

.PHONY: build