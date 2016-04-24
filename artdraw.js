var canvas = document.getElementById("artCanvas");
var ctx = canvas.getContext("2d");
var width = parseInt(canvas.getAttribute("width"));
var height = parseInt(canvas.getAttribute("height"));


// object draw functions

var drawBackground = function() {
    console.log("background");
    ctx.fillRect(0, 0, width, height);
}

var drawHorizFill = function() {
    console.log("horiz fill");
    var y = random() * height;
    if(random() < .5) {
	ctx.fillRect(0, 0, width, y);
    } else {
	ctx.fillRect(0, y, width, height - y);
    }
}

var drawVertFill = function() {
    console.log("vert fill");
    var x = random() * width;
    if(random() < .5) {
	ctx.fillRect(0, 0, x, height);
    } else {
	ctx.fillRect(x, 0, width - x, height);
    }
}

var drawHorizLine = function() {
    console.log("horiz line");
    var y = random() * height;
    ctx.beginPath();
    ctx.lineCap="butt";
    ctx.moveTo(0, y);
    ctx.lineTo(width, y);
    ctx.stroke();
}

var drawVertLine = function() {
    console.log("vert line");
    var x = random() * width;
    ctx.beginPath();
    ctx.lineCap="butt";
    ctx.moveTo(x, 0);
    ctx.lineTo(x, height);
    ctx.stroke();
}

var drawLine = function() {
    console.log("line");
    var x1 = random() * width;
    var x2 = random() * width;
    var y1 = random() * height;
    var y2 = random() * height;
    ctx.beginPath();
    ctx.lineCap="round";
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.stroke();
}

var drawRect = function() {
    console.log("rect");
    var x = random() * width;
    var rWidth = random() * (width - x);
    var y = random() * height;
    var rHeight = random() * (height - y);

    ctx.fillRect(x, y, rWidth, rHeight);
}

var drawCircleFilled = function() {
    console.log("filled circle");
    var x = random() * width;
    var y = random() * height;
    var radius = random() * width;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2*Math.PI);
    ctx.fill();
}

var drawCircleStroke = function() {
    console.log("circle stroke");
    var x = random() * width;
    var y = random() * height;
    var radius = random() * width / 2;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2*Math.PI);
    ctx.stroke();
}

var drawScribble = function() {
    console.log("scribble");
    var x = random() * width;
    var y = random() * height;
    var numSegments = randomInt(128);
    ctx.beginPath();
    ctx.lineCap="round";
    ctx.moveTo(x, y);
    for(var i = 0; i < numSegments; i++) {
	x += random() * 16 - 8;
	y += random() * 16 - 8;
	ctx.lineTo(x, y);
    }
    ctx.stroke();
}

var drawCrookedLine = function() {
    console.log("crooked line");
    var x = random() * width;
    var y = random() * height;
    var xChange = random() * 64 - 32;
    var yChange = random() * 64 - 32;
    var numSegments = randomInt(10);
    ctx.beginPath();
    ctx.lineCap="round";
    ctx.moveTo(x, y);
    for(var i = 0; i < numSegments; i++) {
	x += xChange;
	y += yChange;
	xChange += random() * 16 - 8;
	yChange += random() * 16 - 8;
	ctx.lineTo(x, y);
    }
    ctx.stroke();
}

var drawFunctions = [ 
    drawBackground, drawHorizFill, drawVertFill, drawHorizLine, drawVertLine,
    drawLine, drawRect, drawCircleFilled, drawCircleStroke, drawScribble,
    drawCrookedLine
];


// color utilities

function rgbToColorString(r, g, b) {
    return "#"
	    + (numberToHexString(r))
	    + (numberToHexString(g))
	    + (numberToHexString(b));
}

// guaranteed to be at least 2 digits
function numberToHexString(num) {
    var string = num.toString(16);
    if(string.length == 1)
	string = "0" + string;
    return string;
}

function hsbToColorString(h, s, v) {
    // from http://stackoverflow.com/a/17243070

    h /= 256;
    s /= 256;
    v /= 256;

    var r, g, b, i, f, p, q, t;
    i = Math.floor(h * 6);
    f = h * 6 - i;
    p = v * (1 - s);
    q = v * (1 - f * s);
    t = v * (1 - (1 - f) * s);
    switch (i % 6) {
    case 0: r = v, g = t, b = p; break;
    case 1: r = q, g = v, b = p; break;
    case 2: r = p, g = v, b = t; break;
    case 3: r = p, g = q, b = v; break;
    case 4: r = t, g = p, b = v; break;
    case 5: r = v, g = p, b = q; break;
    }
    
    r = Math.round(r * 255);
    g = Math.round(g * 255);
    b = Math.round(b * 255);
    return rgbToColorString(r, g, b);
}

function randomStyle() {
    if(random() < .5) {
	//gradient
	var h1 = randomInt(256);
	var s1 = randomInt(256);
	var b1 = randomInt(256);

	var h2 = h1 + (random() * 64 - 32);
	if(h2 < 0)
	    h2 += 256;
	if(h2 >= 256)
	    h2 -= 256;
	var s2 = s1 + (random() * 64 - 32);
	if(s2 < 0)
	    s2 = 0;
	if(s2 >= 256)
	    s2 = 255;
	var b2 = b1 + (random() * 64 - 32);
	if(b2 < 0)
	    b2 = 0;
	if(b2 >= 256)
	    b2 = 255;
	
	var gradient;
	if(random() < .5) {
	    gradient = ctx.createLinearGradient(0, height/2, width, height/2);
	} else {
	    gradient = ctx.createLinearGradient(width/2, 0, width/2, height);
	}
	gradient.addColorStop(0, hsbToColorString(h1, s1, b1));
	gradient.addColorStop(1, hsbToColorString(h2, s2, b2));
	return gradient;
    } else {
	//solid
	var r = randomInt(256);
	var g = randomInt(256);
	var b = randomInt(256);
	return rgbToColorString(r, g, b);
    }
}

function randomFill() {
    ctx.fillStyle = randomStyle();
}

function randomStroke() {
    ctx.strokeStyle = randomStyle();
    ctx.lineWidth = random() * 8;
}

// draw objects...

var numObjects = randomInt(5);
console.log(numObjects + " objects");

for(var i = 0; i < numObjects; i++) {
    randomFill();
    randomStroke();
    var drawFunction = drawFunctions[ randomInt(drawFunctions.length) ];
    drawFunction();
}
