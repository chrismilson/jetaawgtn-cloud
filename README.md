# JETAA Wellington Cloud

JETAA Wellington used to have a Wordpress site that was hosted by a private hosting company. This company charged JETAA Wellington approximately $200 per year for hosting which included some user and email functionality, however this was not required by JETAA Wellington.

In 2022, JETAA Wellington switched to AWS hosting of a minimal static site. This is much better suited to JETAA's requirements; their only ongoing cost now is for the domain name `jetaawgtn.org.nz`  which costs around $14NZD per year.

One issue however is that the only acceptable payment method for this expense is credit/debit card, which the JETAA organisation does not have. This puts a requirement on one of the JETAA members to pay the costs with a personal card, and ask to be reimbursed by the executive.

## Infrastructure

The infrastructure for the site is all contained within a single AWS account: 

> name: jetaawellington  
> account id: 905493318373  
> password: *** (managed by the current custodian)  

This account has traditionally been managed by the JETAA member who has also been paying for the account at any given time.

This repository contains the terraform code to maintain the cloud resources.
