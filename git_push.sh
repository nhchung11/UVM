git rm --cached -r .

# Add only .sv and .v files to the staging area
find . -type f \( -name "*.sv" -o -name "*.v" \) -exec git add {} \;

# Commit the changes
git commit -m "git add reset testcase"

# Check the status
if [ -n "$(git status --porcelain)" ];
then
    echo "Changes not staged for commit"
    git status
else
    echo "IT IS CLEAN"
    echo "Pushing data to remote server!!!"
    git push origin master
fi