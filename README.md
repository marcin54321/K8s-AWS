# K8s-AWS
Kubernetes cluster deployment in AWS cloud. This is a demo repository.

## Prerquisites
* Sign up AWS account and create an IAM user
* Deploy a bastion Ubuntu based host. You can use one of public cloud image avaiable in the internet
* Install required packages
 ```
 ./install_sofware.sh
 ```
* Set up awscli for your IAM user
```
ubuntu@bastion: aws configure --profile terraform_iam_user
AWS Access Key ID [***********PYQA]:
AWS Secret Access Key [**************7lOb]:
Default region name [eu-central-1]:
Default output format [json]:
ubuntu@bastion:
```
 ## Deploy K8s cluster in AWS
 Run the following commands:
 ```
 cd terraform
 terraform install
 terraform plan
 terraform apply -auto-approve
 ```
