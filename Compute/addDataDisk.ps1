param([string]$rgName, [string]$vmName, [int]$diskSize, [string]$diskSKU = "Premium_LRS")

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Stop-AzVM -ResourceGroupName $rgName `
 -Name $vmName `
 -Force

$vm = Get-AzVM -ResourceGroupName $rgName `
 -Name $vmName

$currentTime = Get-Date
$currentTimeStr ='{0:yyyyMMddhhmmss}' -f $currentTime
$newDiskName = "$($vm.Name)_datadisk_$($currentTimeStr)"

$newDiskConfig = New-AzDiskConfig -DiskSizeGB $diskSize `
 -SkuName $diskSKU `
 -Location $vm.Location `
 -CreateOption Empty

$newDisk = New-AzDisk -Disk $newDiskConfig `
 -DiskName $newDiskName `
 -ResourceGroupName $rgName

$vm = Add-AzVMDataDisk -VM $vm `
 -Name $newDiskName `
 -CreateOption Attach `
 -ManagedDiskId $newDisk.Id `
 -Lun 1

Update-AzVM -VM $vm `
 -ResourceGroupName $rgName
