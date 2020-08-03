# I propose this is where put our terraform backends.
# The 'real' s3 state bucket is commented out for now,
# so that we can still test code locally
# using own accounts; without encountering s3
# bucket naming conflicts.
# - Tim

# local state - remove in production
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

# s3 state - use in production
#terraform {
#  backend "s3" {
#    bucket         = "2020-jun-project1-group2"
#    path           = "tfstate"
#    region         = "ap-southeast-2"
#    encrypt        = true
#  },
#}

