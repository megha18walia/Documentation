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