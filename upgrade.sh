#!/bin/sh

cd modules
arr=$(ls)
for package in $arr
do
   if [ -d $package ]; then
      echo "=== $package ==="
      cd $package && pub upgrade $1
      cd ..
   fi
done
cd ..
pub upgrade
