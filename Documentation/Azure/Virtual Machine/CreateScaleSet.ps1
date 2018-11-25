New-AzureRmVmss -ResourceGroupName "TestScaleSet" -Location 'UK West' -VMScaleSetName "Scaleset1" -VirtualNetworkName "myVnet"`
 -SubnetName "mySubnet" -PublicIpAddressName "PIP" -SecurityGroupName "NSG" -LoadBalancerName "myLoadBalancer" -UpgradePolicyMode Automatic

 $publicSettings = @{
    "fileUris" = (,"https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate-iis.ps1");
    "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File automate-iis.ps1"
}

$VMSS = Get-AzureRmVmSS -ResourceGroupName "TestScaleSet" -VMScaleSetName "ScaleSet1"

Add-AzureRmVmssExtension -VirtualMachineScaleSet $VMSS -Name "CustomScript" -Publisher "Microsoft.Compute" -Type "CustomScriptExtension" `
  -TypeHandlerVersion 1.8 -Setting $publicSettings

  Update-AzureRmVmss -ResourceGroupName "TestScaleSet" -VMScaleSetName "ScaleSet1" -VirtualMachineScaleSet $VMSS 

  $nsgFrontEndRule = New-AzureRmNetworkSecurityRuleConfig -Name "FrontEndConfig" -SourcePortRange "*" -DestinationPortRange 80 `
-SourceAddressPrefix "*" -DestinationAddressPrefix "*" -Protocol Tcp -Direction Inbound -Priority 200 -Access Allow

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName "TestScaleSet" -Location 'UK West' -Name "FrontEndNSG" -SecurityRules $nsgFrontEndRule 

$vnet = Get-AzureRmVirtualNetwork -Name "myVnet" -ResourceGroupName "TestScaleSet" 
$fsubnet = $vnet.Subnets[0]

$fsubnetConfig = Set-AzureRmVirtualNetworkSubnetConfig -Name mySubnet -VirtualNetwork $vnet -AddressPrefix $fsubnet.AddressPrefix `
-NetworkSecurityGroup $nsg

Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

Update-AzureRmVmss -ResourceGroupName "TestScaleSet" -VMScaleSetName "ScaleSet1" -VirtualMachineScaleSet $VMSS