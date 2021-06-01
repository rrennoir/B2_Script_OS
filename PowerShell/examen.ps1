function CreatreFolder($path, $delimiter) {
    
    $paths = @()
    try {
        Import-Csv -path $path -Delimiter $delimiter |` ForEach-Object {
            $paths += $_.Chemin
        } | Out-Null
    }
    catch {
        Write-Host "$($_.Exception.Message)"
    }

    foreach ($dir in $paths) {
        New-Item -Type Directory -Path $dir -Force
    }
}

function ListFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)] [string]$path,
        [Parameter(Mandatory = $false)] [string]$filter,
        [Parameter(Mandatory = $true)] [string]$output
    )

    if ("console" -eq $output) {

        Get-ChildItem $path -Filter $filter
    }
    else {
        Get-ChildItem $path -Filter $extention | Out-File $output
    }
}

function CreateRegKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [string]$path,
        [Parameter(Mandatory = $true)] [string]$registerPath,
        [Parameter(Mandatory = $true)] [string]$delimiter
    )

    $key = @()
    $value = @()
    $force = @()

    try {
        Import-Csv -path $path -Delimiter $delimiter |` ForEach-Object {

            $key += $_.Cle
            $value += $_.Valeur
            $force += $_.Force
        } | Out-Null
    }
    catch {
        Write-Host "$($_.Exception.Message)"
    }


    for ($i = 0; $i -le $key.Length - 1; $i++) {
        try {
            if ($force[$i] -eq 1) {
                New-ItemProperty -Path $registerPath -Name $key[$i] -Value $value[$i] -PropertyType "string" -ErrorAction Stop -Force | Out-Null
            }
            else {
                New-ItemProperty -Path $registerPath -Name $key[$i] -Value $value[$i] -PropertyType "string" -ErrorAction Stop | Out-Null
            }
        }
        catch {
            Write-Host "$($_.Exception.Message)"
        }
    }
}

function ListRegKey {
    Get-ChildItem -Path "HKLM:/Software" | Out-File RegKeys.log
    Write-Host "Clés sauvegardé dans RegKeys.log"
}


Write-Host "Voici les options possibles:"
Write-Host "1. Créer les répertoires"
Write-Host "2. Lister les répertoires"
Write-Host "3. Créer les clé de registre"
Write-Host "4. Lister les clés de registre"

$choice = 0

while (($choice -ne 1) -and ($choice -ne 2) -and ($choice -ne 3) -and ($choice -ne 4)) {
    $choice = Read-Host "Quel option voulez vous ? (1-4)"
}

if ($choice -eq 1) {
    $path = Read-Host "Chemin vers le csv"
    $delimiter = Read-Host "Delimiteur (;)"
    if ($delimiter -eq "") {
        $delimiter = ";"
    }
    
    CreatreFolder -path $path -delimiter $delimiter
}
elseif ($choice -eq 2) {
    $path = Read-Host "Chemin"
    $filter = Read-Host "Filtre (*.extention)"

    Write-Host "Sortie:"
    Write-Host "1. Console"
    Write-Host "2. Fichier avec résultat"
    $choice = 0
    while (($choice -ne 1) -and ($choice -ne 2)) {
        $choice = Read-Host "Quel option voulez vous ? (1-2)"
    }
    
    if ($choice -eq 1)
    {
        $output = "console"
    }
    else {
        $output = Read-Host "Chemin fichier de résultat"
    }

    ListFolder -path $path -filter $filter -output $output
}
elseif ($choice -eq 3) {

    $path = Read-Host "Chemin vers le csv"
    $delimiter = Read-Host "Delimiteur (;)"
    if ($delimiter -eq "") {
        $delimiter = ";"
    }

    Write-Host "Registre:"
    Write-Host "1. HKLM:/software"
    Write-Host "2. HKLM:/HARDWARE"

    $choice = 0
    while (($choice -ne 1) -and ($choice -ne 2)) {
        $choice = Read-Host "Quel option voulez vous ? (1-2)"
    }

    $RegPath = "HKLM:/software"
    if ($choice -eq 2) {
        $RegPath = "HKLM:/HARDWARE"
    }

    CreateRegKey -path $path -delimiter $delimiter -registerPath $RegPath
}
elseif ($choice -eq 4) {
    ListRegKey
}


