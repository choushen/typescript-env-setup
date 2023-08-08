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
    # Download and install Node.js (this is just a placeholder)
    Invoke-WebRequest 'https://nodejs.org/dist/v18.17.0/node-v18.17.0-x64.msi' -OutFile 'node-v14.x-x64.msi'
    Start-Process -Wait -FilePath 'node-v18.17.0-x64.msi'
    Remove-Item 'node-v18.17.0-x64.msi' -Force
}

# Install TypeScript and related tools
InstallWithRetry { npm install -g typescript }
InstallWithRetry { npm install -g prettier eslint eslint_d ts-node }

Write-Output "TypeScript development environment is set up!"

