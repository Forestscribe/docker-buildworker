#!/bin/sh
cp /buildbot/buildbot.tac /buildbot-worker/
cd /buildbot-worker
exec /usr/local/bin/dumb-init twistd -ny buildbot.tac
