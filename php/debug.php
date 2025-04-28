<?php
declare(strict_types=1);

$query = "UPDATE `users` SET `email` = 'bezi.katalin@gmail.com', `phone` = '+36202456783' WHERE `id` = 3 AND `user_id` = 3";

require_once('./updateUserData.php');
