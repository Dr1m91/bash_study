#!/bin/bash
# Look for folder "dr" in home folders
read p
if [ -e /home/$p ];
then
echo "Found it"
else
echo "No dr in home folders"
fi
