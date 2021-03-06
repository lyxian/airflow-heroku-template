echo "Enter app name: "
read app

if [[ $(heroku create $app --buildpack heroku/python) ]]
then
echo "App created successfully"
else
echo "App not created...Try again"
exit
fi

branch=$app-$(git log --format="%H" -n 1 | head -c 8)
git checkout -b $branch

echo $app > whoami

heroku addons:create heroku-postgresql:hobby-dev --app $app 

var=AIRFLOW__CORE__SQL_ALCHEMY_CONN
if [[ $(heroku config:set $var=$(heroku config:get DATABASE_URL --app $app) --app $app) ]]
then
echo "Sucess...$var set"
else
echo "Error...$var not set"
exit
fi

echo "
----Local Set-up Done----"