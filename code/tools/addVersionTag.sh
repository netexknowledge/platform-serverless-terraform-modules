#!/bin/bash

# This script is used to add a new git tag format aws-folder@version incrementing the previous version by 1

# Optional folder parameter where the tag will be incremented
if [ -z "$1" ]
  then
    path="./aws-*"
  else
    path=$1
fi

# IF path is not "./aws-*" check if git tag exists and increment the version number by 1
if [ "$path" != "./aws-*" ]
then
    # Check if git tag exists
    if git rev-parse "$path@*" >/dev/null 2>&1
    then
        # Get the latest tag for the path
        latestTag=$(git tag -l "$path@*" | grep -v latest | sort -V | tail -n 1)
        # Get the version number from the tag name
        version=${latestTag##*@}
        # Split the version number into major, minor, and patch
        IFS='.' read -ra ADDR <<< "$version"
        # If major and minor versions are empty, set them to 0
        ADDR[0]=${ADDR[0]:-0}
        ADDR[1]=${ADDR[1]:-0}
        # Increment the patch version by 1
        newPatch=$((ADDR[2]+1))
        # Reconstruct the version number
        newVersion="${ADDR[0]}.${ADDR[1]}.$newPatch"
        # Generate the new tag name
        newTag=$path@$newVersion
        # Add the new tag
        git tag -a $newTag -m "$path version $newVersion"
        exit 0
    else
        echo "Init tag $path ..."
        git tag -a $path@0.0.1 -m "$path version 0.0.1"
        exit 0
    fi
fi

# Loop all folders in current directory that start by `aws-`
for dir in ./aws-*; do
  dir=${dir%*/}
  dir=${dir##*/}
  # Get newest tag name not named latest
  latestTag=$(git tag -l "$dir@*" | grep -v latest | sort -V | tail -n 1)
  # Get the version number from the tag name
  version=${latestTag##*@}
  # Split the version number into major, minor, and patch
  IFS='.' read -ra ADDR <<< "$version"
  # If major and minor versions are empty, set them to 0
  ADDR[0]=${ADDR[0]:-0}
  ADDR[1]=${ADDR[1]:-0}
  # Increment the patch version by 1
  newPatch=$((ADDR[2]+1))
  # Reconstruct the version number
  newVersion="${ADDR[0]}.${ADDR[1]}.$newPatch"
  # Generate the new tag name
  newTag=$dir@$newVersion
  # Add the new tag
  git tag -a $newTag -m "$dir version $newVersion"
done
