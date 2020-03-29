variable "project" {
	default = "springboot-rds-appointment"
}

variable "docker_build_image" {
  default = "ubuntu"
}

variable "pr_builder_cache" {
  type = map
  default = {
    default = "kymsote-cache"
    dev     = "pr-builder-cache"
  }
}


