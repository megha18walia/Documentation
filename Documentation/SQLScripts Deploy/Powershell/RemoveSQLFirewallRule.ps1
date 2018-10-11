[CmdletBinding(DefaultParameterSetName = 'None')]
Param
(
    [String][Parameter(Mandatory = $true)]$ServerName ,
    [String] $AzureFirewallName = "AzureWebAppFirewall"
)
$ErrorActionPreference = 'Stop'


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

if((Get-AzureRmSqlServerFirewallRule -ResourceGroupName sqldatabase -FirewallRuleName $AzureFirewallName -ServerName $ServerName -ErrorAction SilentlyContinue))
{
    Remove-AzureRmSqlServerFirewallRule -ResourceGroupName sqldatabase -FirewallRuleName $AzureFirewallName -ServerName $ServerName
}