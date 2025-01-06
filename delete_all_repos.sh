#!/bin/bash

# Replace with your GitHub username and personal access token
GITHUB_USERNAME="vikash-one"
GITHUB_TOKEN="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"

# Fetch all repositories
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100 | jq -r '.[].name')

# Loop through each repository and delete it
for repo in $repos
do
  echo "Deleting repository: $repo"
  curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$GITHUB_USERNAME/$repo
done
