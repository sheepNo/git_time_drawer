#!/bin/bash

img=( 0 0 4 0 0 0 0
      0 0 0 4 4 0 0
      0 4 4 3 3 4 0
      4 3 3 3 3 3 4
      4 2 2 0 2 4 0
      4 2 2 2 1 4 0
      4 2 2 2 1 2 4
      0 4 2 0 2 4 0
      0 0 4 4 4 0 0 )

echo "Make sure you've created a new project on GitHub first."

read -p "username " username
read -p "github project " project
read -p "highest number of commit in a day " max

echo "Cloning repository..."
git clone git@github.com:$username/$project.git

read -p 'starting epoch (e.g. date --date "20180506 0042" +%s)' epoch

echo "Moving to $project..."
cd $project

echo "Saying hi..."
echo "Hi."

echo "Creating dummy commits..."
for i in "${img[@]}"; do
    for ((commit = 0; commit < i*max; commit++)); do
        GIT_AUTHOR_DATE="$(LC_ALL=en_US date --date=@$epoch)" GIT_COMMITTER_DATE="$(LC_ALL=en_US date --date=@$epoch)" git commit --allow-empty -m "empty commit"
        echo $commit $(LC_ALL=en_US date --date=@$epoch)
    done
    epoch=$((epoch + 86400))
done

echo "Pushing..."
git push
echo "Done! Enjoy your new banner."
