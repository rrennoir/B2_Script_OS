Write-Host "Give a sentence:"
$text = Read-Host
$inverse = ""

if (($text -is [string])) {
    $text = $text.ToString()
}

$TabText = $text.Split()

foreach ($word in $TabText) {
    $lenght = $word.Length

    for ($i = 0; $i -lt $lenght; $i++) {
        $inverse += $word[$lenght - 1 - $i]
    }
    $inverse += " "
}

Write-Host $inverse -ForegroundColor Green
