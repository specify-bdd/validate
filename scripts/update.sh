#!/bin/bash

VERSION="$1"

# strip initial "v" from first argument, if present
if [[ "$VERSION" = v* ]]; then
    VERSION="${VERSION:1}"
fi

# require a first argument
if [[ -z "$VERSION" ]]; then
    echo "Version argument required."
    exit 1
fi

# update all packages
for DEP_PATH in $(npm ls --parseable --package-lock-only | tail -n+2); do
    PKG_NAME="$(basename $DEP_PATH)"
    PKG_SCOPE="$(basename $(dirname $DEP_PATH))"
    PKG_ID="$(printf "%s/%s@%s" "$PKG_SCOPE" "$PKG_NAME" "$VERSION")"

    echo "Installing $PKG_ID" 
    npm i $PKG_ID
done
