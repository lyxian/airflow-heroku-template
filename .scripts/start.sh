echo "Enter app name: "
read app

if [[ $(heroku create $app) ]]
then
echo "App created successfully"
else
echo "App not created...Try again"
exit
fi

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