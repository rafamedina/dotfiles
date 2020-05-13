#!/bin/sh

if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=$(git hash-object -t tree /dev/null)
fi

if !(git diff --name-only --diff-filter=AM $against | grep -E '.clj[cs]?$' | xargs clj-kondo --lint)
then
    echo
    echo "Error: new <clj-kondo> errors found. Please fix them and retry again."
    exit 1
  elif !(lein kibit)
  then
    echo
    echo "Error: new <lein kibit> errors found. Please fix them and retry again."
    exit 1
  else
    echo "Clean, no errors"
fi

exec git diff-index --check --cached $against --
