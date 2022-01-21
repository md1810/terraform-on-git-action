#!/bin/sh -l
git clone https://github.com/md1810/terraform-on-git-action.git
cd terraform-on-git-action/terraform
terraform init && terraform state replace-provider registry.terraform.io/-/aws registry.terraform.io/hashicorp/aws -auto-approve
terraform init && terraform destroy -auto-approve
