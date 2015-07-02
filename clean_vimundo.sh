#!/bin/bash
#
# Removes all extraneous vimundo files from users ~/.vimundo directory.
# TODO: Also prune off files from :mkview if they exist.
#

DELETED=0

# Vimundo stores paths as "%home%user%foo.txt", so convert '%' to '/'.
for i in `ls "$HOME/.vimundo" | sed 's/\%/\//g'`; do
	if [ ! -f "${i}" ]; then
		FILE="`echo ${i} | sed 's/\//\%/g'`"
		rm -v "$HOME/.vimundo/$FILE" && let DELETED++
	fi
done

echo "$DELETED extraneous vimundo files deleted."

