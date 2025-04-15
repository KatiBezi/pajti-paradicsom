<?php

// EZ KÉSZ

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

$query = "SELECT `id`, `password`
          FROM `users`
          WHERE username = :username
          LIMIT 1";

$result = $db->execute($query, ['username' => $args['username']]);

$db = null;

if (is_null($result))
    Util::setError('Hibás felhasználónév!');

$user = $result[0];
if ($args['password'] !== $user['password'])
    Util::setError('Hibás jelszó!');

Util::setResponse(['user_id' => $user['id']]);
?>
