New-AzureRmResourceGroup -Name "test-azure-vm" -Location "East US"
New-AzureRmVM -ResourceGroupName "test-azure-vm" -Name "test-vm" -Location 'East US' -VirtualNetworkName "myVNet" -SubnetName "mySubNet" -SecurityGroupName "mySecurityGrp" -PublicIpAddressName "publicIP" -OpenPorts 80, 3389 

Get-AzureRmPublicIpAddress -ResourceGroupName "test-azure-vm" | select "IPAddress"
mstsc /v:13.68.168.189