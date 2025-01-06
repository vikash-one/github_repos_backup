To ensure you take a full backup of all your repositories locally **before deletion**, here's the complete process, including steps to back up all repositories and then proceed with the deletion.

### Step 1: **Generate Personal Access Token (PAT)**

Before proceeding with cloning or deleting repositories, you need to create a GitHub Personal Access Token (PAT) for authentication, as GitHub no longer supports using your username and password for API requests.

1. **Go to GitHub**: Log in to your GitHub account at [GitHub](https://github.com).
2. **Generate a new token**:
   - Click on your profile icon in the top-right corner, then go to **Settings**.
   - From the sidebar, go to **Developer Settings**.
   - Click on **Personal Access Tokens** > **Tokens (classic)**.
   - Click **Generate new token**, select the **repo** scope (this will give the token permission to access repositories), and create it.
   - Copy the generated token—**you won’t be able to see it again**.

---

### Step 2: **Backup All Repositories Locally**

You’ll need to clone all your GitHub repositories to your local machine before deleting them.

#### a. **Script to Backup All Repositories**

You can use a script to automate the cloning of all your repositories. Here's a script to do this.

1. **Create a backup directory** on your local machine where all repositories will be saved:

   ```bash
   mkdir ~/github_repos_backup
   cd ~/github_repos_backup
   ```

2. **Backup Script**:

   Create a script (`backup_all_repos.sh`) to clone all repositories to your local machine:

   ```bash
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
   ```

   Replace:
   - `your_username` with your GitHub username.
   - `your_personal_access_token` with the PAT you generated.

3. **Make the script executable**:

   ```bash
   chmod +x backup_all_repos.sh
   ```

4. **Run the script** to clone all your repositories:

   ```bash
   ./backup_all_repos.sh
   ```

This will clone all repositories to the `~/github_repos_backup` directory.

---

### Step 3: **Confirm All Repositories Are Cloned**

After running the script, check that all repositories have been cloned into your backup directory:

```bash
ls ~/github_repos_backup
```

Each repository should now be listed there.

---

### Step 4: **Delete All Repositories**

Once you’ve confirmed that all repositories are backed up, you can proceed to delete them.

#### a. **Script to Delete All Repositories**

Now that your repositories are backed up, you can delete them using the following script.

1. **Create the delete script** (`delete_all_repos.sh`):

   ```bash
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
   ```

   Replace `your_username` and `your_personal_access_token` as before.

2. **Make the script executable**:

   ```bash
   chmod +x delete_all_repos.sh
   ```

3. **Run the script to delete all repositories**:

   ```bash
   ./delete_all_repos.sh
   ```

This will loop through each of your repositories and delete them from your GitHub account.

---

### Step 5: **Verify Deletion**

Once the deletion script has run, verify that all repositories have been deleted by visiting the **Repositories** section of your GitHub account. It should be empty if the deletion was successful.

---

### Step 6: **(Optional) Recreate Repositories**

If you'd like to recreate any of the repositories, you can either manually create them via the GitHub web interface or use the GitHub API to automate the creation. For example:

```bash
curl -X POST -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -d '{"name": "new-repository-name", "private": false}' \
  https://api.github.com/user/repos
```

Replace `YOUR_GITHUB_TOKEN` with your new token and `new-repository-name` with the name of the new repository.

---

### Conclusion

By following these steps, you:
1. **Create a backup** of all your GitHub repositories locally before deletion.
2. **Delete all repositories** from your GitHub account using the provided script.

Ensure you verify that all repositories are backed up before deleting them to avoid losing any important data. Let me know if you have any questions or need further assistance!
