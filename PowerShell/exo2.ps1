function Set-RegKey ($nom, $valeur) {
    New-ItemProperty -Path HKLM:\SOFTWARE\ -Name $nom -Value $valeur -PropertyType "string"
}


function Write-Log ($message, $chemin) {
    $DateAction = Get-Date -Format yyyymmdd-hh:mm:ss
    $MessageComplet = $DateAction + "> " + $message
    $MessageComplet | Out-File -FilePath $chemin -Append
    Write-Host $MessageComplet
}


$logPath = "C:\exo2.log"
$keys = @{"Test-Version" = 2.0; "Test-Region" = "Belgium" }

Write-Log -chemin $logPath -message "Début script"

foreach ($key in $keys.Keys) {
    $message = "Création de la clé {0}, valeur {1}" -f $key, $keys[$key]
    Write-Log -chemin $logPath -message $message
    Set-RegKey -nom "$key" -valeur $keys[$key]
}

Write-Log -chemin $logPath -message "Fin script"
