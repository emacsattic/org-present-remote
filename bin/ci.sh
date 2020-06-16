#!/usr/bin/env bash

set -euxo pipefail

apt update -qq
apt upgrade -y

apt install -y \
    curl \
    emacs-nox

emacs --version

emacs \
    -batch \
    -l tests/test-setup.el \
    -l org-present-remote.el \
    -l tests/lint-tests.el

emacs \
    -batch \
    -l tests/test-setup.el \
    -l ert \
    -l org-present-remote.el \
    -l tests/integration-tests.el \
    -f ert-run-tests-batch-and-exit
