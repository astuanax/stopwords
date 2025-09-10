.PHONY: clean-pyc clean-build clean-test clean dist release docs servedocs lint test test-all coverage install help venv deps

define BROWSER_PYSCRIPT
import os, webbrowser, sys
try:
    from urllib import pathname2url
except:
    from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT
BROWSER := .venv/bin/python -c "$$BROWSER_PYSCRIPT"

# ------------------------------
# Environment Setup
# ------------------------------
venv:
	@test -d .venv || python3 -m venv .venv

deps: venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install build twine flake8 coverage sphinx

# ------------------------------
# Help
# ------------------------------
help:
	@echo "make venv     - create virtual environment in .venv/"
	@echo "make deps     - install required dependencies into .venv/"
	@echo "make clean    - remove build, test, coverage and Python artifacts"
	@echo "make dist     - build source and wheel packages"
	@echo "make release  - upload a release to PyPI using Twine"
	@echo "make install  - install the package to the active Python's site-packages"
	@echo "make lint     - check style with flake8"
	@echo "make test     - run tests quickly with the default Python"
	@echo "make coverage - check code coverage"
	@echo "make docs     - generate Sphinx documentation"

# ------------------------------
# Cleaning
# ------------------------------
clean: clean-build clean-pyc clean-test

clean-build:
	rm -fr build/ dist/ .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/ .pytest_cache/ htmlcov/ .coverage

# ------------------------------
# Linting
# ------------------------------
lint: deps
	.venv/bin/flake8 stopwords tests

# ------------------------------
# Testing
# ------------------------------
test: deps
	.venv/bin/python setup.py test

test-all: deps
	.venv/bin/tox

coverage: deps
	.venv/bin/coverage run --source stopwords setup.py test
	.venv/bin/coverage report -m
	.venv/bin/coverage html
	$(BROWSER) htmlcov/index.html

# ------------------------------
# Documentation
# ------------------------------
docs: deps
	rm -f docs/stopwords.rst docs/modules.rst
	.venv/bin/sphinx-apidoc -o docs/ stopwords
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	$(BROWSER) docs/_build/html/index.html

servedocs: docs
	.venv/bin/watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

# ------------------------------
# Distribution & Release
# ------------------------------
dist: deps clean
	.venv/bin/python -m build
	ls -l dist

release: dist
	.venv/bin/twine upload dist/*

# ------------------------------
# Installation
# ------------------------------
install: deps clean
	.venv/bin/pip install .
