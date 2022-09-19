using Pulumi;
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;
using System.Collections.Generic;

return await Pulumi.Deployment.RunAsync(() =>
{
    var config = new Pulumi.Config();
    var regionReference = new Dictionary<string, string>();
    var language = "Pulumi";
    regionReference.Add("centralus", "cus");
    regionReference.Add("eastus", "eus");
    regionReference.Add("westus", "wus");
    regionReference.Add("westus2", "wus2");


    var suffix = config.Require("baseName") + "-" + config.Get("env") + "-" + regionReference[config.Require("location")];
    var resourceGroupName = "rg-" + suffix;
    

    // Create an Azure Resource Group
    var resourceGroup = new ResourceGroup("resourceGroup", new ResourceGroupArgs
    {
        Location = config.Require("location"),
        ResourceGroupName = resourceGroupName,
        Tags = {
                ["Language"] = language
            }
    });

    // Create an Azure resource (Storage Account)
    var storageAccount = new StorageAccount("sa", new StorageAccountArgs
    {
        ResourceGroupName = resourceGroup.Name,
        AccountName = "sa" + suffix.Replace("-", "").ToLower(),
        Tags = {
                ["Language"] = language
            },
        Location = resourceGroup.Location,
        Sku = new SkuArgs
        {
            Name = config.Require("storageAccountSKU")
        },
        Kind = Kind.StorageV2,
        Identity = new IdentityArgs {
            Type = "SystemAssigned"
        }
    });

});