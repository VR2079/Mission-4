-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 10 avr. 2026 à 08:13
-- Version du serveur : 8.2.0
-- Version de PHP : 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ap_bdd`
--

-- --------------------------------------------------------

--
-- Structure de la table `consoles`
--

CREATE TABLE `consoles` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `consoles`
--

INSERT INTO `consoles` (`id`, `name`) VALUES
(4, 'Nintendo Switch 1'),
(5, 'Nintendo Switch 2'),
(1, 'PC'),
(2, 'PlayStation 5'),
(3, 'Xbox Series X/S');

-- --------------------------------------------------------

--
-- Structure de la table `games`
--

CREATE TABLE `games` (
  `id` int NOT NULL,
  `console_id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `games`
--

INSERT INTO `games` (`id`, `console_id`, `name`) VALUES
(21, 1, 'Valorant'),
(22, 1, 'Rocket League'),
(23, 1, 'Fortnite'),
(24, 1, 'CS:GO\r\n'),
(25, 1, 'League of Legends'),
(26, 2, 'Fortnite'),
(27, 3, 'Fortnite'),
(28, 4, 'Fortnite'),
(29, 5, 'Fortnite'),
(30, 4, 'Mario Kart 8 Deluxe'),
(31, 5, 'Mario Kart World'),
(37, 4, 'Super Smash Bros Ultimate'),
(38, 5, 'Super Smash Bros Ultimate'),
(39, 2, 'Valorant'),
(40, 3, 'Valorant'),
(41, 2, 'Call Of Duty : Black Ops 7'),
(42, 1, 'Call Of Duty : Black Ops 7'),
(43, 3, 'Call Of Duty : Black Ops 7'),
(44, 2, 'EA Sports FC 26'),
(45, 3, 'EA Sports FC 26'),
(46, 2, 'Gran Turismo 7'),
(47, 2, 'Mortal Kombat 1'),
(48, 3, 'Forza Horizon 5'),
(49, 3, 'Rocket League'),
(50, 4, 'Splatoon 3'),
(51, 4, 'Tetris 99'),
(52, 4, 'Hyrule Warriors : Age Of Calamity'),
(53, 5, 'Hyrule Warriors : Age Of Imprisonment');

-- --------------------------------------------------------

--
-- Structure de la table `matches`
--

CREATE TABLE `matches` (
  `id` int NOT NULL,
  `team_id` int NOT NULL,
  `opponent` varchar(150) DEFAULT NULL,
  `console_id` int NOT NULL,
  `game_id` int NOT NULL,
  `match_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `matches`
--

INSERT INTO `matches` (`id`, `team_id`, `opponent`, `console_id`, `game_id`, `match_date`, `created_at`) VALUES
(16, 4, 'Alpha', 5, 38, '2025-12-05 15:30:00', '2025-11-14 09:25:11'),
(17, 4, 'Team solo', 2, 46, '2025-12-26 15:00:00', '2025-12-19 13:56:26');

-- --------------------------------------------------------

--
-- Structure de la table `teams`
--

CREATE TABLE `teams` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `teams`
--

INSERT INTO `teams` (`id`, `name`) VALUES
(1, 'Alpha'),
(2, 'Beta'),
(3, 'Delta'),
(4, 'Gamma');

-- --------------------------------------------------------

--
-- Structure de la table `tournois`
--

CREATE TABLE `tournois` (
  `id` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `jeu` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `cashprize` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@cgca.com', '$2y$10$O7wZDiaAOLxmLj3fhj4OvejHx56Dd0YZOB3DqCQeTD.sJOnowUr1G', 'admin', '2025-09-05 08:18:37'),
(2, 'user', 'user@cgca.com', '$2y$10$KJtg.gHzEDmqmZj7r9LoBeAhmDIFxMUMPTt4WRce47oWyyMoe15eS', 'user', '2025-09-05 12:03:26'),
(3, 'test', 'test@essai.com', '$2y$10$02VwxNnLWssTtPCqDeX3l.hDET1fulCevbIXiqUPfiDLkuFfCkBJS', 'user', '2025-11-13 13:59:06'),
(4, 'tom', 'tom@pere.fr', '$2y$10$ezYfkpzubEsKX0jpSQAjMe6EckppXML6McWm2J4ODlzj/er6OnbAW', 'user', '2025-11-14 07:56:27'),
(5, 'V', 'v@cgca.com', '$2y$10$A/IcdgtueSv5TRoNBlX7tuqZ1zdHKSothZ5dVZO5/o57BnWd0Y9LC', 'admin', '2025-12-18 13:55:03'),
(9, 'admin2', 'admin2@cgca.com', '$2y$10$Z1jUt5NA.ok5BgIhesgpqe3P0LI0qiO55sK7nGwSY6h2ZUdXarFem', 'admin', '2026-03-13 10:24:33');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `consoles`
--
ALTER TABLE `consoles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `console_id` (`console_id`);

--
-- Index pour la table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `console_id` (`console_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Index pour la table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `tournois`
--
ALTER TABLE `tournois`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `consoles`
--
ALTER TABLE `consoles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `games`
--
ALTER TABLE `games`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `tournois`
--
ALTER TABLE `tournois`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `games_ibfk_1` FOREIGN KEY (`console_id`) REFERENCES `consoles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`console_id`) REFERENCES `consoles` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `matches_ibfk_3` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
