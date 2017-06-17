<?php

require_once 'vendor/autoload.php';
require_once 'vendor/mashape/unirest-php/src/Unirest.php';

// These code snippets use an open-source library. http://unirest.io/php

$input = $_GET['url'];

$response = Unirest\Request::get("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract?forceExtraction=false&url=" . "$input",
  array(
    "X-Mashape-Key" => "Z5awmF4951mshriAJrQnjykAAwvLp1Eo2TrjsnaxC5oOOqIUdB"
  )
);

print_r($response);

?>