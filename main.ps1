function Measure-ScriptBlock {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$ScriptBlock
    )

    $StartTime = Get-Date
    & $ScriptBlock
    $EndTime = Get-Date

    # Calculate elapsed time
    $ELAPSED_TIME = (New-TimeSpan -Start $StartTime -End $EndTime).ToString()

    # Display the formatted time
    Write-Host "=============================" -ForegroundColor Yellow
    Write-Host "Tempo Total: $ELAPSED_TIME" -ForegroundColor Yellow
    Write-Host "=============================" -ForegroundColor Yellow
}

function GetFoldersSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] $folderPath
    )

    Write-Host "Iniciando o processo em $($folderPath)..." -ForegroundColor Yellow

    Get-ChildItem -Force $folderPath -ErrorAction SilentlyContinue |
    Where-Object { $_ -is [IO.DirectoryInfo] } |
    Where-Object { $_.LinkType -notmatch "HardLink" } |
    Sort-Object FullName | ForEach-Object {

        $len = 0

        $folderName = $_.Name

        Get-ChildItem -Recurse -Force $_.FullName -ErrorAction SilentlyContinue | ForEach-Object {
            $len += $_.Length
        }

        [pscustomobject] @{
            Pasta   = $folderName;
            Tamanho = '{0:N2} GB' -f ($len / 1Gb);
        }

    } | Sort-Object Pasta | Format-Table @{ e = '*'; width = 40 }

    Write-Host "Processo concluido." -ForegroundColor Green
}

function ExecuteGetFoldersSize {
    # Localizações específicas dos servidores remotos
    # Hashables sempre recuperam informações em ordem alfabética
    # EX:
    # "server1" = @(
    #     "F:\FileServer"
    # );
    # "server2" = @(
    #     "E:\Fileserver"
    # );
    $locations = @{
        "localhost" = @(
            "C:\Users"
            "C:\Program Files"
        )
    }

    # Obter credentiais do usuário do servidor
    $Credentials = Get-Credential -Message "Insira as credenciais do usuario do servidor remoto"

    if ($null -eq $Credentials) {
        Write-Host "Credenciais nao informadas." -ForegroundColor Red
        return
    }

    # Loop através dos servidores remotos
    foreach ($location in $locations.Keys) {

        $ComputerName = $location

        Write-Host "==========================" -ForegroundColor Yellow
        Write-Host "Servidor: $($ComputerName)" -ForegroundColor Yellow
        Write-Host "==========================" -ForegroundColor Yellow


        foreach ($folderPath in $locations[$ComputerName]) {
            Write-Host "==========================" -ForegroundColor Green
            Write-Host "Pasta: $($folderPath)" -ForegroundColor Green
            Write-Host "==========================" -ForegroundColor Green

            # Localização do servidor remoto com o nome do servidor e a pasta a ser verificada no servidor Windows
            $ErrorActionPreference = "Stop"
            # Opcionalmente, configurar para ignorar os erros
            # $ErrorActionPreference = "SilentlyContinue"
            $remote = $ComputerName -ne 'localhost'

            # Se for remoto, testar conexão
            if ($remote) {
                Test-Connection -ComputerName $ComputerName -Count 1 |
                Format-List -Property PSComputerName, Address, IPV4Address, IPV6Address

                Test-WSMan $ComputerName

                $session = New-PSSession -ComputerName $ComputerName -Credential $Credentials
                $session.ToString()

                # Executar script em servidor remoto
                Invoke-Command -ComputerName $ComputerName -ScriptBlock ${Function:GetFoldersSize} -ArgumentList $folderPath -Credential $Credentials
            }
            else {
                # Executar script em localhost
                Invoke-Command -ScriptBlock ${Function:GetFoldersSize} -ArgumentList $folderPath
            }
        }
    }
}

Measure-ScriptBlock {
    ExecuteGetFoldersSize
}
