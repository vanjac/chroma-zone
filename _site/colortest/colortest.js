
document.getElementById("colorbox").value = "";

var tries = 0;

var r = Math.floor(Math.random() * 16)
var g = Math.floor(Math.random() * 16)
var b = Math.floor(Math.random() * 16)
var colorHex = "#"
    + (numberToHexString(r))
    + (numberToHexString(g))
    + (numberToHexString(b));
document.body.style.backgroundColor = colorHex;
console.log(colorHex);

var invertedR = r < 8 ? 15 : 0;
var invertedG = g < 8 ? 15 : 0;
var invertedB = b < 8 ? 15 : 0;
var invertedColorHex = "#"
    + (numberToHexString(invertedR))
    + (numberToHexString(invertedG))
    + (numberToHexString(invertedB));

document.getElementById("answer").style.color = invertedColorHex;


function numberToHexString(num) {
    return num.toString(16);
}

function buttonClicked() {
    tries += 1;
    
    var testHex = document.getElementById("colorbox").value;
    var testR = parseInt(testHex[0], 16);
    var testG = parseInt(testHex[1], 16);
    var testB = parseInt(testHex[2], 16);

    // 0 to 1
    accuracy = 1 -
	(Math.abs(testR - r) + Math.abs(testG - g) + Math.abs(testB - b)) / 48;
    
    var answerElement = document.getElementById("answer");
    if(accuracy == 1)
	answerElement.innerHTML = "Correct!";
    else
	answerElement.innerHTML = 
	(Math.round(accuracy * 100)) + "%";
    if(tries == 1)
	answerElement.innerHTML += "<br>1 try.";
    else
	answerElement.innerHTML += "<br>" + tries + " tries.";

    document.getElementById("colorrect").style.backgroundColor = "#" + testHex;
}
