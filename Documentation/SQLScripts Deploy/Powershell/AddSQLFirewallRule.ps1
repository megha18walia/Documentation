[CmdletBinding(DefaultParameterSetName = 'None')]
param
(
    [String][Parameter(Mandatory = $true)]$ServerName ,                   #testsqlazuredatabase
    [String] $AzureFirewallName = "AzureWebAppFirewall"
)
$ErrorActionPreference = 'Stop'




function New-AzureSQLServerFirewallRule{
    $wc = New-Object System.Net.Webclient
    $agentIP = $wc.downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"
    New-AzureRmSqlServerFirewallRule -ResourceGroupName sqldatabase -StartIPAddress $agentIP -EndIPAddress $agentIP -FirewallRuleName $AzureFirewallName -ServerName $ServerName 
}

function Update-AzureSQLServerFirewallRule{
    $wc = New-Object System.Net.Webclient
    $agentIP = wc.downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"
    Set-AzureRmSqlServerFirewallRule -ResourceGroupName sqldatabase -StartIPAddress $agentIP -EndIPAddress $agentIP -FirewallRuleName $AzureFirewallName -ServerName $ServerName 
}

function Login
{
    $needLogin = $true
    Try
    {
        $content = Get-AzureRmContext
        if($content)
        {
            $needLogin = ([string]::IsNullOrEmpty($content.Account))
        }
    }
    Catch
    {
        if($_ -like "*Login AzureRMAccount to Login*")
        {
            $needLogin = $true
        }
        else
        {
            throw
        }
    }

    if($needLogin)
    {
        Login-AzureRmAccount
    }

}

Login




If((Get-AzureRmSqlServerFirewallRule -ResourceGroupName sqldatabase -ServerName $ServerName -FirewallRuleName $AzureFirewallName -ErrorAction SilentlyContinue) -eq $null)
{
    New-AzureSQLServerFirewallRule
}
else
{
    Update-AzureSQLServerFirewallRule
}

