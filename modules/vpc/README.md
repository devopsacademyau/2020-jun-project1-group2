# VPC

A VPC is an isolated portion of the AWS Cloud populated by AWS Objects.

CIDR Range:

- `10.0.0.0/16`

## Subnet

It's a range of IP Address available into your VPC. It is divided into two groups: Public and private.
The first is for resources that should be connected to the internet. The other for the resources that will not be connected to the internet.

- Public subnet

  - `10.0.1.0/24`
  - `10.0.3.0/24`

- Private subnet
  - `10.0.2.0/24`
  - `10.0.4.0/24`

## Availability Zones

- AZ's:
  - ap-southeast-2a
  - ap-southeast-2b

## Internet Gateway

Internet Gateway (IGW) is a communication door between an Amazon VPC and the internet.

## NAT Gateway

Allow instances with no public IPs to access the internet, in another words, your private instance able to communicate and update packages,etc.

## Security Groups

This resource allow our instances to connect to the internet using the Amazon network.
It's required because without it we cannot receive external access.

- Name: project1-igw

After created, we need to attach this IGW to our VPC.

- #### Inbound rules
  testing
- #### Outbound rules
  testing

## Network ACLs

## Route tables

- Public Route Table: add all your public subnet and your internet gateway

- Private Route Table:

### Diagram Solution

![First-diagram](https://drive.google.com/uc?export=view&id=1sZIpqe14wwXN7A9Bjl8YJ6GwDE4RyXEH)
