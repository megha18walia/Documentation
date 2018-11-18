$creds = Get-Credential

New-AzureRmVM -ResourceGroupName testvhd -Location "East US" -Name "TestCustomeVM" -VirtualNetworkName "myVnet" -SubnetName "mySubNet" `
-PublicIpAddressName "pip" -Credential $creds -OpenPorts 80 -SecurityGroupName "NetworkSecurityGroup"

# Custom script 


Set-AzureRmVMExtension -ResourceGroupName "testvhd" `
    -ExtensionName "IIS" `
    -VMName "TestCustomeVM" `
    -Location "EastUS" `
    -Publisher Microsoft.Compute `
    -ExtensionType CustomScriptExtension `
    -TypeHandlerVersion 1.8 `
    -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'