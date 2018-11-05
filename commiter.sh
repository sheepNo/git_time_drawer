#!/bin/bash

echo "Make sure you've created a new project on GitHub first."

read -p "username " username
read -p "github project " project
read -p "highest number of commit in a day " max

echo "Cloning repository..."
git clone git@github.com:$username/$project.git

read -p 'starting epoch (e.g. date --date "20180506 0042" +%s)' epoch

echo "Moving to $project/..."
cd $project

echo "Creating dummy commits..."
# skips the first lines of the pgm file
convert ../img.pgm -compress None -transpose ../t_img.pgm
tail -n +5 ../t_img.pgm | while read line; do
    echo $line
    for pixel in $line; do
        echo $pixel
        case $pixel in
            237 )
                echo "hi"
                i=0
                echo $i
            ;;
            217 )
                i=1
            ;;
            183 )
                i=2
            ;;
            134 )
                i=3
            ;;
            84 )
                i=4
            ;;
        esac
        echo $i
        # C for syntax
        for ((commit = 0; commit < i*max; commit++)); do
            GIT_AUTHOR_DATE="$(LC_ALL=en_US date --date=@$epoch)" GIT_COMMITTER_DATE="$(LC_ALL=en_US date --date=@$epoch)" git commit --allow-empty -m "empty commit"
            # echo $commit $(LC_ALL=en_US date --date=@$epoch)
        done
        epoch=$((epoch + 86400))
    done
done

echo "Pushing..."
git push
echo "Done! Enjoy your new banner."
