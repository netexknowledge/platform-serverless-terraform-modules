#!/bin/bash

# Update all README.md files in all folders in current directory that start by `aws-`
for dir in ./aws-*; do
  dir=${dir%*/}
  dir=${dir##*/}
  cd $dir
  terraform-docs -c _tf_docs_cfg.yml .
  cd ..
done
