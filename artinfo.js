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

// phrases
var phraseA = ["", "revolutionary", "thought-provoking", "intellectual",
	       "visionary", "profound", "ground-breaking", "inspiring",
	       "awe-inspiring", "breathtaking", "facinating", "beautiful",
	       "experimental"];
var phraseB = ["masterpiece", "artistic breakthrough", "piece", "painting",
	       "portrait", "picture", "landscape piece", "drawing", "sketch",
	       "watercolor piece", "print", "illustration", "artwork",
	       "photograph"];
var phraseC = ["exposes", "reveals", "comments on", "sparks conversation on",
	       "reflects", "depicts", "explores", "analyzes", "evidences",
	       "raises questions about", "makes a statement about", "uncovers",
	       "considers"];
var phraseD = ["our human weakness", "our persuit of meaning",
	       "our persuit of greatness", "our persuit of happiness",
	       "our place in society", "our modern society",
	       "our place in the universe", "our culture",
	       "our cultural values", "our cultural norms"];
// phraseE: same as phraseC
var phraseF = ["", "the nature of", "the inner workings of", "the idea of",
	       "the deeper meaning of", "the beauty within", "the reality of",
	       "the meaning of", "the truth of", "the cultural meaning of"];
// will be concatenated with phraseD
var phraseG = ["life", "the universe", "humanity", "human nature", "the world",
	       "nature", "nothingness", "reality", "truth", "consciousness"];
var reviews = ["nature is amazing", "a real work of art", "10/10",
	       "the pinnacle of human accomplishment",
	       "an emotional roller coaster",
	       "a tasteful addition for any d&eacute;cor"];

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
var reviewString;
if(Math.random() < .5) {
    reviewString = randomItem(reviews);
} else {
    reviewString = randomItem(phraseA);
    if(reviewString.length == 0)
	reviewString = randomItem(phraseA);

    if(Math.random() < .5) {
	var reviewString2 = randomItem(phraseA);
	if(reviewString2.length == 0)
	    reviewString2 = randomItem(phraseA);
	reviewString = reviewString + " and " + reviewString2;
    }
}
//make the first letter uppercase, and add a period
reviewString = reviewString.substring(0, 1).toUpperCase()
    + reviewString.substring(1) + ".";
reviewElement.innerHTML = reviewString;


// generate price
var priceElement = document.getElementById("artPrice");
artPrice.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
