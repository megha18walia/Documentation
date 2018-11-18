Login-AzAccount 

$diskConfig = New-AzureRmDiskConfig -Location "East Us" -CreateOption Empty -DiskSizeGB 128 
$dataDisk = New-AzureRmDisk -DiskName "myDataDisk" -ResourceGroupName "TestAzureResourceGroupNew" -Disk $diskConfig

$vm = Get-AzureRmVM -ResourceGroupName "TestAzureResourceGroupNew" -Name "VisualStudio"

$vm = Add-AzureRmVMDataDisk -VM $vm -Name "myDataDisk" -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1
Update-AzureRmVM -ResourceGroupName "TestAzureResourceGroupNew" -VM $vm

#Disk Added Now run the following command to mount
Get-Disk | where PartitionStyle -EQ "RAW" | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | `
Format-Volume -FileSystem NTFS  -NewFileSystemLabel "myDataDisk" -Confirm:$false



