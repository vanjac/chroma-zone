// seedrandom.min.js by David Bau.
// github.com/davidbau/seedrandom

const SEED_LENGTH = 16;
var seed;

//check for permalink query string
if(getParameterByName("b") !=null) { //use specified seed
    console.log("Permalink!");
    var base64String = getParameterByName("b");
    // +s are replaced with spaces in query strings
    // replace all
    base64String = base64String.split(" ").join("+");
    seed = atob(base64String);
    if(getParameterByName("v") != null) {
        version = getParameterByName("v");
    } else {
        // always default to the oldest version. don't update this!
        version = 0
    }
} else { //generate a new seed
    seed = randomSeed();
    if(getParameterByName("v") != null) {
        version = getParameterByName("v");
    }
}
Math.seedrandom(seed);

//set the permalink
var base64String = btoa(seed);
var permalink = window.location.href.split('?')[0] + "?v=0&b=" + base64String;
document.getElementById("permalink").setAttribute("href", permalink);


function randomSeed() {
    var s = "";
    for(var i = 0; i < SEED_LENGTH; i++)
	s += String.fromCharCode(randomInt(256));
    return s;
}

function random() {
    return Math.random();
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
