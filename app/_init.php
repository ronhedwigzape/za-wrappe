<?php

header('Access-Control-Allow-Origin: http://localhost:5004');
header("Access-Control-Allow-Credentials: true");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
session_start();
require_once __DIR__ . '/../vendor/autoload.php';

require_once 'config/database.php';

function denyAccess(): void
{
    require_once 'models/App.php';
    App::returnError('HTTP/1.1 401', 'Access Denied!');
}

function getUser(): ?array
{
    require_once 'models/User.php';
    return User::getUser();
}