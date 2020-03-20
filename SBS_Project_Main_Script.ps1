#script written by Kyle Butler Spirion PS
#Intention: to automate the server configuration for our platform to make the console set-up easier and faster!



#This is the only variable where you need to make adjustments. Please put the netbios name of the SQL
#server below
$idfSQLS = "AZ1-P-DB001" #Netbios name of SQL SERVER
$idfACPU = Get-WmiObject Win32_Processor  #Get CPU Information 
$idfAOS = (Get-WMIObject win32_operatingsystem).name 
$idfARAM = Get-WmiObject CIM_PhysicalMemory  | 
    Measure-Object -Property capacity -sum |
    % {[math]::round(($_.sum / 1GB),2)} #Checks the Ram of the App Server 
#$idfsupportedOSARRAY = "Microst Windows Server 2012", "Microst Windows Server 2016", "Microst Windows Server 2019"
$idfADisk = Get-WmiObject -Class Win32_logicaldisk #HD Space
$idfportSQL = 1433
$idfnetworktest = (Test-NetConnection -ComputerName $idfSQLS -Port $idfportSQL)

echo $idfnetworktest
if ($idfACPU.Name.StartsWith("Intel(R) Itanium")) {echo "Unsupported CPU"}
if (!($idfAOS.StartsWith({for ($idfsos in $idfsupportedOSARRAY)}))) {echo "non-supported OS"}
if ($Disk.FreeSpace -lt 2.5e+11) {echo "not enough free space"} #check for 250 GB HD
if ($idfARAM -lt 32) {echo "not enough RAM"} #check for 32 GB of RAM

