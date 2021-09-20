# TRUFAN.IO PROJECT

This project uses the standard terraform modules under the aws provider to deploy an ecs fargate service loading a sample docker image.

:warning: I've not been able to figure out how to wire up provider.profile for authentication. For some reason, im getting the following error when simply running `terraform init`:

```
$ terraform init

Initializing the backend...
Error refreshing state: AccessDenied: Access Denied
        status code: 403, request id: 9VZ2NX6FGTG50HS1, host id: DweFc0UupP1qtoIABaI8USySrYsR6T1e/.....

# instead the following works by prefixing in AWS_PROFILE

$ AWS_PROFILE=<your profile under ~/.aws/credentials> terraform plan/init/apply/destroy


# "AWS_PROFILE=<your profile under ~/.aws/credentials>" will be omitted for the rest of this doc for brevity.
```

## TF_STATE BUCKET:

Terraform state is stored under a bucket, which itself is also being wired up by tf under `./remote-state`:

```
$ cd ./remote-state
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
```

## MAIN APP

```
$ cd ../ # back to the main directory...

$ terraform init
$ terraform plan
$ terraform apply -auto-approve

# This will take a while to spin up all the necessary resources. 
# Once finished, navigate to the alb endpoint shown in the output from a browser.

# To clean up...

$ terraform destroy -auto-approve
$ cd ./remote-state && terraform destroy -auto-approve
```