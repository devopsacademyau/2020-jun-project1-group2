# Migrating a Wordpress Application to AWS [2020-jun-project1-group2]

## Description

A company in Australia currently have a web application running on a Linux virtual machine. The application is based on Wordpress which uses LAMP stack (Linux, Apache, MySQL and PHP) to offer great products. Traffic concerns and single serrver premise-deployments are a concern. The project is aimed at migrating this application to AWS.

# Table of Contents

- [Task](#task)
- [Analysis](#analaysis)
- [Assumptions](#assumptions)
- [Authors](#authors)
- [Resources](#resources)

## Task

Run a pilot migration to AWS cloud considering the following requirements:

- Containerize the application using Docker (see Resources section).
- The application needs to be secure (all data encrypted at rest and in transit)
- The application needs to be high available.
- The application needs to support peaks of up to 10 times the average load (scalability).
- The infrastructure needs to be reproducible and version controlled in case the CEO decides to expand the business to other parts of the world (consider infra as code).
- There must be an easy and secure way of developing, with fast feedback (consider CI/CD practices or at least automation scripts)

## Analysis

Solution diagram to be added

## Assumptions

- As it is a pilot migration to AWS, data migration is out of scope
- Testers were contracted to develop unit/service/integration tests for this pipeline, so you don't need to write tests but consider including this step in your CI pipeline or automation scripts!
- Consider the application as stateless for this pilot. In Wordpress some files may be stored locally on the server (e.g. on image upload)
- For this pilot we are aiming to have as much as possible as code
- Single Github repo.

## Authors

To be added

## Resources

To be added
