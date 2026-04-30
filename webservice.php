<?php
header("Content-Type: application/json; charset=utf-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];
$path   = $_SERVER['PATH_INFO'] ?? '/';

switch (true) {

    // POST /api/mysql/users — créer un utilisateur MySQL
    case $method === 'POST' && $path === '/api/mysql/users':
        $body = json_decode(file_get_contents('php://input'), true);

        // Validation
        foreach (['username', 'password'] as $field) {
            if (empty($body[$field])) {
                http_response_code(400);
                echo json_encode(["error" => "Champ manquant : $field"]);
                exit;
            }
        }

        // Sécurité : username alphanumérique uniquement
        if (!preg_match('/^[a-zA-Z0-9_]{1,16}$/', $body['username'])) {
            http_response_code(400);
            echo json_encode(["error" => "Username invalide (max 16 cars, alphanumérique)"]);
            exit;
        }

        $result = callPowerShell("add_mysql_user.ps1", [
            "NewUser"     => $body['username'],
            "NewPassword" => $body['password'],
            "Database"    => $body['database'] ?? "ap_bdd",
            "DbHost"        => $body['host']     ?? "localhost",
        ]);

        error_log("Sortie PowerShell : " . print_r($result, true));

        http_response_code($result['success'] ? 201 : 500);
        echo json_encode($result);
        break;

    default:
        http_response_code(404);
        echo json_encode(["error" => "Route not found"]);
        break;
}

function callPowerShell(string $script, array $params = []): array
{
    $args = '';
    foreach ($params as $key => $value) {
        $args .= " -$key " . escapeshellarg($value);
    }

    $cmd    = "powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $script $args 2>&1";
    $output = shell_exec($cmd);

    if ($output === null) {
        return ["success" => false, "error" => "PS1 execution failed"];
    }

    $decoded = json_decode(trim($output), true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        return ["success" => false, "error" => "Invalid JSON from PS1", "raw" => $output];
    }

    return $decoded;
}