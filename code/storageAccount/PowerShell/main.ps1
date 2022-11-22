Param(
    [Parameter(Mandatory=$true,
    HelpMessage="Three letter environment abreviation to denote environment that will appear in all resource names")]
    [string[]]
    $EnvironmentName,
    [Parameter(Mandatory=$true,
    HelpMessage="Location for all resources.")]
    [string[]]
    $location,
    [Parameter(Mandatory=$true,
    HelpMessage="Storage Account type")]
    [string[]]
    $storageAccountType = "Standard_LRS",
    [Parameter(Mandatory=$true,
    HelpMessage="Storage Account type")]
    [string[]]
    $baseName = "iacflavorstfps"
    
)

$regionReference = @{
    centralus ="cus"
    eastus = "eus"
    westus = "wus"
    westus2 = "wus2"
  }
$baseName = 
$nameSuffix = '$baseName-$environmentName-$regionReference[$location]'

New-AzResourceGroup -Name 'rg-$nameSuffix' -location $location  

New-AzStorageAccount -name 'sa-$nameSuffix' -ResourceGroupName storageresourcegroup -SkuName $storageAccountType -location $location -kind Storagev2