# SIG # Begin signature block
# MIIFeQYJKoZIhvcNAQcCoIIFajCCBWYCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUTgwrAFvmpjnL29mt8U/KMuTH
# bd+gggMQMIIDDDCCAfSgAwIBAgIQIPDAWL/jfrdNhdvE0PJQPDANBgkqhkiG9w0B
# AQsFADAeMRwwGgYDVQQDDBNTaWduYXR1cmUgUi5SZW5ub2lyMB4XDTIxMDYwMTA4
# MzA1MloXDTIyMDYwMTA4NTA1MlowHjEcMBoGA1UEAwwTU2lnbmF0dXJlIFIuUmVu
# bm9pcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANZ2b9a1AmiBB77X
# /uGfjgCYR1gvNN4k/e818aVzQd0gbEz5aoa/uLOxguu5Y7/cx3rN7v8OFCM/PWdN
# XuKCmHEptur9YgAf9KuhmDpC3F3v97iD4v/K6DsSzUg50jolVSajHH0t7okQKOsd
# WsKInK+L131V+paSL0LTnSWcF7NwVTszJsgcpKnHWCQtSvk3GcRIqZSE3a9zt+Sy
# kvbKgUE+gR9MUHKgfr4H1ycCTfoKa8goo4Q2twLNsgKXS6f229itTDo8JDTjmEgh
# Fl019dnJUHrhKhbGhWd0o/+s5WVjYsFq6NKzhSomTNbj4teGmvf/vNQkU5P0a4xq
# 82TcWUUCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBSNLZZR6aMXPKt+wEeQefFd7Ruj2TANBgkqhkiG9w0BAQsF
# AAOCAQEAy/JHpxo11Mcb1FnrHOVjDCEAeDtIcbnlmjDEzqLsIYKs0f5JneUh6SvJ
# +xyyxNfBQbwdt707LoPuhRWgE+GVIu/x+vfvY4xz0spjEq0Aw1pjdYfZdP6W0Esn
# cX0UzaFuC2O+9wM8bXUefrBh4aUliwFJxsIprSBJHjK6OaAeG3w9JEybtOUJWUuj
# aKOw6GNIYy83x6YS9/imUQSRSa8Su5cAtscbgDqrf+fQ/tr+BA+WeGoiT33sCli3
# N25vPZZ8i62JS9KclULJxF7TYBt4pTxS5sCCj7eQXefzNwEgZJrTxeSHVMeKHM/3
# j7kLXFf4hbGjYjZeYYHbsh12cBmMtjGCAdMwggHPAgEBMDIwHjEcMBoGA1UEAwwT
# U2lnbmF0dXJlIFIuUmVubm9pcgIQIPDAWL/jfrdNhdvE0PJQPDAJBgUrDgMCGgUA
# oHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYB
# BAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0B
# CQQxFgQUenepkDqHozCnhCpCwGsjt8ANggIwDQYJKoZIhvcNAQEBBQAEggEAF8ex
# mN4YcwbdDT5lMMDfMkrHxMbGLtjC0vLy/7pxf4C5rZ6kKjdpSRu/f1tqhN4Qc/bU
# 4oU06g0SFGm+lSD4sgwjTGcGAIoVswkWmVwF8MJzrZU3aHtur6hA1f5TCQjcccnY
# igMdUXm3+EznAAsMa/WqtlCPkdHZzEVdATnIT0S0DlCmwcdAgBlPsbGSdugT0sTm
# TKjxlZ4Bezd+iUwaf1JaoIoVC3d8ujSAQuS8PQLTmDcHjrYj/wKYUSqA3C8deOhJ
# qUQIiBLoYTTDgETCTnyinY00TrAUIW/6adch5S9SRaXRxGQGeIM5cago7za2gZ/F
# 5Qx0MDGmPdIg14wrfQ==
# SIG # End signature block
