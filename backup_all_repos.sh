#!/bin/bash

# Replace with your GitHub username and personal access token
GITHUB_USERNAME="your_username"
GITHUB_TOKEN="your_personal_access_token"

# Fetch all repository clone URLs using GitHub API
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100 | jq -r '.[].clone_url')

# Loop through each repository URL and clone it
for repo in $repos
do
  echo "Cloning repository: $repo"
  git clone $repo
done
