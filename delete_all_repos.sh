#!/bin/bash

# Replace with your GitHub username and personal access token
GITHUB_USERNAME="your_username"
GITHUB_TOKEN="your_personal_access_token"

# Fetch all repositories
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100 | jq -r '.[].name')

# Loop through each repository and delete it
for repo in $repos
do
  echo "Deleting repository: $repo"
  curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$GITHUB_USERNAME/$repo
done
