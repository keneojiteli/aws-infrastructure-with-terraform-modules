## Terraform Infrastructure Automation with AWS S3 Remote Backend and GitHub Actions
## Project Overview
This project demonstrates how to build modular, reusable Terraform infrastructure integrated with a remote backend on AWS S3, leveraging S3’s native state lock feature for safe concurrent operations.
It also automates infrastructure provisioning and destruction using GitHub Actions, ensuring that all deployments are consistent, repeatable, and version-controlled.

The setup represents the first phase of a larger automation project that will evolve to support multi-environment (Dev, Staging, and Production) provisioning and teardown with minimal manual intervention.

The key focus areas include:

- Custom Terraform modules that are reusable, loosely coupled, and maintainable.
- Managing Terraform remote state securely in AWS S3 with native state locking (compatible with Terraform ≥ v1.10).
- Implementing GitHub Actions pipelines for automated provisioning and destruction.
- Laying the foundation for multi-environment automation (an ongoing upgrade).

## Project structure
```
.
├── .github/                         <-- GitHub configuration
│   └── workflows/                   <-- GitHub Actions workflows
│       └── terraform-create.yaml           <-- CI/CD pipeline to initialize, plan and apply terraform
        └── terraform-desroy.yaml           <-- CI/CD pipeline to destroy terraform resources
│
├── main.tf                <-- Root module (entry point)
├── provider.tf            <-- Provider & backend config
├── variables.tf           <-- Root-level input variables
├── output.tf              <-- Root-level outputs
├── README.md              <-- Project documentation
│
└── modules/
    ├── vpc/
    │   ├── main.tf        <-- Defines VPC resources (e.g., aws_vpc, subnets)
    │   ├── variables.tf   <-- Inputs specific to the VPC module
    │   └── output.tf      <-- Exports IDs (vpc_id, subnet_ids, etc.)
    │     
    ├── db/
    │   ├── main.tf        <-- Defines RDS resources (e.g., aws_db_subnet_group, aws_db_instance)
    │   ├── variables.tf   <-- Inputs specific to the RDS module
    │   └── output.tf      <-- Exports IDs
    │
    └── compute/
        ├── main.tf        <-- Defines EC2 resources etc.
        ├── variables.tf   <-- Inputs specific to the compute module
        └── output.tf      <-- Exports instance info, SG IDs, etc.
```

## Solutions Solved
- **Reliable State Management with S3 Native Locking**: The project uses AWS S3 as the Terraform remote backend, which stores the state file and ensures consistent state synchronization between team members and automation pipelines. By leveraging Terraform’s S3 native locking feature (use_lockfile = true), concurrent terraform apply or destroy commands are prevented, avoiding state corruption without needing a separate DynamoDB table for locking (DynamoDB-based locking is still supported as a fallback, but S3 native locking simplifies setup and reduces AWS resource overhead). The configuration can be found in the `provider.tf` file.

- **Modular Infrastructure Design**: infrastructure is organized into custom Terraform modules, each responsible for a specific part of the architecture, as shown in the project structure diagram above. This modular approach ensures: Easy reusability and scalability, clear boundaries between components and simplified upgrades and testing of individual modules.

- **Clean Data Exchange Between Modules**: A common challenge when working with Terraform modules is passing data between modules (eg, from one child module to another) especially when the output of one module serves as the input of another. This project uses outputs and input variables properly to handle that exchange cleanly. The essence of exchanging data between modules is to: keep modules independent and reusable, prevent direct resource referencing across modules and to ensure outputs serve as the only means of communication between modules.

## CI/CD Automation with GitHub Actions
This project uses GitHub Actions to automate Terraform workflows for provisioning (apply) and destruction (destroy) in a consistent and secure manner. The workflows can be found in the `.github/workflows` directory in the root directory. The pipeline features include: configuring AWS credentials, setting up Terraform, Terraform initialization, linting, validation, and plan checks before apply and manual trigger for destruction (preventing accidental deletions).

## Best Practices followed
- I ensured each module focused on an AWS service (for example, VPC module contained everything required to build the VPC).
- I exposed only necessary outputs (especially the ones that will e required by other modules and passed to the root module, which is the connector).
- I parameterised my attributes and passed the values using variables (a`.tfvars` file can also be used to pass values).
- I added descriptions and defaults where needed to variables and outputs.





