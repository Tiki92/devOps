#!/bin/bash
ansible-playbook playbook.yml -i ./inventory --private-key /home/ec2-user/AWS_Ansible/aws_devOps.pem -u ec2-user  --vault-password-file /var/lib/jenkins/workspace/vault.pass

