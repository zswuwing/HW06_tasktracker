#!/bin/bash

export PORT=5103

cd ~part2/www/tasktracker
./bin/part2/tasktracker stop || true
./bin/part2/tasktracker start

