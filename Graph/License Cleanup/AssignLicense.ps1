#  Disclaimer:    This code is not supported under any Microsoft standard support program or service.
#                 This code and information are provided "AS IS" without warranty of any kind, either
#                 expressed or implied. The entire risk arising out of the use or performance of the
#                 script and documentation remains with you. Furthermore, Microsoft or the author
#                 shall not be liable for any damages you may sustain by using this information,
#                 whether direct, indirect, special, incidental or consequential, including, without
#                 limitation, damages for loss of business profits, business interruption, loss of business
#                 information or other pecuniary loss even if it has been advised of the possibility of
#                 such damages. Read all the implementation and usage notes thoroughly.
#
# Ref :https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users.actions/set-mguserlicense?view=graph-powershell-1.0
# Note: Please make sure no null values are in the array or you might experience errors.
#  Scenario: This example assigns more than one licenses to a user,  in this example we use the EMSPREMIUM and PowerBi standard license assignment using an array.


Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All -TenantId 85086bfd-eeee-random-b751-randomPii
$e3PBI = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'POWER_BI_STANDARD'
$EmsSku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'EMSPREMIUM'

$addLicenses = @(
    @{Skuid = $EMsSku.SkuId},
    @{Skuid = $e3PBI.SkuId}
)

Set-MgUserLicense -UserId "testuser001@mslabredmond.onmicrosoft.com" -AddLicenses $addLicenses -RemoveLicenses @()
