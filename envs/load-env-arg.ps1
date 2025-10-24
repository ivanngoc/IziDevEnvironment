param(
    [Parameter(Mandatory = $true)]
    [string]$EnvFile
)

if (-not (Test-Path $EnvFile)) {
    Write-Error "File not found: $EnvFile"
    exit 1
}

Get-Content $EnvFile | ForEach-Object {
    if ($_ -match '^\s*([^#=]+)=(.*)$') {
        $name = $matches[1].Trim()
        $value = $matches[2].Trim()
        [Environment]::SetEnvironmentVariable($name, $value, 'Machine')
        Write-Host "Set system variable: $name=$value"
    }
}
