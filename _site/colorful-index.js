var projectGroupsLeft = document.getElementsByClassName("block-group-left")
var projectGroupsRight = document.getElementsByClassName("block-group-right")

var delay = 0.0;
for(i = 0; i < projectGroupsLeft.length; i++) {
    projectGroupsLeft[i].style.backgroundColor = randomColor();
    projectGroupsLeft[i].style.animationDelay = delay + "s";
    delay += 0.1;
}

var delay = 0.0;
for(i = 0; i < projectGroupsRight.length; i++) {
    projectGroupsRight[i].style.backgroundColor = randomColor();
    projectGroupsRight[i].style.animationDelay = delay + "s";
    delay += 0.1;
}


function randomColor() {
    var r = Math.floor(Math.random() * 192 + 64)
    var g = Math.floor(Math.random() * 96 + 160)
    var b = Math.floor(Math.random() * 192 + 64)
    return rgbToColorString(r,g,b)
}


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
