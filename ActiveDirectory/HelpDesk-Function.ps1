<#
Common Helpdesk Tools
#>

#Import Active Directory module
Import-Module ActiveDirectory


#Declare static variables
$domain = "adatum.com"

#User OU
$userDOM = "DC=Adatum,DC=com"
$userIT = "OU=IT,DC=Adatum,DC=com"
$userMKT = "OU=Marketing,DC=Adatum,DC=com"
$userMGR = "OU=Managers,DC=Adatum,DC=com"

#Computer objects

#Option input
$input = Read-Host "OPTIONS:

1 - Enable User
2 - Disable User
3 - Unlock User
10 - Restart client computer
11 - 

Enter Option"


if ($input -eq 1){
$userCN = Read-Host "Enter User CN to enable (eg. Bruce Banner):"
while ($userCN -ne "n") {
   Get-ADUser -filter "Name -eq '$userCN'" -SearchBase $userDOM | Enable-ADAccount > $null
    if ($? -eq $true) {
      Write-Host "Success.  $userCN has been enabled." -ForegroundColor Green } else {
      Write-Host "$userCN not found." -ForegroundColor Red }
    $userCN = Read-Host "Any more users to enable? If not, enter N:"
        }
     }
 
 if ($input -eq 2){
    $userCN = Read-Host "Enter User CN to disable (eg. Tony Stark):"
        while ($userCN -ne "n") {
        Get-ADUser -filter "Name -eq '$userCN'" -SearchBase $userDOM | Disable-ADAccount > $null
        if ($? -eq $true) {
        Write-Host "Success. $userCN has been disabled." -ForegroundColor Green }
            else {
        Write-Host "$userCN is not found." -ForegroundColor Red }
        $userCN = Read-Host "Any more users to disable? If not, enter N:"
  }
 }
 if ($input -eq 3){
    $userCN = Read-Host "Enter User CN to Unlock (eg. Clint Barton):"
        while ($userCN -ne "n") {
        Get-ADUser -filter "Name -eq '$userCN'" -SearchBase $userDOM | Unlock-ADAccount > $null
        if ($? -eq $true) {
        Write-Host "Success. $userCN has been unlocked." -ForegroundColor Green}
            else {
        Write-Host "$userCN is not found." -ForegroundColor Red }
        $userCN = Read-Host "Any more users to unlock? If not, enter N:"
  }
 }
if ($input -eq 10){
$compName = Read-Host "Enter computer name to restart (eg. loki-pc)"
    if ($compName -eq "") {
    $compName = $env:COMPUTERNAME
    write-host "Computer name cannot be blank." -ForegroundColor Cyan
    break
    }

    if (Test-Connection $compName -count 2 -Quiet) {
    
    Restart-Computer -ComputerName $compName -Force
    Write-Host "Restarting computer...$compName" -ForegroundColor Green
    }
    else {
    Write-Host "Either $compName is offline or does not exist." -ForegroundColor Red
    }
}