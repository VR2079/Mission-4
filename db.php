<?php

$host = "localhost";

$dbname = "ap_bdd";

$username = "root";

$password = "root";


try {

$pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);

$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (PDOException $e) {

die("Erreur de connexion : " . $e->getMessage());

}

?>