# tf-ec2-ubuntu-ts
Terraform project to stand up EC2 instance and configure it with Ansible.

Terraform will find the most up to date Ubuntu image and use that. An AWS security 
group is specified that allows ssh access from a specific address and all outgoing 
traffic.

## Get started
Configure the project:  

1. Install AWS CLI and Terraform
2. Make a copy of example.terraform.tfvars and rename to terraform.tfvars
3. Configure terraform.tfvars and variables.tf to your liking
4. Make a copy of ansible/example.external_vars.yml and rename 
to ansible/external_vars.yml
5. Add a Tailscale authentication key here if you are starting Tailscale from 
the playbook. If no auth key is specified Ansible will not start the 
service. (Take care with auth keys - https://tailscale.com/kb/1085/auth-keys/)

## Useful Terraform commands

`terraform init`  
`terraform fmt`  
`terraform validate`  
`terraform apply`  
`terraform show`  
`terraform state list`  
`terraform output`  
`terraform destroy`  

## Links
Some useful links:  

Install Terraform - https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started  
Get Started - AWS - https://learn.hashicorp.com/collections/terraform/aws-get-started  
Learn Terraform Resources - https://github.com/hashicorp/learn-terraform-resources  
Define Infrastructure with Terraform Resources - https://learn.hashicorp.com/tutorials/terraform/resource?in=terraform/configuration-language  
Configuration with Variables - https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language  
Sensitive Input Variables - https://learn.hashicorp.com/tutorials/terraform/sensitive-variables?in=terraform/configuration-language  
http Data Source - https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http  
Provision Infrastructure with Cloud-Init - https://learn.hashicorp.com/tutorials/terraform/cloud-init?in=terraform/provision  
Introduction to Vault - https://learn.hashicorp.com/tutorials/vault/getting-started-intro?in=vault/getting-started  
aws_instance - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance  
describe-images - https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html  

Ansible and Terraform - Better Together - https://github.com/scarolan/ansible-terraform  
