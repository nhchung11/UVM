echo "Enter your commit message:"
read message

# Add all files to the staging area
git add .

# Remove any .ucdb, .qbd, .qpg, and .qtl files
find . -type f \( -name "*.ucdb" -o -name "*.qbd" -o -name "*.qpg" -o -name "*.qtl" \) -exec git rm --cached {} \;

# Commit the changes
git commit -m "${message}"

# Check the status
if [ -n "$(git status --porcelain)" ];
then
    echo "Changes not staged for commit"
    git status
else
    echo "IT IS CLEAN"
    echo "Pushing data to remote server!!!"
    git push -u origin master
fi