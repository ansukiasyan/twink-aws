# Create a web server in AWS using terraform

The goal of the project is to create an EC2 web server that reads a simple html file from the S3 bucket.

## S3 bucket 

S3 bucket has versioning enabled, in order to store updates of the html file. If the html file is modified, terraform will detect the changes automatically and a new version will be stored in the bucket by running the terraform apply command. 

A lifecycle rule is configured for the S3 bucket. Any objects stored in the bucket will be removed from 7 days after creation, older versions included. 

## EC2 instance

EC2 instance is a vm running Apache. It has a bootstraping bash script that will get the html file from the S3 bucket and serve it via Apache web server.

SSH is configured for the instance. A public key can be uploaded by passing the value as shown below:

```bash
$ terraform apply -var="ssh_key={your_public_key}"
```