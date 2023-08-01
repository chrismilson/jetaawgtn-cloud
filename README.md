*I published this under the impression that I would need to handover the website and infrastructure to someone else. Ultimately the decision was that JETAA Wellington does not need such a site in favour of social networking.*

# JETAA Wellington Cloud

JETAA Wellington used to have a Wordpress site that was hosted by a private hosting company. This company charged JETAA Wellington approximately $200 per year for hosting which included some user and email functionality, however this was not required by JETAA Wellington.

In 2022, JETAA Wellington switched to AWS hosting of a minimal static site. This is much better suited to JETAA's requirements; their only ongoing cost now is for the domain name `jetaawgtn.org.nz`  which costs around $14NZD per year.

One issue however is that the only acceptable payment method for this expense is credit/debit card, which the JETAA organisation does not have. This puts a requirement on one of the JETAA members to pay the costs with a personal card, and ask to be reimbursed by the executive.

## Website

At the moment, zero effort has gone into the static site. It is maintained [here](./website-content/), but at the moment it consists of a single "under maintenance" page. Some work could go into improving the site, but it should be kept as a static site (no users or email functionality).

If the files in website-content are updated, the infrastructure will upload those changes on its next deployment.

## Infrastructure

The infrastructure for the site is all contained within a single AWS account: 

> name: jetaawellington  
> account id: 905493318373  
> password: *** (managed by the current custodian)  

This account has traditionally been managed by the JETAA member who has also been paying for the account at any given time.

### Terraform

This repository contains the terraform code to maintain the cloud resources. Since there are limited resources with little chance of scaling, all of the resources are managed in the same terraform config and tracked by a single terraform state file.

The terraform is intended to be deployed manually by the member with access. 

### Maintaining the Terraform

The terraform code will likely not need to be updated - its sole purpose is to track what resources exist so that future maintainers of the cloud resources are aware of exactly what exists in the AWS account. 

If changes are to be made to the cloud resources, the maintainer should endeavour to make those changes to the terraform code only. Making manual changes via the console will make it difficult for future maintainers to understand what exists and what has existed in the past. Making changes to this terraform code, committing those changes to this repository, and updating the cloud infrastructure by applying thos terraform should be ther preferred option.

If you are reading this as the new maintainer of the infrastructure, never fear! Terraform is a simple language to read and there are many resources online to help in understanding it! If you're just interested in understanding what exists, there's no need to install any software either. Happy reading!

### Installing required software

You will just need to install `terraform`. See [the code](./terraform/tf_config.tf) to see what version of terraform you will need to install.
