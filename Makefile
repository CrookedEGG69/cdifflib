SHELL := /bin/bash

default: venv build install test

build:
	source .venv/bin/activate && python -m build -s -w

install:
	source .venv/bin/activate && pip install dist/cdifflib-*.tar.gz

venv:
	python3 -m venv .venv
	source .venv/bin/activate && pip install build ruff mypy twine pytest

test:
	source .venv/bin/activate && python -m pytest tests/cdifflib_tests.py

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf CDiffLib.egg-info
	rm -f _cdifflib.so
	rm -f *.pyc
	rm -f tests/*.pyc
	rm -rf __pycache__
	rm -rf tests/__pycache__
	rm -rf .venv/

PYVERSIONS = 3.9 3.10 3.11 3.12 3.13

multidist:
	source .venv/bin/activate && python -m build -s
	$(foreach pyver,$(PYVERSIONS),rm -rf venv-tmp-$(pyver) && python$(pyver) -m venv venv-tmp-$(pyver) && source venv-tmp-$(pyver)/bin/activate && pip install build && python -m build && rm -rf venv-tmp-$(pyver))
	twine check dist/*

upload:
	twine upload dist/*
