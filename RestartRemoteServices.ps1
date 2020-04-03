param(	
    [string]$remoteHost = (Read-Host "Host"),
	[string]$administratorUser = (Read-Host "Domain\user_admin")
)

#== FUNCTIONS ======================================================================

Function GetPassword{
	$secureString = Read-Host "Password" -AsSecureString
	$byteString = ConvertToByteString $secureString
	$PlainTextPassword = ConvertToPlainText $byteString
	
	[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($byteString)
	
	return $PlainTextPassword
}

Function ConvertToByteString{
	Param ($secureString)
	return [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
}

Function ConvertToPlainText{
	Param ($byteString)
	return [Runtime.InteropServices.Marshal]::PtrToStringAuto($byteString)
}

Function ConnectToHost{
	Param ($remoteHost, $administratorUser, $administratorPassword)
	Write-Host ""
	Write-Host "Connecting to $remoteHost host..."
	net use \\$remoteHost\c$ /USER:$administratorUser $administratorPassword
}

Function RestartService{
	Param ($remoteHost)
	Write-Host "Restarting Remote services..."
	Get-Service TermService -ComputerName $remoteHost | Restart-Service -Force
	Write-Host ""
}

Function DisconnectFromHost{
	Param ($remoteHost)
	Write-Host "Disconnecting from $remoteHost host..."
	Write-Host ""
	net use \\$remoteHost\c$  /delete
}

#=====================================================================================

$administratorPassword = GetPassword

ConnectToHost $remoteHost $administratorUser $administratorPassword
RestartService $remoteHost
DisconnectFromHost $remoteHost


