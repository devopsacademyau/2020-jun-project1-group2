# Migrating a Wordpress Application to AWS [2020-jun-project1-group2]

This repository is related to source code of the project 1 of group2.

### Description

A company in Australia currently have a web application running on a Linux virtual machine. The application is being used by hundreds of customers every day and it is based on Wordpress which uses LAMP stack (Linux, Apache, MySQL and PHP) to offer great products.

Currently the solution is hosted in a single server (application and database) and deployments are made through FTP transfers to the server.

The CEO is worried that a traffic peak may bring down the website and decided to migrate to AWS. Your team was contracted to perform this migration.

# Table of Contents

- [Migrating a Wordpress Application to AWS [2020-jun-project1-group2]](#migrating-a-wordpress-application-to-aws-2020-jun-project1-group2)
    - [Description](#description)
- [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Requirements](#requirements)
  - [Assumptions](#assumptions)
    - [Quick Start](#quick-start)
  - [Running Terraform 3musketeers](#running-terraform-3musketeers)
    - [Solution Overview](#solution-overview)
    - [Contributors](#contributors)

## Introduction

This projects aims to:

- Create Migration of an Wordpress to AWS

### Requirements

Run a pilot migration to AWS cloud considering the following requirements:

- Containerize the application using Docker (see Resources section).
- The application needs to be secure (all data encrypted at rest and in transit)
- The application needs to be high available.
- The application needs to support peaks of up to 10 times the average load (scalability).
- The infrastructure needs to be reproducible and version controlled in case the CEO decides to expand the business to other parts of the world (consider infra as code).
- There must be an easy and secure way of developing, with fast feedback (consider CI/CD practices or at least automation scripts)

## Assumptions

- As it is a pilot migration to AWS, data migration is out of scope
- Testers were contracted to develop unit/service/integration tests for this pipelinea, so you don't need to write tests but consider including this step in your CI pipeline or automation scripts!
- Consider the application as stateless for this pilot. In Wordpress some files may be stored locally on the server (e.g. on image upload)
- For this pilot we are aiming to have as much as possible as code
- Single Github repo.

### Quick Start

- Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

- Install [Docker](https://docs.docker.com/get-docker/)

  - Related tool:
    - [Docker Compose](https://docs.docker.com/compose/install/)

- Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

* Clone the repository and get inside it:

```
git clone git@github.com:devopsacademyau/2020-jun-project1-group2.git
cd 2020-jun-project1-group2
```

\*\* Check if you have permission to clone the repository via SSH,
or insert your ssh-key on your github([more details here](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)).

- Setup your .env file according to this example

```
# AWS
AWS_API_KEY=""
AWS_SECRET_KEY=""

# AWS S3 File Upload
AWS_ACCESS_KEY_ID="enter_AWS_acess_key_here"
AWS_SECRET_ACCESS_KEY="enter_AWS_secret_here"
S3_BUCKET_NAME="enter_s3_bucket_name_here"
S3_REGION="enter_s3_region_here"

```

## Running Terraform 3musketeers

```
$ make plan    # runs linter, then builds and displays the terraform plan
$ make apply   # apply the generated plan to AWS
```

### Solution Overview

- [Solution Diagram](https://drive.google.com/file/d/1pBsQbNWMfZpMJjqa1JCTEtUx2n0ovpJ2/view?usp=sharing)

### Contributors

- Nimmi (nimmi89)
- Tim (obrientimothya)
- Guilherme (gepifanio)
- Marcos (mrcsmonteiro)
- Gustavo (gpavelar)

* DevOps Trainers
  - Caio
  - Denis
  - Kiko
