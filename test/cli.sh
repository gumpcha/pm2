
#!/usr/bin/env bash

#
# cli-test: Tests for god
#
# (C) 2013 Unitech.io Inc.
# MIT LICENSE
#

# Yes, we have tests in bash. How mad science is that?


node="`type -P node`"
pm2="`type -P node` `pwd`/bin/pm2"

script="echo"

file_path="test/fixtures"

function fail {
  echo -e "\033[31m  ✘ $1\033[0m"
  exit 1
}

function success {
  echo -e "\033[32m  ✔ $1\033[0m"
}

function spec {
  [ $? -eq 0 ] || fail "$1"
  success "$1"
}

function ispec {
  [ $? -eq 1 ] || fail "$1"
  success "$1"
}


echo -e "\033[1mRunning tests:\033[0m"




cd $file_path

$pm2 kill
spec "kill daemon"

$pm2
ispec "No argument"

$pm2 start cluster-pm2.json
spec "Should start well formated json with name for file prefix"

$pm2 list
spec "Should list processes succesfully"

$pm2 start multi-echo.json
spec "Should start multiple applications"

$pm2 generate echo
spec "Should generate echo sample json"

$pm2 start echo-pm2.json -f
spec "Should start echo service"

$pm2 logs &
spec "Should display logs"
TMPPID=$!

sleep 2

kill $!
spec "Should kill logs"

$pm2 stop
spec "Should stop all processes"

$pm2 list
spec "Should list nothing"

$pm2 flush
spec "Should clean logs"

$pm2 kill
spec "Should kill daemon"
