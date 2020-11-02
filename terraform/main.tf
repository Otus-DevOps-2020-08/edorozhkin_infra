provider "yandex" {
  token     = "AgAAAABGBa5zAATuwVNulcGUUk0zslIKiv2Rcxk"
  #cloud_id  = "b1gkpu0a2r8kcfnk2c0i"
  #folder_id = "b1g0em8n970esl6ghhpg"
  #zone      = "ru-central1-a"
  service_account_key_file = var.service_account_key_file
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  zone = var.zone
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      #image_id = "fd85uikfhnfabk50prik"
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    #subnet_id = "e9bqidv9tq01c8cemdnm"
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    #ssh-keys = "ubuntu:${file("~/.ssh/ubuntu.pub")}"
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type = "ssh"
    host = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    # путь до приватного ключа
    #private_key = file("~/.ssh/ubuntu")
    private_key = ubuntu:${file(var.private_key_path)}"
    }

  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

