branch=$(cat whoami)-$(git log --format="%H" -n 1 | head -c 8)
git checkout -b $branch
git add .
git commit -m "$whoami-init"
git push -u origin $branch

git branch -M main
git push heroku main
git branch -M $branch