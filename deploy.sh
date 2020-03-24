#!/bin/bash
ansible-playbook playbook.yml --private-key /home/ec2-user/AWS_Ansible/aws_devOps.pem -u ec2-user  --vault-password-file /home/ec2-user/AWS_Ansible/vault.pass

