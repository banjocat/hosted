variable "ocean_key" {}
variable "ocean_ssh_key" {}
provider "digitalocean" {
    token = "${var.ocean_key}"
}

resource "digitalocean_droplet" "mesos_master" {
    image = "ubuntu-16-04-x64"
    name = "mesos_master"
    region = "nyc1"
    size = "512mb"
    ssh_keys = ["${var.ocean_ssh_key}"]
}

resource "digitalocean_floating_ip" "proxy" {
    droplet_id = "${digitalocean_droplet.mesos_master.id}"
    region = "${digitalocean_droplet.mesos_master.region}"
}

resource "digitalocean_domain" "proxy" {
    name = "giantdino.com"
    ip_address = "${digitalocean_floating_ip.proxy.ip_address}"
}

resource "digitalocean_record" "proxy" {
    domain = "${digitalocean_domain.proxy.name}"
    type = "A"
    name = "www"
    value = "${digitalocean_floating_ip.proxy.ip_address}"
}

output "proxy_fqdn" {
    value = "${digitalocean_record.proxy.fqdn}"
}

output "proxy_floating_ip" {
    value = "${digitalocean_floating_ip.proxy.ip_address}"
}

