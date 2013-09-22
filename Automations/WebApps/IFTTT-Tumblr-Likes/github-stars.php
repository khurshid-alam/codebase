<?php


$posturl = $_GET['u'];

$photo_url = "http://api.snapito.com/web/7b40608387df3c5cd9ec264e29ea8a5d61d3b6b8/lc?url=$posturl?fast";





header("Location: $photo_url");



?>
