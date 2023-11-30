#!/bin/bash

# This script is used to remove all git tags latest and generate all new git tags format aws-folder@latest

# Remove all tags aws-folder@latest
git tag -l | grep latest | xargs git tag -d

# Remove all tags aws-folder@latest from remote
git tag -l | grep latest | xargs git push --delete origin

# Generate all new tags aws-folder@latest form all folders in current directory that start by `aws-`
for dir in ./aws-*; do
  dir=${dir%*/}
  dir=${dir##*/}
  git tag -a $dir@latest -m "latest tag for $dir"
done
