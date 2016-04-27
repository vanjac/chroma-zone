const FLOAT_SIZE = 4; //number of bytes in a float
const MAX_RANDOM_NUMBERS = 1024;

var randomCount = 0;
var randomView = new DataView(new ArrayBuffer(MAX_RANDOM_NUMBERS * FLOAT_SIZE));
// if false, write random numbers to randomView
// if true, read random numbers from randomView
var readRandom = false;

//check for permalink query string
if(getParameterByName("b") !=null) {
    console.log("Permalink!");
    loadRandomBase64(getParameterByName("b"));
}


function random() {
    var r;
    if(readRandom) {
	r = randomView.getFloat32((randomCount++) * FLOAT_SIZE);
    } else {
	r = Math.random();
	randomView.setFloat32((randomCount++) * FLOAT_SIZE, r);
    }
    return r;
}

// max is exclusive
function randomInt(max) {
    return Math.floor((random() * max));
}

// after choosing a random item, removes it so it won't be used again
function randomItem(array) {
    var index = randomInt(array.length);
    var item = array[index];
    array.splice(index, 1);
    return item;
}


// from: http://stackoverflow.com/a/901144
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}


function getRandomBase64() {
    var dataString = "";
    for(var i = 0; i < randomCount * FLOAT_SIZE; i++) {
	dataString += String.fromCharCode(randomView.getUint8(i));
    }
    var base64String = btoa(dataString);
    
    return base64String;
}

function loadRandomBase64(base64String) {
    readRandom = true;
    // +s are replaced with spaces in query strings
    // replace all
    base64String = base64String.split(" ").join("+");
    var dataString = atob(base64String);
    for(var i = 0; i < dataString.length; i++) {
	randomView.setUint8(i, dataString.charCodeAt(i));
    }
}
