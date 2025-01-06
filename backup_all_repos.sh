#!/bin/bash

# Replace with your GitHub username and personal access token
GITHUB_USERNAME="vikash-one"
GITHUB_TOKEN="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" #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

# Fetch all repository clone URLs using GitHub API
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100 | jq -r '.[].clone_url')

# Loop through each repository URL and clone it
for repo in $repos
do
  echo "Cloning repository: $repo"
  git clone $repo
done
