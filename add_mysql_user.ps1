param(
    [string]$NewUser,
    [string]$NewPassword,
    [string]$Database = "*",
    [string]$DbHost   = "localhost"
)

$mysqlExe  = "C:\Users\Victor\UniServerZ\core\mysql\bin\mysql.exe"
$mysqlHost = "localhost"
$mysqlPort = "3306"
$mysqlUser = "root"
$mysqlPass = "root"

if (-not (Test-Path $mysqlExe)) {
    @{ success = $false; error = "mysql.exe introuvable : $mysqlExe" } | ConvertTo-Json -Compress
    exit
}

if ($Database -eq "*") {
    $dbTarget = "*.*"
} else {
    $dbTarget = $Database + ".*"
}

$cnfFile = "$env:TEMP\mysql_tmp.cnf"
@"
[client]
user=$mysqlUser
password=$mysqlPass
host=$mysqlHost
port=$mysqlPort
"@ | Out-File -FilePath $cnfFile -Encoding ascii -NoNewline

try {
    $queries = @(
        "CREATE USER IF NOT EXISTS '${NewUser}'@'${DbHost}' IDENTIFIED BY '${NewPassword}';"
        "GRANT ALL PRIVILEGES ON ${dbTarget} TO '${NewUser}'@'${DbHost}';"
        "FLUSH PRIVILEGES;"
    )

    foreach ($query in $queries) {
        $output   = & $mysqlExe --defaults-file="$cnfFile" --execute="$query" 2>&1
        $exitCode = $LASTEXITCODE

        if ($exitCode -ne 0) {
            Remove-Item $cnfFile -Force -ErrorAction SilentlyContinue
            @{
                success   = $false
                exitCode  = $exitCode
                error     = ($output -join " ")
                failedSQL = $query
            } | ConvertTo-Json -Compress
            exit
        }
    }

    Remove-Item $cnfFile -Force -ErrorAction SilentlyContinue

    @{
        success  = $true
        message  = "Utilisateur MySQL créé"
        user     = $NewUser
        host     = $DbHost
        database = $dbTarget
        grants   = "ALL PRIVILEGES"
    } | ConvertTo-Json -Compress

} catch {
    Remove-Item $cnfFile -Force -ErrorAction SilentlyContinue
    @{ success = $false; error = $_.Exception.Message } | ConvertTo-Json -Compress
}