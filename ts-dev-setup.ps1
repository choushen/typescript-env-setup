# PowerShell script to set up TypeScript development on Windows

function InstallWithRetry {
    param (
        [scriptblock]$command,
        [int]$retryCount = 2
    )

    $currentTry = 0
    $successful = $false
    while (-not $successful -and $currentTry -le $retryCount) {
        try {
            & $command
            $successful = $true
        } catch {
            $currentTry++
            if ($currentTry -gt $retryCount) {
                throw $_
            }
        }
    }
}

# Install Node.js and npm
InstallWithRetry {
    Invoke-WebRequest 'https://nodejs.org/dist/v14.x/node-v14.x-x64.msi' -OutFile 'node-v14.x-x64.msi'
    Start-Process -Wait -FilePath 'node-v14.x-x64.msi'
    Remove-Item 'node-v14.x-x64.msi' -Force
}

# Install TypeScript and related tools
InstallWithRetry { npm install -g typescript }
InstallWithRetry { npm install -g prettier eslint eslint_d ts-node }

Write-Output "TypeScript development environment is set up!"

