
document.getElementById("colorbox").value = "";

var r = Math.floor(Math.random() * 16)
var g = Math.floor(Math.random() * 16)
var b = Math.floor(Math.random() * 16)
var colorHex = "#"
    + (numberToHexString(r))
    + (numberToHexString(g))
    + (numberToHexString(b));
document.body.style.backgroundColor = colorHex;
console.log(colorHex);

function numberToHexString(num) {
    return num.toString(16);
}

function buttonClicked() {
    var testHex = document.getElementById("colorbox").value;
    var testR = parseInt(testHex[0], 16);
    var testG = parseInt(testHex[1], 16);
    var testB = parseInt(testHex[2], 16);

    // 0 to 1
    accuracy = 1 -
	(Math.abs(testR - r) + Math.abs(testG - g) + Math.abs(testB - b)) / 48;
    document.getElementById("answer").innerHTML = "Correct answer: " + colorHex
	+ "<br>" + (Math.round(accuracy * 100)) + "%";
}
