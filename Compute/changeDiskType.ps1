#Introduzca el nombre del grupo de recursos de su disco duro
$rgName = "ASD-Labs";
#Introudzca el nombre de su maquina virtual
$vmName = "VMLABS03";
$storageType = "Premium_LRS"
#Introduzca el nombre de su disco duro
$diskName = "VMLABS03_OsDisk_1_7fc3f5cb89cf495eb8d4493d16e2aaae"

Stop-AzVM -ResourceGroupName $rgName -Name $vmName -Force

$vmDisk = Get-AzDisk -DiskName $diskName -ResourceGroupName $rgName

$vmDisk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
$vmDisk | Update-AzDisk

Start-AzVM -ResourceGroupName $rgName -Name $vmName