<?php
//EZ KÉSZ
declare(strict_types=1);

require_once("../../common/php/environment.php");

session_start();
session_unset();
session_destroy();

Util::setResponse(['success' => true, 'message' => 'Sikeres kijelentkezés!']);
