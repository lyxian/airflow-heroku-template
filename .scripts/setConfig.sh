#!/bin/bash

function setHerokuConfig {
if [[ $(heroku config:set $1=$2) ]]
then
echo "Sucess...$var set"
else
echo "Error...$var not set"
fi
}

env=$(cat .env)

for value in ${env[@]}
do 
key=$(echo $value | cut -d "=" -f 1)
val=$(echo $value | cut -d "=" -f 2)
echo $(setHerokuConfig $key $val)
done

echo "Done..."