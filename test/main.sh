#!/usr/bin/env bash

SRC=$(cd $(dirname "$0"); pwd)
source "${SRC}/bash/include.sh"

echo "####################### DEBUG ############################"
echo "PM2 Command = " $pm2
echo "Node version = " $nodeVersion
$node -e "var os = require('os'); console.log('arch : %s\nplatform : %s\nrelease : %s\ntype : %s\nmem : %d', os.arch(), os.platform(), os.release(), os.type(), os.totalmem())"
echo "###################### !DEBUG! ###########################"


bash ./test/bash/cli.sh
spec "CLI basic test"
bash ./test/bash/json_file.sh
spec "JSON file test"
bash ./test/bash/harmony.sh
spec "Harmony test"
bash ./test/bash/log-custom.sh
spec "Custom log timestamp"
bash ./test/bash/reload.sh
spec "Reload"
bash ./test/bash/right-exit-code.sh
spec "Verification exit code"
bash ./test/bash/log-reload.sh
spec "Log reload"
bash ./test/bash/gracefulReload.sh
spec "gracefulReload system 1"
bash ./test/bash/gracefulReload2.sh
spec "gracefulReload system 2"
bash ./test/bash/gracefulReload3.sh
spec "gracefulReload system 3"
bash ./test/bash/cli2.sh
spec "Second hard cli tests"
bash ./test/bash/misc.sh
spec "MISC features"
bash ./test/bash/fork.sh
spec "Fork verified"
bash ./test/bash/infinite_loop.sh
spec "Infinite loop stop"

$pm2 kill
