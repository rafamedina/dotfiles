#!/bin/sh

if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=$(git hash-object -t tree /dev/null)
fi

found=0

echo
echo "🔭 Finding weird 👾things"
echo
echo "🚀 Launching: <clj-kondo>"
if !(git diff --name-only --diff-filter=AM $against | grep -E '.clj[cs]?$' | xargs clj-kondo --lint)
then
    echo "🚨 Error: <clj-kondo> found errors. Please fix them and retry again."
  ((found+=1))
else
  echo "✅ Clean: <clj-kondo>"
fi
echo
echo "🚀 Launching: <lein kibit>"
if !(lein kibit)
  then
    echo "🚨 Error: <lein kibit> found errors. Please fix them and retry again."
  ((found+=1))
  else
  echo "✅ Clean: <lein kibit>"
fi

if [[ $found -gt 0 ]]; then
  echo "🔥 Errors!"
fi

exec git diff-index --check --cached $against --
