provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "external" {
  name          = var.external_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "internal" {
  name          = var.internal_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ubuntu_vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.external.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id   = data.vsphere_network.internal.id
    adapter_type = "vmxnet3"
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = true
  }

  customization {
    linux_options {
      host_name = var.vm_name
      domain    = "local"
    }

    network_interface {
      ipv4_address = var.external_ip
      ipv4_netmask = 24
    }

    network_interface {
      ipv4_address = var.internal_ip
      ipv4_netmask = 29
    }

    ipv4_gateway = var.gateway
  }
}