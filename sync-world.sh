#!/bin/bash
# Minecraft World Sync Script
# Usage: ./sync-world.sh [pull|push] [commit message]

if [ "$1" == "pull" ]; then
    echo "Pulling latest world files from GitHub..."
    git pull origin main
    if [ $? -eq 0 ]; then
        echo "World files updated successfully!"
    else
        echo "Error pulling world files. Please check your connection and try again."
        exit 1
    fi
elif [ "$1" == "push" ]; then
    echo "Adding world files..."
    git add world/
    
    if [ -z "$2" ]; then
        commit_msg="Update world files - $(date)"
    else
        commit_msg="$2"
    fi
    
    echo "Committing changes..."
    git commit -m "$commit_msg"
    
    if [ $? -eq 0 ]; then
        echo "Pushing to GitHub..."
        git push origin main
        if [ $? -eq 0 ]; then
            echo "World files pushed successfully!"
        else
            echo "Error pushing to GitHub. Please check your connection and try again."
            exit 1
        fi
    else
        echo "No changes to commit or commit failed."
        exit 1
    fi
else
    echo "Usage:"
    echo "  ./sync-world.sh pull                    - Pull latest world files"
    echo "  ./sync-world.sh push \"commit message\"  - Push world files with message"
    echo "  ./sync-world.sh push                    - Push world files with auto message"
    exit 1
fi

