#!/bin/bash
try {
ansible-playbook /var/lib/jenkins/workspace/dockerCompose/playbook.yml -i /var/lib/jenkins/workspace/dockerCompose/inventory --private-key /var/lib/jenkins/workspace/devOps.pem -u ec2-user
} catch(e) {
build_ok = false
echo e.toString()
}
echo "Deploy Success" || exit 0
