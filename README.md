# Get Folders Size

Get Folders Size é um projeto de script PowerShell que tem como objetivo obter o tamanho total de pastas em diferentes servidores, sejam eles locais ou remotos. Ele utiliza as funções Measure-ScriptBlock e GetFoldersSize para medir o tempo de execução e percorrer as pastas e arquivos, respectivamente.

O projeto foi criado pelo autor Gabriel Almir (usuário momentoalmir no GitHub) sob a licença MIT, o que significa que ele pode ser usado e modificado livremente desde que sejam respeitados os termos da licença.

# Como baixar e executar o script

Para executar o script, basta seguir os seguintes passos:

Baixe o arquivo "script.ps1" neste repositório.
Abra o PowerShell em modo administrador.
Navegue até o diretório onde o arquivo "script.ps1" foi baixado.
Execute o comando "Set-ExecutionPolicy RemoteSigned" para permitir a execução de scripts PowerShell.
Execute o comando ".\script.ps1" para executar o script.

# Funcionamento do script

O script consiste em obter o tamanho total de arquivos em pastas de servidores remotos. Para isso, ele utiliza as funções "GetFoldersSize", "ExecuteGetFoldersSize" e "Measure-ScriptBlock".

A função "GetFoldersSize" é responsável por obter o tamanho total de arquivos em uma determinada pasta de um servidor remoto. Ela recebe como parâmetro o caminho da pasta a ser verificada e utiliza o cmdlet "Get-ChildItem" para obter a lista de arquivos e subpastas da pasta. Em seguida, ela calcula o tamanho total dos arquivos da pasta e retorna o resultado em formato de objeto personalizado.

A função "ExecuteGetFoldersSize" é responsável por executar a função "GetFoldersSize" em diversos servidores remotos. Ela recebe como parâmetro uma hash table contendo as localizações dos servidores remotos e as pastas a serem verificadas. Em seguida, ela percorre cada servidor remoto e cada pasta a ser verificada e executa a função "GetFoldersSize" para obter o tamanho total de arquivos em cada pasta.

A função "Measure-ScriptBlock" é responsável por medir o tempo total de execução do script. Ela recebe como parâmetro um bloco de script e calcula o tempo total de execução desse bloco. Em seguida, ela exibe o tempo total de execução na tela.

# Licença

Este projeto é licenciado sob a licença MIT. Consulte o arquivo (LICENSE)[LICENSE] para obter mais informações.
