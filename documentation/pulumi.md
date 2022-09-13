# Pulumi

# About
The intent behind Pulumi is to provide developers with a native infrastructure as code experience within the language they are accustomed to. The desire is to reduce the learning curve as well as integrating the IaC experience into native tooling.

Currently Pulumi supports the following languages/filetypes:
- TypeScript
- Python
- Go
- C#
- Java
- YAML


# Some Pointers
- Manage remote resource definition via Pulumi Service
- "Modules" are defined and hosted in npm packages
- Still considered the "new kid" on the block
- Open source
- Can use native code formatters

# How It Works
CLI will query the Pulumi service for last deployed state to determine creates, updates, deletes

![Diagram of Pulumi service engine](images/pulumi_engine-block-diagram.png)

Source From: [Pulumi Documentation](https://www.pulumi.com/docs/intro/concepts/how-pulumi-works/)

# PreReqs
- [Pulumi](https://www.pulumi.com/docs/get-started/install/)
- [Pulumi Account](https://app.pulumi.com/signup?)

# Stacks
Pulumi stacks are isolated and independent instances of the Pulumi code. Usually this translates into environment configurations. Thus passing `--stack` or `-s` denotes which YAML fill to pull in and populate the deployment.

[More Information on Pulumi Stacks](https://www.pulumi.com/docs/intro/concepts/stack/)
 
# Validating Changes
To view changes proposed by Pulumi need to run `pulumi preview --stack dev` from within the folder the Pulumi code is in.

For more information check out the [Pulumi preview command](https://www.pulumi.com/docs/reference/cli/pulumi_preview/)

# Deploying
Deployment for these examples are done at the Subscription level. This is done to ensure full deployment by creating the required Resource Group.

 `pulumi up --stack dev` 

 For more information and options check out the documentation on [`Pulumi up command`](https://www.pulumi.com/docs/reference/cli/pulumi_up/)

# Links
- [How Pulumi Works](https://www.pulumi.com/docs/intro/concepts/how-pulumi-works/)
- [Pulumi's Starter Walkthrough](https://www.pulumi.com/docs/get-started/azure/)
- [Azure DevOps Pulumi Task](https://www.pulumi.com/docs/guides/continuous-delivery/azure-devops/)
- [GitHub Actions Pulumi Task](https://www.pulumi.com/docs/guides/continuous-delivery/github-actions/)
- [Azure Native Registry](https://www.pulumi.com/registry/packages/azure-native/)
- [Examples](https://github.com/pulumi/examples)