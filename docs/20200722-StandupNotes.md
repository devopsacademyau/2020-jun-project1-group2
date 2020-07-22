# Standup Notes 22 Jul 2020

## Due Date
Our due date is Sun 16 Aug

## Project Overview

- Containerize the application using Docker (see Resources section). [docker compose, Makefile, ECS, ECR]
- The application needs to be secure (all data encrypted at rest and in transit) [S3 encrypt, Sec Groups, VPC, ECS, passwords in a vault, ACM, HTTPS]
- The application needs to be high available. [multi-az, load-balancing, ASG]
- The application needs to support peaks of up to 10 times the average load (scalability). [ASG]
- The infrastructure needs to be reproducible and version controlled in case the CEO decides to expand the business to other parts of the world (consider infra as code). [terraform, github, terraform state on AWS]
- There must be an easy and secure way of developing, with fast feedback (consider CI/CD practices or at least automation scripts) [jenkins, gitlab-ci, github, aws codedeploy]

## Project Assumptions

- As it is a pilot migration to AWS, data migration is out of scope [no wordpress data to be migrated - clean install]
- Testers were contracted to develop unit/service/integration tests for this pipeline, so you don't need to write tests but consider including this step in your CI pipeline or automation scripts! [create a pipeline]
- Consider the application as stateless for this pilot. In Wordpress some files may be stored locally on the server (e.g. on image upload) [S3? shared filesystem?]
- For this pilot you don't need to create the Infra as Code for the CI pipeline [just build the pipeline]
- Single Github repo.

## Kanban Board 
We agreed to use the following board for management of our tasks:

https://github.com/devopsacademyau/2020-jun-project1-group2/projects/1

## Solution Diagram
We captured the essesnce of the diagram today.
Feel free to check-out the draw.io file here and propose any new changes as we move forward.

## Next Standup
Next meeting: Monday 27th July 6 PM

## Goals
- Become Terraform experts this week :) 
- Distribute the initial tasks on Monday (TF CI pipeline, initial VPC and others)
- Keep the information flowing on the Kanban board and Slack - ask questions, etc.