if ($idfAOS.Name.StartsWith("Microsoft Windows 2016")){

Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4ServerFeatures" -all
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4" -all
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-WebServerRole" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-WebServer" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-CommonHttpFeatures" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-Security" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-RequestFiltering" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-StaticContent" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-DefaultDocument" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-DirectoryBrowsing" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpErrors" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpRedirect" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-ApplicationDevelopment" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-NetFxExtensibility45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-ISAPIExtensions" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-ISAPIFilter" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-ASPNET45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HealthAndDiagnostics" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpLogging" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-LoggingLibraries" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-RequestMonitor" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpTracing" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-BasicAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-Performance" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpCompressionStatic" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-HttpCompressionDynamic" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-WebServerManagementTools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "IIS-ManagementConsole" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WAS-WindowsActivationService" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WAS-ProcessModel" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WAS-ConfigurationAPI" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WCF-Services45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WCF-HTTP-Activation45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WCF-TCP-PortSharing45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "Server-Shell" -all
Enable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-amd64" -all
Enable-WindowsOptionalFeature -Online -FeatureName "Server-Gui-Mgmt" -all
Enable-WindowsOptionalFeature -Online -FeatureName "RSAT" -all
Enable-WindowsOptionalFeature -Online -FeatureName "WindowsServerBackupSnapin" -all
Enable-WindowsOptionalFeature -Online -FeatureName "Windows-Defender-Gui" -all
Enable-WindowsOptionalFeature -Online -FeatureName "BitLocker" -all
Enable-WindowsOptionalFeature -Online -FeatureName "SmbDirect" -all
Install-WindowsFeature -Name "FileAndStorage-Services"
Install-WindowsFeature -Name "Storage-Services"
Install-WindowsFeature -Name "Web-Server"
Install-WindowsFeature -Name "Web-WebServer"
Install-WindowsFeature -Name "Web-Common-Http"
Install-WindowsFeature -Name "Web-Default-Doc"
Install-WindowsFeature -Name "Web-Dir-Browsing"
Install-WindowsFeature -Name "Web-Http-Errors"
Install-WindowsFeature -Name "Web-Static-Content"
Install-WindowsFeature -Name "Web-Http-Redirect"
Install-WindowsFeature -Name "Web-Health"
Install-WindowsFeature -Name "Web-Http-Logging"
Install-WindowsFeature -Name "Web-Log-Libraries"
Install-WindowsFeature -Name "Web-Request-Monitor"
Install-WindowsFeature -Name "Web-Http-Tracing"
Install-WindowsFeature -Name "Web-Performance"
Install-WindowsFeature -Name "Web-Stat-Compression"
Install-WindowsFeature -Name "Web-Dyn-Compression"
Install-WindowsFeature -Name "Web-Security"
Install-WindowsFeature -Name "Web-Filtering"
Install-WindowsFeature -Name "Web-Basic-Auth"
Install-WindowsFeature -Name "Web-App-Dev"
Install-WindowsFeature -Name "Web-Net-Ext45"
Install-WindowsFeature -Name "Web-Asp-Net45"
Install-WindowsFeature -Name "Web-ISAPI-Ext"
Install-WindowsFeature -Name "Web-ISAPI-Filter"
Install-WindowsFeature -Name "Web-Mgmt-Tools"
Install-WindowsFeature -Name "Web-Mgmt-Console"
Install-WindowsFeature -Name "NET-Framework-45-Features"
Install-WindowsFeature -Name "NET-Framework-45-Core"
Install-WindowsFeature -Name "NET-Framework-45-ASPNET"
Install-WindowsFeature -Name "NET-WCF-Services45"
Install-WindowsFeature -Name "NET-WCF-HTTP-Activation45"
Install-WindowsFeature -Name "NET-WCF-TCP-PortSharing45"
Install-WindowsFeature -Name "BitLocker" }
if ($idfAOS.Name.StartsWith("Microsoft Windows 2012")){
Install-WindowsFeature -Name "Application-Server"
Install-WindowsFeature -Name "AS-NET-Framework"
Install-WindowsFeature -Name "AS-TCP-Port-Sharing"
Install-WindowsFeature -Name "AS-Web-Support"
Install-WindowsFeature -Name "AS-WAS-Support"
Install-WindowsFeature -Name "AS-HTTP-Activation"
Install-WindowsFeature -Name "AS-Named-Pipes"
Install-WindowsFeature -Name "AS-TCP-Activation"
Install-WindowsFeature -Name "FileAndStorage-Services"
Install-WindowsFeature -Name "Web-Server"
Install-WindowsFeature -Name "Web-WebServer"
Install-WindowsFeature -Name "Web-Common-Http"
Install-WindowsFeature -Name "Web-Default-Doc"
Install-WindowsFeature -Name "Web-Dir-Browsing"
Install-WindowsFeature -Name "Web-Http-Errors"
Install-WindowsFeature -Name "Web-Static-Content"
Install-WindowsFeature -Name "Web-Http-Redirect"
Install-WindowsFeature -Name "Web-Health"
Install-WindowsFeature -Name "Web-Http-Logging"
Install-WindowsFeature -Name "Web-Log-Libraries"
Install-WindowsFeature -Name "Web-Request-Monitor"
Install-WindowsFeature -Name "Web-Http-Tracing"
Install-WindowsFeature -Name "Web-Performance"
Install-WindowsFeature -Name "Web-Stat-Compression"
Install-WindowsFeature -Name "Web-Dyn-Compression"
Install-WindowsFeature -Name "Web-Security"
Install-WindowsFeature -Name "Web-Filtering"
Install-WindowsFeature -Name "Web-Basic-Auth"
Install-WindowsFeature -Name "Web-Client-Auth"
Install-WindowsFeature -Name "Web-Digest-Auth"
Install-WindowsFeature -Name "Web-Cert-Auth"
Install-WindowsFeature -Name "Web-IP-Security"
Install-WindowsFeature -Name "Web-Url-Auth"
Install-WindowsFeature -Name "Web-Windows-Auth"
Install-WindowsFeature -Name "Web-App-Dev"
Install-WindowsFeature -Name "Web-Net-Ext"
Install-WindowsFeature -Name "Web-Net-Ext45"
Install-WindowsFeature -Name "Web-Asp-Net"
Install-WindowsFeature -Name "Web-Asp-Net45"
Install-WindowsFeature -Name "Web-ISAPI-Ext"
Install-WindowsFeature -Name "Web-ISAPI-Filter"
Install-WindowsFeature -Name "Web-Mgmt-Tools"
Install-WindowsFeature -Name "Web-Mgmt-Console"
Install-WindowsFeature -Name "Web-Mgmt-Compat"
Install-WindowsFeature -Name "Web-Metabase"
Install-WindowsFeature -Name "Web-Lgcy-Mgmt-Console"
Install-WindowsFeature -Name "Web-Lgcy-Scripting"
Install-WindowsFeature -Name "Web-WMI"
Install-WindowsFeature -Name "Web-Scripting-Tools"
Install-WindowsFeature -Name "NET-Framework-Features"
Install-WindowsFeature -Name "NET-Framework-Core"
Install-WindowsFeature -Name "NET-HTTP-Activation"
Install-WindowsFeature -Name "NET-Non-HTTP-Activ"
Install-WindowsFeature -Name "NET-Framework-45-Features"
Install-WindowsFeature -Name "NET-Framework-45-Core"
Install-WindowsFeature -Name "NET-Framework-45-ASPNET"
Install-WindowsFeature -Name "NET-WCF-Services45"
Install-WindowsFeature -Name "NET-WCF-HTTP-Activation45"
Install-WindowsFeature -Name "NET-WCF-Pipe-Activation45"
Install-WindowsFeature -Name "NET-WCF-TCP-Activation45"
Install-WindowsFeature -Name "NET-WCF-TCP-PortSharing45"
Install-WindowsFeature -Name "Windows-Identity-Foundation"
Install-WindowsFeature -Name "WAS"
Install-WindowsFeature -Name "WAS-Process-Model"
Install-WindowsFeature -Name "WAS-NET-Environment"
Install-WindowsFeature -Name "WAS-Config-APIs"
Install-WindowsFeature -Name "WoW64-Support"
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureNetFx4ServerFeatures" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureNetFx4" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureNetFx4Extended-ASPNET45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureMicrosoftWindowsPowerShellRoot" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureMicrosoftWindowsPowerShell" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServerCore-FullServer" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-WebServerRole" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-WebServer" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-CommonHttpFeatures" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-Security" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-RequestFiltering" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-StaticContent" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-DefaultDocument" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-DirectoryBrowsing" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpErrors" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpRedirect" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ApplicationDevelopment" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-NetFxExtensibility" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-NetFxExtensibility45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ISAPIExtensions" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ISAPIFilter" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ASPNET" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ASPNET45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HealthAndDiagnostics" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpLogging" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-LoggingLibraries" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-RequestMonitor" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpTracing" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-BasicAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-WindowsAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-DigestAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ClientCertificateMappingAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-IISCertificateMappingAuthentication" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-URLAuthorization" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-IPSecurity" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-Performance" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpCompressionStatic" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-HttpCompressionDynamic" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-WebServerManagementTools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ManagementConsole" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-LegacySnapIn" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-ManagementScriptingTools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-IIS6ManagementCompatibility" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-Metabase" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-WMICompatibility" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureIIS-LegacyScripts" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWAS-WindowsActivationService" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWAS-ProcessModel" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWAS-NetFxEnvironment" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWAS-ConfigurationAPI" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-Services45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-HTTP-Activation45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-TCP-Activation45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-Pipe-Activation45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-TCP-PortSharing45" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureAS-NET-Framework" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-WebServer-Support" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-TCP-Port-Sharing" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-WAS-Support" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-HTTP-Activation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-TCP-Activation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureApplication-Server-Pipe-Activation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-HTTP-Activation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWCF-NonHTTP-Activation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureUser-Interfaces-Infra" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServer-Gui-Mgmt" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureRSAT" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureDNS-Server-Tools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureRSAT-AD-Tools-Feature" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureRSAT-ADDS-Tools-Feature" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureDirectoryServices-DomainController-Tools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureActiveDirectory-PowerShell" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureDirectoryServices-DomainController" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureDirectoryServices-AdministrativeCenter" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWindowsServerBackupSnapin" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeaturePrinting-Client" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeaturePrinting-Client-Gui" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureMicrosoftWindowsPowerShellISE" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServer-Gui-Shell" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureInternet-Explorer-Optional-amd64" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureKeyDistributionService-PSH-Cmdlets" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureTlsSessionTicketKey-PSH-Cmdlets" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureMicrosoftWindowsPowerShellV2" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServer-Psh-Cmdlets" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServerCore-WOW64" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServerCore-EA-IME-WOW64" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureWindows-Identity-Foundation" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServerManager-Core-RSAT" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureServerManager-Core-RSAT-Role-Tools" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureNetFx3ServerFeatures" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureNetFx3" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureMicrosoft-Windows-GroupPolicy-ServerAdminTools-Update" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureSmbDirect" -all
Enable-WindowsOptionalFeature -Online -FeatureName "FeatureSMB1Protocol" -all
}