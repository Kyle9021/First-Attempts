#Authored by: Kyle Butler AKA ZeroCool Hehehe
#Purpose: To create PS install commands for Windows Servers!
#Run as Admin on any windows server to get a list of PS commands to clone the roles and features of a Windows Server. 

$featureRoleOutputLocation = "C:\Users\Kyle.Butler\Desktop\Bill.Demo.unclean.txt" #The location of txt file you'd like the "uncleaned" output to go!
$Writelocation = "C:\Users\Kyle.Butler\Desktop\Bill.Demo.txt" #The location you'd like your PS commands to go!


#Gets the installed and enabled Windows and Windows Optional Roles/Features and outputs semi-formatted list into a text file!

Get-WindowsFeature | Where-Object {$_. installstate -eq "installed"} | Format-List Name | Out-File -FilePath $featureRoleOutputLocation 
Get-WindowsOptionalFeature -Online | Where-Object {$_. state -eq "Enabled"} | Format-List FeatureName | Out-File -FilePath $featureRoleOutputLocation -Append


#PS command strings no need to touch or configure these variables
$phrase1 = "Enable-WindowsOptionalFeature -Online -FeatureName "
$phrase2 = " -all"
$phrase3 = "Install-WindowsFeature -Name "



#Loops through each line of the "Readlocation.txt" file and concatenates the strings into the powershell commands!
ForEach ($line in (Get-Content $featureRoleOutputLocation)) 
{if ($line.StartsWith("Name :"))
    {Add-Content -Value ($phrase3 + '"' + $line.Replace("Name : ","") + '"') -Path $Writelocation}
 if ($line.StartsWith("FeatureName :"))  
    {Add-Content -Value ($phrase1 + '"' + $line.Replace("Name : ","") + '"' + $phrase2) -Path $Writelocation}
 else {continue}
     }