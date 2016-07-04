#!/bin/bash
git fetch
git remote prune origin
for BRANCH in $(git branch -r --merged origin/master | grep druid | sed "s#origin/##")
do
   echo "Removing $BRANCH"
   git push origin ":$BRANCH"
done
