#! /bin/bash

params="-sf"

for i in profile bash emacs 
do
 stow $i 
done
