using Pulumi;
using Pulumi.AzureNative.Resources;
//Pinning the provider since existing provider does not support App Insights to Log Analytics
using Pulumi.AzureNative.Insights.V20200202;
using Pulumi.AzureNative.Web;
using Pulumi.AzureNative.Web.Inputs;
using Pulumi.AzureNative.OperationalInsights;
using Pulumi.AzureNative.OperationalInsights.Inputs;
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


    var nameSuffix = (config.Require("baseName") + "-" + config.Get("env") + "-" + regionReference[config.Require("location")]).ToLower();
    var resourceGroupName = "rg-" + nameSuffix;
    

    // Create an Azure Resource Group
    var resourceGroup = new ResourceGroup("resourceGroup", new ResourceGroupArgs
    {
        Location = config.Require("location"),
        ResourceGroupName = resourceGroupName,
        Tags = {
                ["Language"] = language
            }
    });

    // Create an Azure resource (App Service Plan)
    var appServicePlan = new AppServicePlan("appServicePlan", new()
        {
            Kind = "app",
            Location = config.Require("location"),
            Name = "asp-" + nameSuffix,
            ResourceGroupName = resourceGroup.Name,
            Sku = new SkuDescriptionArgs
            {
                Name = config.Require("appServicePlanSKU")
            },
            Tags = {
                ["Language"] = language
            }
        });
    var workspace = new Workspace("workspace", new()
        {
            Location = resourceGroup.Location,
            ResourceGroupName = resourceGroup.Name,
            RetentionInDays = int.Parse(config.Require("logAnalyticsRetentionDays")),
            Sku = new WorkspaceSkuArgs
            {
                Name = "PerGB2018",
            },
            Tags = 
            {
                ["Language"] = language
            },
            WorkspaceName = "la-" + nameSuffix,
        });
     var appInsights = new Component("appInsights", new ComponentArgs
        {
            ApplicationType = "web",
            Kind = "web",
            Location = resourceGroup.Location,
            ResourceGroupName = resourceGroup.Name,
            ResourceName = "ai-" + nameSuffix,
            WorkspaceResourceId = workspace.Id,
            Tags = 
            {
                ["Language"] = language
            },
        });
    var appService = new WebApp("appService", new WebAppArgs
        {   Name = "wapp-" + nameSuffix,
            ResourceGroupName = resourceGroup.Name,
            ServerFarmId = appServicePlan.Id,
            HttpsOnly = true, 
            SiteConfig = new SiteConfigArgs
            {
                AppSettings = {
                    new NameValuePairArgs{
                        Name = "APPINSIGHTS_INSTRUMENTATIONKEY",
                        Value = appInsights.InstrumentationKey
                    }
                },
                MinTlsVersion = "1.2"
            },
            Tags = 
            {
                ["Language"] = language
            },
            Identity = new ManagedServiceIdentityArgs 
            {
                //Need to be explicit here since ManagedServiceIdentity Type is a property of both .Web and .Resources
                Type = Pulumi.AzureNative.Web.ManagedServiceIdentityType.SystemAssigned
            }
        });
});