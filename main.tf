terraform {
  required_version = ">= 1.4.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

provider "null" {}

resource "null_resource" "django_docker_setup" {

  # Re-run when these files change (relative to this folder)
  triggers = {
    dockerfile_hash       = filesha1("${path.module}/Dockerfile")
    docker_compose_ymlhash = filesha1("${path.module}/docker-compose.yml")
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"=== Terraform: starting server setup ===\"",
      "apt-get update -y",
      "apt-get install -y git docker.io docker-compose",
      "systemctl enable docker",
      "systemctl start docker",
      "mkdir -p ${var.app_dir}",
      "if [ ! -d '${var.app_dir}/.git' ]; then git clone ${var.repo_url} ${var.app_dir}; else cd ${var.app_dir} && git pull; fi",
      "cd ${var.app_dir} && docker compose up -d --build || docker compose up -d --build",
      "echo \"=== Terraform: setup complete ===\""
    ]

    connection {
      type     = "ssh"
      host     = var.server_host
      user     = var.server_user
      password = var.server_password
    }
  }
}
