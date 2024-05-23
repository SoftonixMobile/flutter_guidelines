#!/bin/sh

echo Marking all hooks as executable...

find scripts/hooks/ -type f -exec chmod +x {} \;

echo Moving all hooks to .git/hooks/

rsync -P scripts/hooks/* .git/hooks/