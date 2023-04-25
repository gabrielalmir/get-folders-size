function ParseFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    # Obter a extensão do arquivo
    $extension = [System.IO.Path]::GetExtension($FilePath)

    # Verificar a extensão do arquivo
    switch ($extension.ToLower()) {
        # JSON
        ".json" {
            return ParseJsonFile $FilePath
        }
        # Extensão não suportada
        default {
            Write-Host "Extensao nao suportada." -ForegroundColor Red
            return
        }
    }
}

function ParseJsonFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    # Ler arquivo JSON e converter para objeto Hashable
    $json = (Get-Content $FilePath -Raw | ConvertFrom-Json)

    # Criar objeto Hashable
    $hash = @{}

    # Loop através das propriedades do objeto JSON
    foreach ($item in $json.PSObject.Properties) {
        # $hash[$item.Name] = $item.Value
        if ($null -eq $hash[$item.Name]) {
            $hash[$item.Name] = @()
        }
        $hash[$item.Name] += $item.Value
    }

    # Retornar objeto Hashable
    return $hash
}
