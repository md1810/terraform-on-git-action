#!/bin/sh -l
git clone https://github.com/md1810/terraform-on-git-action.git
cd terraform-on-git-action
terraform init && terraform destroy -auto-approve