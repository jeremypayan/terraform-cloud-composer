# terraform-cloud-composer
This repository's purpose is to set up a viable Cloud composer component thanks to Terraform . 


# Prerequisites

You need: 
- Terraform setup on your computer
- A Google Cloud Platform Account 
- A GCP Project where you want to build this example infrastructure

For granting Terraform to interact with our GCP account, we need to create a service account with Owner rights on the platform. Here it is terraform-infra-380516 account but you have to create your own service account linked to your GCP project(s). 

# Setup 

## Install terraform on your computer

On **MacOS**, with homebrew : 

```bash
brew tap hashicorp/tap # install the HashiCorp tap, a repository of all our Homebrew packages.
brew install hashicorp/tap/terraform #Now, install Terraform with hashicorp/tap/terraform
```

On **Windows**, with [chocolately](https://chocolatey.org/install) : 
```
choco install terraform
```

To check everything is fine 

```bash
terraform -v 
```

You can check the commands with help : 
```
terraform -help <command>
```

Source : [Install Terraform](https://developer.hashicorp.com/terraform/downloads)


## Get the repository 

Clone and reach the repository
````
git clone https://github.com/jeremypayan/terraform-cloud-composer
cd terraform-cloud-composer
````

Create your own fresh branch and move into it
```
git checkout -b dbp-<name>
```

# Usage 

When applying this infrastructure, it is going to set up a viable Cloud Composer environment in your selected project. First, you have to set your project vairables in the variables.tf file. Then, you can run : 
```
terraform apply
```

Then you can navigate to Cloud Composer on GCP in your selected project and see your setup. To see the official documentation, you can refer to this [page](https://cloud.google.com/composer/docs/composer-2/terraform-create-environments). 