<?php

require_once 'vendor/autoload.php';
require_once 'vendor/mashape/unirest-php/src/Unirest.php';

$input = $_GET['url'];

$headers = array(
	"X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "X-RapidAPI-Key" => "PMSfoVRZ9vmshOZLZwIytrdaNxHop1VoClVjsnxxW2dKy7r6N6",
        "Accept" => "application/json"
 );

$response = Unirest\Request::get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/extract?url=". $input, $headers);


print_r($response->raw_body);

?>