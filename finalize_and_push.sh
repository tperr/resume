#!/bin/bash
cp resume.pdf tim_perr_resume.pdf
magick resume.pdf resume.jpg
if [ $? -ne 0 ]; then
    echo "Failed to convert pdf to jpg, continue? (Y/n)"
    read answer
    if [[ "$answer" == "n" || "$answer" == "N" ]]; then
        echo "Aborting."
        exit 1
    fi
fi
git status
echo "Commit all changes? (Y/n)"
read answer
if [[ "$answer" == "n" || "$answer" == "N" ]]; then
    echo "Aborting commit."
    exit 0
fi
git add .
git commit -m "Updated resume $(date +'%d/%m/%y')"
if [ $? -ne 0 ]; then
    echo "Commit failed. Aborting push."
    exit 1
fi
git push origin main
if [ $? -ne 0 ]; then
    echo "Push failed."
    exit 1
fi
echo "Pushed to GitHub successfully."