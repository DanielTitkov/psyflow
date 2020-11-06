PROJECT_ROOT := app
PROJECT := app
CFG_COMPILE_IGNORE := PORT='$$PORT'
DUMP_FILE_NAME := dump

include $(PROJECT_ROOT)/.env
export

.PHONY: collectstatic
collectstatic:
	cd $(PROJECT_ROOT) && pipenv run python manage.py collectstatic --clear --no-input

.PHONY: freeze
freeze: 
	pipenv run pip freeze > requirements.txt

.PHONY: devdbup
devdbup:
	cd deployments/dev && docker-compose up -d 

.PHONY: dump
dump:
	cd $(PROJECT_ROOT) && pipenv run python manage.py dumpdata --indent 4 --exclude auth.permission --exclude contenttypes > ../$(DUMP_FILE_NAME).json

.PHONY: load
load:
	cd $(PROJECT_ROOT) && pipenv run python manage.py loaddata ../$(DUMP_FILE_NAME).json

.PHONY: run
run:
	cd $(PROJECT_ROOT) && pipenv run python manage.py runserver

.PHONY: migrate
migrate:
	cd $(PROJECT_ROOT) && pipenv run python manage.py makemigrations && pipenv run python manage.py migrate 

.PHONY: test 
test: 
	echo TESTING