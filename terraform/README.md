# Terraform Setup for Ubuntu Secure VM

## Steps
1. Copy `terraform.tfvars.example` → `terraform.tfvars` move it onto the root directory, and then fill in:
   - vSphere credentials
   - Datacenter, network names
   - IP and gateway values

Directory Structure Example:

```my-terraform-project/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── modules/
    ├── module1/
    └── module2/
```
By placing terraform.tfvars in the root directory, Terraform will automatically detect and apply the variable values during execution.

2. Run:
   ```bash
   terraform init
   terraform apply
   ```

The output will show the external IP to use in Ansible inventory.
