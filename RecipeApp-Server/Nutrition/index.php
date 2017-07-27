<?php


// These code snippets use an open-source library. http://unirest.io/php
//require_once 'vendor/autoload.php';
require_once 'vendor/mashape/unirest-php/src/Unirest.php';


$input = $_GET['Ingredients'];

$headers = array(
    "X-Mashape-Key" => "mPZZOY7rcAmshAag3JgFe658SArXp1nTyCijsn1ql5w7sUPolH",
    "Accept" => "text/html",
  );
$data =  array(
    "defaultCss" => "true",
    "ingredientList" => $input,
    "servings" => 2,
    "showBacklink" => true
  );
$body = Unirest\Request\Body::form($data);

$response = Unirest\Request::post('https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/visualizeNutrition', $headers, $body);

print_r($response->body);

?>		