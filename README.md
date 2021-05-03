# AutoCarousellTracker with Local Airflow

## Set-Up

- run on local (start.sh)
  - heroku create <app_name>
  - heroku addons:create heroku-postgresql:hobby-dev
  - heroku config:set $var=$(heroku config:get DATABASE_URL)
- run in heroku (init.sh)
  - cd into app
