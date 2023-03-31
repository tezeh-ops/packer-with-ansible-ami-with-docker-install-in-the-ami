
data "aws_ami" "ami" {    # this will go to aws and filteror find our AMI with the values = the name of AMI below or created
  most_recent = true
  owners = ["self"]  # here ownner is self because we own it (the created goldden image)
  filter {            # filter of search 
    name = "name"
    values = ["packer-with-docker-ubuntu-ami"]   # the name of the ami we created
  }
}

output "ami_id" {
  value = data.aws_ami.ami.id
}


resource "aws_instance" "packer" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name = "id_rsa"

  lifecycle {                  # in this lifecycle we are saying ignore changes happening in the AMI
    ignore_changes = [ ami ] 
  }
}

provider "aws" {
  region = "us-west-2"
} 