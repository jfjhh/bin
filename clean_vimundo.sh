#!/bin/bash
#
# Extraneous vim ghost file cleaner.
# Alex Striff
#
# Removes all extraneous vimundo files from users ~/.vimundo directory.
# Also prunes off files from :mkview if they exist (in ~/.vim/view).
#

REAL_MKVIEW=""
REAL_VIMUNDO=""
DELETED_VIEW=0
DELETED_VIMUNDO=0

# :mkview stores paths as "~=+home=+user=+foo.txt", so convert to path.
function mkview_to_path()
{
	REAL_MKVIEW="`echo \"$1\" \
		| sed -e 's/=//g' -e 's/+/\//g' -e \"s%\~%${HOME}%g\"`"
}

# .vimundo stores paths as "%home%user%foo.txt", so convert to path.
function vimundo_to_path()
{
	REAL_VIMUNDO="`echo \"$1\" | sed 's/\%/\//g'`"
}

# :mkview files.
if [ -d "$HOME/.vim/view" ]; then
	FILES="`ls $HOME/.vim/view`"
	for i in $FILES; do
		mkview_to_path $i
		if [ ! -f "${REAL_MKVIEW}" ]; then
			rm -v "$HOME/.vim/view/${i}" && let DELETED_VIEW++
		fi
	done
fi

# Vimundo files.
if [ -d "$HOME/.vimundo" ]; then
	FILES="`ls $HOME/.vimundo`"
	for i in $FILES; do
		vimundo_to_path $i
		if [ ! -f "${REAL_VIMUNDO}" ]; then
			FILE="`echo ${i} | sed 's/\//\%/g'`"
			rm -v "$HOME/.vimundo/${i}" && let DELETED_VIMUNDO++
		fi
	done
fi

echo "$DELETED_VIMUNDO vimundo and $DELETED_VIEW :mkview ghost files deleted."

