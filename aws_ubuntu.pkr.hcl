packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ansibel-packer-ubuntu-ami"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "ansible-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {     #if we pass a script to intall software in our image so we pass this ptovisioner to run the script
    script = "./ansible.sh" # this the file (docker.sh) that contain my docker software. we are calling it here.
  }
  provisioner "ansible-local" {
    playbook_file = "./docker.yml"
  }
} 