. ./functions/MeasureScriptBlock.ps1
. ./functions/ParseFile.ps1
. ./functions/GetFoldersSize.ps1

# Executar a lógica principal
$locations = ParseFile "locations.json"
# ou definir manualmente
# $locations = @{
#     "localhost" = @(
#         "C:\Users"
#     );
# }
Measure-ScriptBlock {
    ExecuteGetFoldersSize $locations
}
