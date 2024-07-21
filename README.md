
# 👽 Get Folders Size

Get Folders Size é um projeto em Rust que tem como objetivo obter o tamanho total de pastas em diferentes servidores locais. Ele utiliza as funções `get_folders_size` e `parse_json_file` para medir o tempo de execução e percorrer as pastas e arquivos, respectivamente.

O projeto foi criado pelo autor [Gabriel Almir (gabrielalmir)](http://github.com/gabrielalmir) sob a licença MIT, o que significa que ele pode ser usado e modificado livremente desde que sejam respeitados os termos da licença.

## 🛠️ Como baixar e executar o projeto

Para executar o projeto, basta seguir os seguintes passos:

1. Certifique-se de ter o Rust instalado. Caso não tenha, siga as instruções em [https://www.rust-lang.org/tools/install](https://www.rust-lang.org/tools/install).
2. Clone este repositório:
   ```sh
   git clone https://github.com/momentoalmir/get-folders-size.git
   ```
3. Navegue até o diretório do projeto:
   ```sh
   cd get-folders-size
   ```
4. Crie um arquivo `locations.json` com o seguinte formato:
   ```json
   {
       "localhost": [
           "C:\Windows\System32",
           "C:\Users"
       ]
   }
   ```
5. Compile e execute o projeto:
   ```sh
   cargo run
   ```

## ▶️ Funcionamento do projeto

O projeto consiste em obter o tamanho total de arquivos em pastas de servidores locais. Para isso, ele utiliza as funções `get_folders_size` e `parse_json_file`.

A função `get_folders_size` é responsável por obter o tamanho total de arquivos em uma determinada pasta. Ela recebe como parâmetro o caminho da pasta a ser verificada e utiliza a biblioteca `walkdir` para obter a lista de arquivos e subpastas da pasta. Em seguida, ela calcula o tamanho total dos arquivos da pasta e retorna o resultado.

A função `parse_json_file` é responsável por ler o arquivo JSON contendo as localizações das pastas a serem verificadas. Ela recebe como parâmetro o caminho do arquivo JSON, lê seu conteúdo e o converte em um objeto `Locations`.

## 📘 Licença

Este projeto é licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter mais informações.
