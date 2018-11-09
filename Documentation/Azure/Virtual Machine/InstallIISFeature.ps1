$Feature = Get-WindowsOptionalFeature -Online | where FeatureName -like 'IIS-*'

foreach($iis in $Feature)
{
    Enable-WindowsOptionalFeature -Online -FeatureName $iis.FeatureName
}