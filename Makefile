build:
	mkdir -p build
	jam compile -i app/main -o build/application.js

deploy: build
	git push heroku master
	s3cmd put --acl-public build/application.js s3://webaudio.herokuapp.com/application.js

.PHONY: build deploy