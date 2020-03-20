###AUTHOR KYLE BUTLER######
###Purpose: To clear spirion custom metadata from .xlsx .pptx and docx files

$FileForCleaning = "C:\Users\Kyle.Butler\Desktop\a - Copy (2).docx"
$fileTransform = Split-Path $FileForCleaning -Leaf 
$OriginalName = Get-ChildItem -Path $FileForCleaning -Name

#safety built-in so it only executes on files which meet the criteria outlined above!

#if ($OriginalName.EndsWith(".docx") -or (".xlsx") -or (".pptx")){

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


#if (!($OriginalName.EndsWith(".docx") -or (".xlsx") -or (".pptx"))| Out-Null }

 

