# IaCFlavors
This purpose of this repository is to offer a tangible experience to learn and compare the various Infrastructure as Code (IaC) tools which are available in Azure. Sometimes the amount of choices can be overwelhming and it's best to be able to see tangible examples side by side which can be deployed to a local environment. 

In an effort to reduce duplicate documentation this repository will reference provider documentation when available. This also provides additional resources when starting your IaC journey.

# What is IaC
IaC is the ability to translate cloud resources into reusable code. There are numerous "flavors" of how this can be accomplished. There is no right answer, there is no wrong answer. Just various options that are available to any person or organization.

# What this Repo is Not
- This repository is not favoring one choice of IaC over another.
- Will not teach you how to use each IaC flavor, rather provide resources and examples

# Repo Structure
The first recommend step would be to clone this repo. If unfamilar then check out GitHub's documentation on [cloning repos] (https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

After successfully cloning the best experience will be leveraging an IDE with a command terminal such as [VS Code](https://code.visualstudio.com/download)

Then one would navigate to the via terminal commands to the desired folder location. This will allow you to deploy changes when scoped to a specific folder.

## Examples
Each type of scenario will be the top level example. This is done to provide the experience of being able to quickly view how an example can be viewed across multiple languanges.

## Languanges
Below each example will be a list of languanges which have the same example defined in a similar fashion. Based on availability not all examples will contain the same languanges. Want to improve it, provide an example in the languange you are looking for!

## Modules
This repository will try and leverage "modules". This is a bit of a more advanced terminology for IaC;however, it is a necessary component to fully grasp the power, reusability, and readability of IaC. Modules are indvidual Azure resources or groups of Azure resources that are defined within the same template. This allows for reusabilty within the same projact as well as increased readability.

## Parameters/Variables
A seperate folder leveraging the appropriate terminology (i.e. parameter, variable,etc) will be configured for under each example. This is done so to illustrate how flexiblity on how resources are defined and created across environments could be configured. For example a more costly resource offerring could be required for Production vs a Development environment.

# Benefits of IaC
IaC offers numerous benefits in contrast to manually creating Azure Resources via a portal. Some of those benefits are:
- Quickly creating additional environments and/or instances
- Placing infrastructure resources under CI/CD and source control for better quality and collaboration
- Reusable modules to drive consistency and lower bearer of entry
- Enhanced Security

# Current Flavors
- [Bicep](documentation/bicep.md)
- [Terraform](documentation/terraform.md)
