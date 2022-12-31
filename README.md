# Python Project Template

## Included features

* Basic python project
* VSCode dev container configuration
* docker image
* pytest
* pre-commit
    * Remove trailing whitespaces
    * Fix end of file
    * Check yaml
    * Check for lage files
    * autopep8
    * isort
    * flake8
* Makefile
    * `install` to install python packages for developement
    * `test` to run pytest
    * `lint` to run pre-commit
    * `image` to build docker image
* Github workflows
    * Run tests and linting
    * Build and push multi-arch docker images
