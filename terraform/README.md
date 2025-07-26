# Terraform Setup for Ubuntu Secure VM

## Steps
1. Copy `terraform.tfvars.example` → `terraform.tfvars` and fill in:
   - vSphere credentials
   - Datacenter, network names
   - IP and gateway values

2. Run:
   ```bash
   terraform init
   terraform apply
   ```

The output will show the external IP to use in Ansible inventory.