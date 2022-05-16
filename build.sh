#!/bin/bash

# if we are in a release branch ...
branch_name=$(git rev-parse --abbrev-ref HEAD)
if [[ $branch_name == *"release"* ]]; then
  # ... then cut out and save the release version number
  # example: release-1.01 will cut out 1.01
  release_version=$(echo $branch_name | cut -f2 -d"-")
fi
echo Release Version is "'$release_version'"

zip_filename="MarkFolderRead"
if [ ! -z "$release_version" -a "$release_version" != " " ]; then
  zip_filename=$zip_filename-$release_version
fi
echo Zip file name is "'$zip_filename'"

rm -f MarkFolderRead*.xpi
cd src
zip -r ../$zip_filename.xpi ./*
cd ..
mv MarkFolderRead*.xpi build
