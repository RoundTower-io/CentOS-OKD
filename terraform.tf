variable "do_token" {
  default = ""
}

variable "rsa_pass" {
  default = ""
}

provider "digitalocean" {
  token = "${var.do_token}"
}

#Create OKD host node

resource "digitalocean_droplet" "okd00" {
  image = "centos-7-x64"
  region = "nyc3"
  size = "c-8"
  name = "okd00"
  ssh_keys = [ "59:78:f2:91:87:2b:de:df:03:e4:91:c8:8c:94:c8:a2" ]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      #private_key = "${rsadecrypt(file("~/.ssh/id_rsa"),"${var.rsa_pass}")}"
    }

    inline = [ 
      "yum -y update ",
      "yum -y install git docker net-tools",
      "cd && git clone https://github.com/gshipley/installcentos.git && ",
      "cd ~/installcentos && export USERNAME=gcw && export && PASSWORD='.....gcwdemo'",
      "INTERACTIVE=false bash ./install-openshift.sh",
    ]
  }
}
