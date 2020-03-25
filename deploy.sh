#!/bin/bash
ansible-playbook /var/lib/jenkins/workspace/dockerCompose/playbook.yml -i /var/lib/jenkins/workspace/dockerCompose/inventory --private-key /var/lib/jenkins/workspace/devOps.pem -u ec2-user || exit 0
echo "Deploy Success" || exit 0
