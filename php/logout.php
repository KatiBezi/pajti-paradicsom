<?php
session_start(); // Session indítása

// Session törlése
session_unset();
session_destroy();

echo json_encode(['success' => true]);
?>