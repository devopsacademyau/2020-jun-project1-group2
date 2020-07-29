module "ASG-LB-ECS" {
    source = "./modules/ASG-LB-ECS"
    cluster_name = "PROVIDE ECS CLUSTER NAME"
    security_groups = ["LIST OF SECURITY GROUPS"]
    subnet_ids = ["LIST OF SUBNETS IDS"]
    vpc_id = "ID OF THE VPC (module.vpc_module.vpc_id_output)"
}