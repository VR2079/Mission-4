<?php

header("Content-Type: application/json");


require "db.php";


$method = $_SERVER["REQUEST_METHOD"];


// Récupération des utilisateurs

if ($method == "GET") {

$stmt = $pdo->query("SELECT * FROM users");

$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($users);

}


// Ajout d’un utilisateur

if ($method == "POST") {

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data["name"]) && isset($data["email"])) {

$stmt = $pdo->prepare("INSERT INTO users (name, email) VALUES (:name, :email)");

$stmt->execute(["name" => $data["name"], "email" => $data["email"]]);

echo json_encode(["message" => "Utilisateur ajouté"]);

} else {

echo json_encode(["error" => "Données manquantes"]);

}

}


// Suppression d’un utilisateur

if ($method == "DELETE") {

if (isset($_GET["id"])) {

$stmt = $pdo->prepare("DELETE FROM users WHERE id = :id");

$stmt->execute(["id" => $_GET["id"]]);

echo json_encode(["message" => "Utilisateur supprimé"]);

} else {

echo json_encode(["error" => "ID manquant"]);

}

}

?>