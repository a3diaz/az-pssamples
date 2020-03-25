param([string]$vmName, [string]$rgName, [string]$newOsDiskName)

$vm = Get-AzVM -ResourceGroupName $rgName -Name $vmName
Stop-AzVM -ResourceGroupName $rgName -Name $vm.Name -Force

$disk = Get-AzDisk -ResourceGroupName $rgName -Name $newOsDiskName
Set-AzVMOSDisk -VM $vm -ManagedDiskId $disk.Id -Name $disk.Name 
Update-AzVM -ResourceGroupName myResourceGroup -VM $vm 
Start-AzVM -Name $vm.Name -ResourceGroupName myResourceGroup