Install-Module AzureAD
Install-Module ExchangeOnlineManagement
Connect-ExchangeOnline

#Search-MailboxAuditLog -Identity chris@chris365.ca -StartDate 04/25/2024 -EndDate 04/27/2024 -ShowDetails

Search-UnifiedAuditLog -StartDate 04/25/2024 -EndDate 04/27/2024 -FreeText (Get-Mailbox chris@chris365.ca).ExchangeGuid | export-csv c:\temp\SharedMailbox_chris365.csv -NoTypeInformation

#Search-UnifiedAuditLog -StartDate "04/25/2024" -EndDate "04/27/2024" -RecordType ExchangeItem -SessionCommand ReturnLargeSet


#Search-UnifiedAuditLog -UserIds chris@chris365.ca -RecordType ExchangeItem -StartDate 04/25/2024 -EndDate 04/27/2024 -SessionCommand ReturnLargeSet | export-csv c:\temp\SharedMailbox_chris365.csv -NoTypeInformation

#Search-UnifiedAuditLog -Identity chris@chris365.ca -StartDate 04/25/2024 -EndDate 04/27/2024 -ShowDetails

Search-UnifiedAuditLog -StartDate 04/25/2024 -EndDate 04/27/2024 -UserIds chris@chris365.ca -Operations MailItemsAccessed -ResultSize 1000 | Export-Csv -Path c:\AuditLogs\PowerShellAuditlog.csv -NoTypeInformation
Search-UnifiedAuditLog -StartDate 04/25/2024 -EndDate 04/27/2024 -UserIds chris@chris365.ca -Operations MailItemsAccessed -ResultSize 1000 | Where {$_.AuditData -like '*"IsThrottled","Value":"True"*'} | FL

$auditlog = Search-UnifiedAuditLog -StartDate 01/10/2024 -EndDate 04/27/2024 -RecordType ExchangeItem
$auditlog | Select-Object -Property CreationDate,UserIds,RecordType,AuditData | Export-Csv -Path c:\AuditLogs\PowerShellAuditlog.csv -NoTypeInformation


$auditlog = Search-UnifiedAuditLog -StartDate 06/01/2019 -EndDate 06/30/2019 -RecordType SharePointFileOperation

$auditlog | Select-Object -Property CreationDate,UserIds,RecordType,AuditData | Export-Csv -Append -Path c:\AuditLogs\PowerShellAuditlog.csv -NoTypeInformation

[array]$Records = Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-1) -EndDate (Get-Date) -Formatted -ResultSize 5000
$Records | Group-Object Operations -NoElement | Sort-Object Count -Descending | Format-Table Name, Count -AutoSize 

