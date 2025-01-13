default: build test

build:
	python -m build -s -w

venv:
	python -m venv .venv
	source .venv/bin/activate

test:
	python -m pytest tests/cdifflib_tests.py

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf CDiffLib.egg-info
	rm -f _cdifflib.so
	rm -f *.pyc
	rm -f tests/*.pyc
	rm -rf __pycache__
	rm -rf tests/__pycache__

makedist:
	python -m build -s
	python3.9 -m build
	python3.10 -m build
	python3.11 -m build
	python3.12 -m build
	python3.13 -m build
	twine check dist/*

upload:
	twine upload dist/*
