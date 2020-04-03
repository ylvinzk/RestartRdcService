# RestartRdcService
A script to restart the Windows Remote Desktop Service (TermService) in PowerShell.

## Usage with pwsh.exe
This script does not work with PowerShell Core, just Windows PowerShell.

## Installation
No needed. Just run the script in PowerShell.

## How to execute

### PowerShell

Move to the containing folder using PowerShell then run the script like this:

```
.\RestartRemoteServices.ps1
```

### Other shells

Move to the containing folder using your shell, then run the command:

```
powershell.exe .\RestartRemoteServices.ps1
```

## Usage

The script will ask for 3 parameters:
- **Host**: The hostname of the remote PC you want to restart the service on.
- **Domain\user_admin**: The domain and admin username who has privileges to restart the service on that PC.
- **Password**: The password for the user above.

First, the script will establish a connection with **NET USE** to \\[Hostname]\c$
```
Connecting to [Hostname] host...
The command completed successfully.
```
Then it will restart the TermService by force to also restart dependant services.
```
Restarting Remote services...
```
Finally, it will disconnect from the established **NET USE** connection
```
Disconnecting from sf0184 host...
\\[Hostname]\c$ was deleted successfully.
```

## Errors while executing

If an error occurs while the script is executing one of the steps, the error message will be presented, but the script will try the next steps. You will have to wait for it to finish to try again.
