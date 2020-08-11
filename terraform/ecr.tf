module "ecr" {
  source                 = "./modules/ecr"
  image_tag_mutability   = var.image_tag_mutability
  scan_images_on_push    = var.scan_images_on_push
}

