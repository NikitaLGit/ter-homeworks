terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=1.8.4"
}

provider yandex {
      cloud_id  = var.cloud_id
      folder_id = var.folder_id
      zone      = var.zone
    }

resource "yandex_compute_instance" "testter" {
  count = 1

  name        = format("testter-%02d", count.index + 1)
  hostname    = format("testter-%02d", count.index + 1)
  description = format("testter-%02d", count.index + 1)
  folder_id   = var.folder_id
  zone        = var.zone

  allow_stopping_for_update = true

  resources {
    cores         = 2
    core_fraction = 5
    memory        = 1

  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.yandextoolbox.id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.subnet
    nat       = true
  }

  metadata = {
    user-data = "${file("/home/lns/git_devops/ter-homeworks/01/src2/meta.txt")}"
  }
}

provider "docker" {
  host     = "ssh://green773@158.160.163.150"
  ssh_opts = [
    "-o", "StrictHostKeyChecking=no",
    "-o", "UserKnownHostsFile=/dev/null",
    "-i", "C:\\Users\\Vasilenko\\.ssh\\id_ed25519"  # Указываем путь к приватному ключу
  ]
}

resource "docker_container" "mysql8" {
  image = "mysql:8"
  name  = "mysql_container"
  ports {
    internal = 3306
    external = 3306
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${outputs.password_root}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${outputs.password}"
  ]
}
