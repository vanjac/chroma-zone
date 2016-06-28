projectGroupsLeft = document.getElementsByClassName("block-group-left")
projectGroupsRight = document.getElementsByClassName("block-group-right")

for(i = 0; i < projectGroupsLeft.length; i++) {
    projectGroupsLeft[i].style.backgroundColor = randomColor();
}

for(i = 0; i < projectGroupsRight.length; i++) {
    projectGroupsRight[i].style.backgroundColor = randomColor();
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
