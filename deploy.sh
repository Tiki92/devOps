#!/bin/bash

deploy() {
ansible-playbook /var/lib/jenkins/workspace/dockerCompose/playbook.yml -i /var/lib/jenkins/workspace/dockerCompose/inventory --private-key /var/lib/jenkins/workspace/devOps.pem -u ec2-user &
BACK_PID=$!
while kill -0 $BACK_PID ; do
    echo "Process is still active..."
    sleep 1
done
echo "Deploy Success"
return 0
}

deploy

