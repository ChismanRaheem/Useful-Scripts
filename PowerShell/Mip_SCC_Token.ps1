#GetTheToken
#SCC Token (Security and Complaince Center Token)

<# 

Security and Compliance Center (SCC) Token: In the context of Microsoft 365 or Office 365, the Security and Compliance Center is a unified web console that helps manage compliance features across Microsoft 365 services.
 A "SCC token" might refer to an authentication token used to access resources or perform actions within the Security and Compliance Center. 
 This token would typically be obtained through an OAuth authentication flow, similar to the example you provided for obtaining a token from Microsoft Graph. 


#>
$body = @{
    client_id     = "bd01fd75-70v3-4628-90de-D34D833f"
    scope         = "https://syncservice.o365syncservice.com/.default"
    client_secret = "S0mth1ingSpec1al"
    grant_type    = "client_credentials"
}

$responseSSC = Invoke-RestMethod -Uri "https://login.microsoftonline.com/[TenantID]/oauth2/v2.0/token" -Method POST -Body $body -ContentType "application/x-www-form-urlencoded"
$responseSSC.access_token


#GetToken
#Protection Token

$body = @{
    client_id     = "bd01fd75-70v3-4628-90de-D34D833f"
    scope         = "https://aadrm.com/.default"
    client_secret = "S0mth1ingSpec1al"
    grant_type    = "client_credentials"
}

$responseProtection = Invoke-RestMethod -Uri "https://login.microsoftonline.com/[TenantID]/oauth2/v2.0/token" -Method POST -Body $body -ContentType "application/x-www-form-urlencoded"
$responseProtection.access_token

Set-Location -Path "F:\MipSample\CppSample\mip_sdk_file_win32_1.14.128\bins\debug\amd64"

.\file_sample.exe --scctoken $responseSSC.access_token --protectiontoken $responseProtection.access_token -l
