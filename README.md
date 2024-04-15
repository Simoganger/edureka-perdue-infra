## ABC Technologies IaC Project

### Introduction

This is the Terraform infrastructure of my Edureka - Perdue Post Graduate Program in DevOps Industry Grade Project. It contains the AWS resources needed to complete the tasks. Though some additional configurations will be done manually (configuring Jenkins and Ansible Servers, then creating and configuring monitoring ressources), our objective here is just to automate the initial building block of our project and apply our Terraform knowledge we learned through the program. 

### Project structure

This project is a Terraform project with a local back-end state management and has the following files:

- `0-providers.tf`: this is the initial aws provider configuration.
- `1-vpc.tf`: contains the vpc in which all the resources will be launched.
- `2-igw.tf`: define the internet gateway for the define vpc.
- `3-subnets.tf`: define private and public subnets for resources management.
- `4-nat.tf`: define nat gateway for private subnets out trafic.
- `5-routes.tf`: define public and private route tables for the infrastructure.
- `6-eks.tf`: define the eks cluster.
- `7-nodes.tf`: define a node group for the eks cluster nodes.
- `8-iam-oidc.tf`: create the OpenID Connect for the eks cluster.
- `9-prometheus.tf`: create prometheus resources.
- `10-iam-prometheus.tf`: create IAM roles for prometheus.
- `11-iam-grafana.tf`: create IAM roles for grafana.
- `12-ec2-sg.tf`: create security group for EC2 servers (Jenkins and Ansible servers).
- `13-jenkins.tf`: create and provision the Jenkins server.
- `14-ansible.tf`: create and provision the Ansible server.
- `variables.tf`: contains all the variables we are using in the project to apply de DRY (Don't Repeat Yourself) principle.
- `ansible.sh`: contains the bash script needed to provision our Ansible server EC2 instance with the required tools.
- `jenkins.tf`: contains the bash script needed to provision our Jenkins server EC2 instance with the required tools.
- `terraform.tfstate`: this is the state file for our terraform infrastructure. This can be recreated for anyone who want to use the infrastructure for his own account. So the file might not exist in the project folder right now, but that will be created when `terraform apply` is issued.
- Other files and folder will appear when terraform commands of the following section are issued. Like the folder `.terraform` and the files `terraform.tfstate, terraform.tfstate.backup, .terraform.lock.hcl`.

### Running the project

To run the project and be able to create the infrastructure described here, one should follow these steps:

- Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) locally.
- Have a valid AWS account (head over the [AWS portail](https://aws.amazon.com/) to create an account).
- Install AWS CLI and configure a profile with valid AWS credentials (the complete guide available [at this link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)).
- Set the newly configured profile name in the `variables.tf` file on this line `default = "default"` (here my profile name is `"default"`).
- Run the `terraform init` command to initialize the provider and install plugins.
- Run the `terraform plan` command to build a creation plan.
- Run the `terraform apply` command to create the infrastructure on your AWS account. This will ask for a confirmation, type `yes` to validate.
- In case you need to remove all the ressources created, the `terraform destroy` command will be of good help.
- At any moment of your infrastructure development, you can use both `terraform validate` and `terraform fmt` to validate the syntax and format the terraform code respectively. 

