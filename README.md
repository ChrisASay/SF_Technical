# Ubuntu Server Automated Deployment & Hardening

## Project Overview

This project automates the deployment and secure configuration of an Ubuntu server running on a vSphere virtualization environment. It uses:

- Terraform to provision the Ubuntu VM with two network interfaces:
  - An external interface with a public IP (`178.156.133.99`) exposed to the internet.
  - An internal VLAN-tagged interface (VLAN ID 150) connected to an internal device subnet (`10.200.16.100/29`) that requires TCP port 9000 access.

- Ansible to configure and harden the server by:
  - Installing and configuring an SSH server and a web server (Apache), both bound exclusively to the external interface.
  - Implementing firewall rules with UFW that restrict access: only allowing SSH (22) and HTTP (80) on the external interface, and allowing TCP port 9000 only from the internal device subnet.
  - Disabling root SSH login for enhanced security.

### Project Goals

- To automate a repeatable, consistent provisioning of Ubuntu server instances on vSphere.
- Ensure the server is secure by default with limited network exposure.
- Separate internal and external traffic using VLAN tagging and interface binding.
- Enable controlled access for internal devices to specific ports (9000 TCP).

---

## Prerequisites

- A vSphere environment .
- An on-prem enabled Ubuntu template uploaded to vSphere.
- Terraform installed (with the vSphere provider plugin).
- Ansible installed on your control machine.
- SSH private key for authentication (`~/.ssh/id_rsa`).

---

## Setup & Deployment Steps

### 1. Configure Terraform Variables

Edit `terraform/terraform.tfvars` and set your vSphere username, password, and server URI:

```hcl
vsphere_user     = "administrator@vsphere.local"
vsphere_password = "yourpassword"
vsphere_server   = "vcenter.example.com"
```

### 2. Deploy the Ubuntu VM

From the root project directory:

```bash
cd terraform
terraform init
terraform apply
```

This will create a VM named `ubuntu-secured` with the specified network interfaces and cloud-init settings.

### 3. Configure the Server with Ansible

Once the VM is up and running, use Ansible to configure and secure it:

```bash
cd ../ansible
ansible-playbook -i inventory.ini site.yml
```

- This installs and configures SSH and Apache web server bound only to the external interface.
- Applies firewall rules to restrict access accordingly.
- Disables root SSH login.

---

## Customization & Notes

- **Internal network VLAN tagging**: The internal interface is configured with VLAN ID 150 and connects to a subnet that can access the server on TCP port 9000.
- **Firewall rules** can be expanded or modified in the Ansible `hardening` role.
- You can add monitoring, SSL, fail2ban, or other security enhancements by extending the Ansible roles.
- Ensure the vSphere node name, vSphere site name, and subnet details match your environment.

---

## Summary

This project provides a solid foundation for automated, secure Ubuntu server deployments on vSphere using modern infrastructure-as-code tools. It ensures network segmentation, service binding, and firewall hardening to minimize attack surfaces while allowing necessary access.

---

If you need any help customizing or expanding this automation, feel free to reach out!
