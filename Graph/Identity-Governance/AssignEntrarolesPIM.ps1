#To use the Microsoft Entra Privileged Identity Management, you must have one of the following licenses:
#Microsoft Entra ID P2
#Enterprise Mobility + Security (EMS) E5 license
#Microsoft Graph PowerShell using a Privileged Role Administrator role and the appropriate permissions. For this tutorial, the RoleManagement.ReadWrite.Directory delegated permission is required. To set the permissions in Microsoft Graph PowerShell, run;
# Ref: https://learn.microsoft.com/en-us/powershell/microsoftgraph/tutorial-pim?view=graph-powershell-1.0
# Disclaimer

#Set UPN of test  user
$UPN = "Raheem@FQDN.onmicrosoft.com"

# Connect to graph with required scope using DeviveCode flow.
Connect-MgGraph -TenantId 536279f6-15cc-45f2-be2d-A4332b5beef -ContextScope Process -UseDeviceAuthentication -Scopes "RoleManagement.ReadWrite.Directory"

#Set user based on UPN to capture id
$User = Get-MgUser -Search "UserPrincipalName:$($UPN)" -ConsistencyLevel eventual -Count userCount 

#Capture Roles EligibilitySchedule
$Roles = Get-MgRoleManagementDirectoryRoleEligibilityScheduleInstance -Filter "principalId eq '$($User.Id)'" 

# Set  the parameter for selfactivation for pim 
$params = @{
  "PrincipalId" = $User.Id
  "RoleDefinitionId" = "88d8e3e3-8f55-4a1e-953a-9b9898b8876b"
  "Justification" = "Activate assignment"
  "DirectoryScopeId" = "/"
  "Action" = "SelfActivate"
  "ScheduleInfo" = @{
    "StartDateTime" = Get-Date
    "Expiration" = @{
       "Type" = "AfterDuration"
       "Duration" = "PT1H"
       }
     }
    }

#commnad execution
    New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $params |
  Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionID, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime, TargetScheduleID
