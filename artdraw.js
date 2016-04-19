var canvas = document.getElementById("artCanvas");
var ctx = canvas.getContext("2d");
var width = parseInt(canvas.getAttribute("width"));
var height = parseInt(canvas.getAttribute("height"));


//test
ctx.fillStyle = "red";
ctx.beginPath();
ctx.arc(width/2, height/2, height/2, 0, 2*Math.PI);
ctx.fill();

//start drawing...

var numObjects = Math.floor(Math.random() * 3);
