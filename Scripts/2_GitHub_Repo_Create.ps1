# Authenticate to GitHub
gh auth login

# Create a new repository
gh repo create "GitHub-Secrets-Demo-2024" --public --description "Azure Key Vault Integrated Test Repository"

# Clone the new repository (Replace <your-username-Orgname> with your actual GitHub username.)
# cd "C:\Users\source\repos" #(Uncomment to navigate to the directory where you want to clone the repository.)
git clone "https://github.com/<your-username-Orgname>/GitHub-Secrets-Demo-2024.git"
cd "GitHub-Secrets-Demo-2024"

# Create a new file and add content
echo "# Key Vault Integration Test Repo" > README.md

# Add the file to the staging area
git add README.md

# Commit the file
git commit -m "Initial commit"

# Push the changes to GitHub (If you are not using the main branch, replace 'master' with your branch name. e.g. 'main')
git push origin master # (Replace 'master' with your branch name if different.)