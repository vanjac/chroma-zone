// max is exclusive
function randomInt(max) {
    return Math.floor((Math.random() * max));
}

// after choosing a random item, removes it
function randomItem(array) {
    var index = randomInt(array.length);
    var item = array[index];
    array.splice(index, 1);
    return item;
}

// from: http://stackoverflow.com/a/2901298
function addCommas(numberString) {
    return numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// caption phrases
var phraseA = ["revolutionary", "thought-provoking", "intellectual",
	       "visionary", "profound", "ground-breaking"];
var phraseB = ["masterpiece", "artistic breakthrough", "piece", "painting",
	       "portrait", "landscape piece"];
var phraseC = ["exposes", "reveals", "comments on", "sparks conversation on",
	       "reflects", "depicts", "explores", "analyzes", "evidences",
	       "raises questions about", "makes a statement about"];
var phraseD = ["our human weakness", "our persuit of meaning",
	       "our persuit of greatness", "our persuit of happiness",
	       "our society", "our place in society",
	       "our place in the universe", "our culture",
	       "our cultural values", "our cultural norms"];
// phraseE: same as phraseC
var phraseF = ["the nature of", "the inner workings of",
	       "the deeper meaning of", "the beauty within", "the reality of",
	       "the meaning of", "the truth of"];
var phraseG = ["life", "the universe", "humanity",
	       "human nature", "the world", "nature",
	       "nothingness", "reality"]; // will be concatenated with phraseD

// generate title
var titleElement = document.getElementById("artTitle");
titleElement.innerHTML = "Untitled #" + randomInt(1000);


// generate caption
var captionElement = document.getElementById("artCaption");
var captionString = "This " + randomItem(phraseA) + " "
    + randomItem(phraseB) + " " + randomItem(phraseC) + " "
    + randomItem(phraseD) + ", and " + randomItem(phraseC) + " "
    + randomItem(phraseF) + " ";
phraseG = phraseG.concat(phraseD);
captionString = captionString + randomItem(phraseG) + ".";
captionElement.innerHTML = captionString;


// generate critical review
var reviewElement = document.getElementById("artReview");
var reviews = ["Nature is amazing.", "A real work of art.", "10/10.",
	       "Inspiring.", "The pinnacle of human accomplishment.",
	       "An emotional roller coaster."];
reviewElement.innerHTML = randomItem(reviews);


// generate price
var priceElement = document.getElementById("artPrice");
artPrice.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
