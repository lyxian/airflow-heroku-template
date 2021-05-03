git checkout -b $(cat whoami)-$(git log --format="%H" -n 1 | head -c 8)
git add .
git commit -m "$whoami-init"
git push

git branch -M main
git push heroku main
git branch -M $whoami