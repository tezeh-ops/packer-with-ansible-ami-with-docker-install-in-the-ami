#!/bin/bash

sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y  
sudo apt update
sudo apt install ansible -y