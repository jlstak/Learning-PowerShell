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
$userCN = Read-Host "Enter User CN (eg. Bruce Banner):"
while ($userCN -ne "n") {
   Get-ADUser -filter "Name -eq '$userCN'" -SearchBase $userDOM | Enable-ADAccount > $null
    if ($? -eq $true) {
      Write-Host "Success.  $userCN has been enabled." -ForegroundColor Green } else {
      Write-Host "$userCN not found." -ForegroundColor Red }
    $userCN = Read-Host "Any more users to enable? If not, enter N:"
        }
     }
 
 if ($input -eq 2){
    $userCN = Read-Host "Enter User CN (eg. Tony Stark):"
        while ($userCN -ne "n") {
        Get-ADUser -filter "Name -eq '$userCN'" -SearchBase $userDOM | Disable-ADAccount > $null
        if ($? -eq $true) {
        Write-Host "Success. $userCN has been disabled." -ForegroundColor Green -BackgroundColor yellow }
            else {
        Write-Host "$userCN is not found." -ForegroundColor Red -BackgroundColor yellow }
        $userCN = Read-Host "Any more users to disable? If not, enter N:"
  }
 }
