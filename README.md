# Ubuntu Secure VM Deployment with Terraform & Ansible

Automated deployment of Ubuntu Server VM on vSphere, with two NICs:
- External interface (178.156.133.99): SSH & Apache
- Internal interface (10.200.16.100/29 via VLAN 150): TCP port 9000 access

## Includes
- Terraform for VM creation
- Ansible for configuration & hardening
- UFW firewall setup

## Usage

1. Terraform
   ```bash
   cd terraform
   cp terraform.tfvars.example terraform.tfvars
   terraform init
   terraform apply
   ```
2. Ansible
   ```bash
   cd ../ansible
   ansible-playbook -i inventory.ini playbook.yml
   ```

## Requirements
- Terraform ≥ 1.3
- Ansible ≥ 2.10
- vSphere with Ubuntu template + portgroups for external/in‑VLAN configurations
