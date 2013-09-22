<?php


$posturl = $_GET['u'];

//provide your snapito api key

$api_key = " ";


$photo_url = "http://api.snapito.com/web/$api_key/lc?url=$posturl?fast";





header("Location: $photo_url");



?>
