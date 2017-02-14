chown -R buildbot /buildbot-worker/
cp /buildbot/buildbot.tac /buildbot-worker/
cd /buildbot-worker
exec su buildbot -c "twistd -ny buildbot.tac"
