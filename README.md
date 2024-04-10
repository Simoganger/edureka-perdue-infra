### ABC Technologies IaC Project

#### Introduction

This is the Terraform infrastructure of my Edureka - Perdue Post Graduate Program in DevOps Industry Grade Project. It contains the AWS resources needed to complete the tasks. Though some additional configurations will be donne manually (configuring Jenkins and Ansible Servers or creating the Elastic Kubernetes Service cluster), our objective here is just to automate the initial building block of our project and apply our Terraform knowledge we learned through the program. 

#### Project Structure

This project is a basic Terraform project with a local back-end state management and has the following files:

- `main.tf`: this is the main file of the infrastructure containing an EC2 instance, a security group for that instance, a S3 bucket for any future artifacts management and role configuration associated to these services.
- `providers.tf`: this is the initial aws provider configuration.
- `variables.tf`: contains all the variables we are using in the project to apply de DRY (Don't Repeat Yourself) principle.
- `install.sh`: contains the bash script needed to provision our EC2 instance with the required tools.
- `terraform.tfstate`: this is the state file for our terraform infrastructure. This can be recreated for anyone who want to use the infrastructure for his own account. So the file might not exist in the project folder right now, but that will be created when `terraform apply` is issued.
- Other files and folder will appear when terraform commands of the following section are issued. Like the folder `.terraform` and the files `terraform.tfstate, terraform.tfstate.backup, .terraform.lock.hcl`.

#### Running the Project

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

