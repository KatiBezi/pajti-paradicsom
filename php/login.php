<?php
declare(strict_types=1);
session_start();
require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

$query = "SELECT `id`, `password`
          FROM `users`
          WHERE username = :username
          LIMIT 1";

$result = $db->execute($query, ['username' => $args['username']]);

$db = null;

if (empty($result)) {
    Util::setError('Hibás felhasználónév!');
} else {
    $user = $result[0];

    if ($args['password'] === $user['password']) {
        // Mentjük a felhasználói ID-t session-be
        $_SESSION['user_id'] = $user['id'];

        Util::setResponse([
            'user_id' => $user['id'],
            'message' => 'Sikeres bejelentkezés!'
        ]);
    } else {
        Util::setError('Hibás jelszó!');
    }
}
?>
