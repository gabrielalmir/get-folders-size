function Measure-ScriptBlock {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$ScriptBlock
    )

    # Iniciar o tempo de execução do script
    $StartTime = Get-Date
    & $ScriptBlock
    $EndTime = Get-Date

    # Calcular o  tempo total de execução do script
    $ELAPSED_TIME = (New-TimeSpan -Start $StartTime -End $EndTime).ToString()

    # Mostre o tempo total de execução do script
    Write-Host "=============================" -ForegroundColor Yellow
    Write-Host "Tempo Total: $ELAPSED_TIME" -ForegroundColor Yellow
    Write-Host "=============================" -ForegroundColor Yellow
}
