#!/bin/bash

set -e

[ -f "$1" ]

HTML_FILE="`mktemp -p '/tmp' 'chrome-wrapper.XXXX.html'`"

printf "\033[0;1;32mCreating temporary file ... "
cp -v "$1" "$HTML_FILE"

printf "\033[0;32mOpening attachment '%s' in Google Chrome.\n\n\033[0;36m" \
	"$HTML_FILE"
google-chrome-unstable "$HTML_FILE"

printf "\n\033[0;33mRemoving temporary file ... \033[0;31m"
rm -v "$HTML_FILE"
printf "\033[0m\n"

