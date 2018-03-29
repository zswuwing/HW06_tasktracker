#!/bin/bash

export PORT=5103
export MIX_ENV=prod
export GIT_PATH=/home/tasktracker/src/part2/tasktracker

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasktracker" ]; then
	echo "Error: must run as user 'tasktracker'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/part2/www
mkdir -p ~/part2/old

NOW=`date +%s`
if [ -d ~/part2/www/tasktracker ]; then
	echo mv ~/part2/www/tasktracker ~/part2/old/$NOW
	mv ~/part2/www/tasktracker ~/part2/old/$NOW
fi

mkdir -p ~/part2/www/tasktracker
REL_TAR=~/src/part2/tasktracker/_build/prod/rel/tasktracker/releases/0.0.1/tasktracker.tar.gz
(cd ~/part2/www/tasktracker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasktracker/src/part2/tasktracker/start.sh
CRONTAB

#. start.sh
