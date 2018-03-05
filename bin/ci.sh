#!/usr/bin/env sh

set -e

apt update -qq
apt install -y emacs-nox

emacs -batch -l ert -l org-present-remote.el -l unit-tests.el -l integration-tests.el -f ert-run-tests-batch-and-exit
