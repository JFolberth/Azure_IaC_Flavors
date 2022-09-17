# IaCFlavors
This purpose of this repository is to offer a tangible experience to learn and compare the various Infrastructure as Code (IaC) tools which are available in Azure. Sometimes the amount of choices can be overwhelming and it's best to be able to see tangible examples side by side which can be deployed to a local environment. 

In an effort to reduce duplicate documentation this repository will reference provider documentation when available. This also provides additional resources when starting your IaC journey.

# Who this repo is for
This repo is for anyone interested in learning about the different ways to write IaC. The examples provided should all be fully deployable. There will be no "shying away" from advanced features of the language. The intent is to provide the necessary examples and documentations for one to find out how to fully utilized. This is done such users who are advanced in one language can see the equivalent functionality in another.

# What is IaC
IaC is the ability to translate cloud resources into reusable code. There are numerous "flavors" of how this can be accomplished. There is no right answer, there is no wrong answer. Just various options that are available to any person or organization.

# What this Repo is Not
- This repository is not favoring one choice of IaC over another.
- Will not teach you how to use each IaC flavor, rather provide resources and examples

# Key Resources
- [What is Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview)
- [Microsoft's Definition of IaC](https://docs.microsoft.com/en-us/dotnet/architecture/cloud-native/infrastructure-as-code)
- [Azure Developer CLI](https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/)

# Benefits of IaC
IaC offers numerous benefits in contrast to manually creating Azure Resources via a portal. Some of those benefits are:
- Quickly creating additional environments and/or instances
- Placing infrastructure resources under CI/CD and source control for better quality and collaboration
- Reusable modules to drive consistency and lower bearer of entry
- Enhanced Security

# Understanding Declaritive vs Imperative 
To date this repo is strictly leveraging declarative IaC Tools. What's this mean? Declarative provides the 'template' or the to be state of the infrastructure during deployment. Think of deployments of a specific resource, resource group. Imperative IaC providers require each individual step to be tasked out. It might help to think declarative is defining the what and imperative is defining the how.

Imperative programming requires users to have a mroe in depth knowledge of the scripting process, this also gives them the ability to more "fine tune" the deployment process. Declarative programming has become more popular in part due to the learning curve to get started. I am not saying one way is better then the other. Again they both have their pros and their cons.

# Current Flavors
- [Bicep](documentation/bicep.md)
- [Terraform](documentation/terraform.md)
- [ARM](documentation/ARM.md)
- [Pulumi](documentation/pulumi.md)

# IaC Best Practices
- Code is redeployable
- Easily readable
- Modules are completely reusable and independent from the main template
  - All Key values are parameters/variables
  - Can default value still providing ability to override
- No secrets stored in the codebase
- IaC code is stored together with application code
  - Faster Development Time
  - Adhere to same Software Delivery Lifecycle
  - Deployed together to prevent drift/staleness
- Each environment specifics is a separate parameter file

# Repo Structure
The first recommend step would be to clone this repo. If unfamiliar then check out GitHub's documentation on [cloning repos](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

After successfully cloning the best experience will be leveraging an IDE with a command terminal such as [VS Code](https://code.visualstudio.com/download)

Then one would navigate to the via terminal commands to the desired folder location. This will allow you to deploy changes when scoped to a specific folder.

## Examples
Each type of scenario will be the top level example. This is done to provide the experience of being able to quickly view how an example can be viewed across multiple languages. Any functionality in an example for one specific language such as type casting, validation, and looping shall be similarly accomplished across other languages for teh same example.

## Languages
Below each example will be a list of languages which have the same example defined in a similar fashion. Based on availability not all examples will contain the same languages. Want to improve it, provide an example in the language you are looking for!

## Modules
This repository will try and leverage "modules". This is a bit of a more advanced terminology for IaC;however, it is a necessary component to fully grasp the power, reusability, and readability of IaC. Modules are individual Azure resources or groups of Azure resources that are defined within the same template. This allows for reusability within the same project as well as increased readability.

## Parameters/Variables
A separate folder leveraging the appropriate terminology (i.e. parameter, variable,etc) will be configured for under each example. This is done so to illustrate how flexibility on how resources are defined and created across environments could be configured. For example a more costly resource offering could be required for Production vs a Development environment.
