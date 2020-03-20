###AUTHOR KYLE BUTLER FROM SPIRION PS######
###Purpose: To clear spirion custom metadata from .xlsx .pptx and docx files...completely
#~~~~~~~~~~~TO TEST: Replace $env:LOCATION with the file path of target file with metadata~~~~~

$FileForCleaning = $env:LOCATION
$fileTransform = Split-Path $FileForCleaning -Leaf 
$OriginalName = Get-ChildItem -Path $FileForCleaning -Name

#safety built-in so it only executes on files which meet the criteria outlined above!
#becase it's super fun to see what this can do to a file that isn't meant to go through this...not

#This is saying if the file doesn't end with .docx,.xlsx,.pptx exit the script
if (!($OriginalName.EndsWith(".docx") -or (".xlsx") -or (".pptx"))){ exit }

#If the extension does match...then it executes.
if (($OriginalName.EndsWith(".docx") -or (".xlsx") -or (".pptx"))){

# Step one append .zip to file name
Rename-item `
    -Path $FileForCleaning `
    -NewName ($fileTransform +".zip") 

# Step two unzip the file to the Windows System temp folder
Expand-Archive `
    -LiteralPath ($FileForCleaning + ".zip")`
    -DestinationPath "C:\Windows\Temp\$fileTransform\" 

# Step three clean-up after yourself and get rid of the .zip
Remove-Item `
    -Path ($FileForCleaning + ".zip")`
    -Force

# Step four get the meta data out of the file! If it's not there ignore the fact. 
Remove-Item `
    -Path ("C:\Windows\Temp\$fileTransform\docProps\custom.xml") `
    -Force `
    -ErrorAction Ignore

# Step five now that the metadata is gone recompress the file and send it back
Compress-Archive `
    -Path "C:\Windows\Temp\$fileTransform\*" `
    -DestinationPath ((Split-Path -Path $FileForCleaning) + '\' + $fileTransform +".zip") `
    -CompressionLevel Optimal

# Step six now that it's back, time to rename it back to the it's "old" name
Rename-item `
    -Path ((Split-Path -Path $FileForCleaning) + '\' + $fileTransform +".zip")  `
    -newName $OriginalName

# Step seven...gotta clean that old temp folder and get rid of the mess
Get-ChildItem `
    -path "C:\Windows\Temp\$fileTransform*" `
    -recurse | 
        where-object {$_} | 
            remove-item `
                -force `
                -recurse

# Step eight...necessary because PowerShell isn't the greatest. Known issue with Get-Child item. Thanks MS.
Remove-Item `
    -Path "C:\Windows\Temp\$fileTransform\" `
    -Force 

}

 

