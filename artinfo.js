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
var artName = ["Untitled", "Experiment", "Sketch"];
var phraseA = ["", "revolutionary", "thought-provoking", "intellectual",
	       "visionary", "profound", "ground-breaking", "inspiring",
	       "awe-inspiring", "breathtaking", "fascinating", "beautiful",
	       "experimental", "enlightening", "outstanding", "exciting",
	       "dramatic", "sensational", "remarkable", "phenomenal",
	       "captivating", "riveting", "compelling", "thrilling",
	       "creative", "controversial", "mind-boggling", "enthralling",
	       "new, yet familiar"];
var phraseB = ["masterpiece", "artistic breakthrough", "piece", "painting",
	       "portrait", "picture", "landscape piece", "drawing", "sketch",
	       "watercolor piece", "print", "illustration", "artwork",
	       "photograph", "artistic journey", "mixed-media piece",
	       "collaborative art piece"];
var phraseBDetails = ["by a renowned artist", "drawn while blindfolded",
		      "by an anonymous artist",
		      "created over the course of a year", "painted yesterday",
		      "sent from the future", "found in a time capsule",
		      "created by all of us"];
var phraseC = ["exposes", "reveals", "comments on", "sparks conversation on",
	       "reflects", "depicts", "explores", "analyzes", "evidences",
	       "raises questions about", "makes a statement about", "uncovers",
	       "considers", "showcases", "expresses", "interprets",
	       "reconsiders", "upends our understanding of",
	       //duplicates:
	       "is a reflection of", "is a depiction of",
	       "is an exploration of", "is an analyzation of",
	       "is an interpretation of"];
var phraseD = ["our human weakness", "our persuit of meaning",
	       "our persuit of happiness", "our place in society",
	       "our modern society", "our place in the universe",
	       "our culture", "our cultural values", "our cultural norms",
	       "our generation", "what it means to be alive",
	       "what it means to be human"];
// phraseE: same as phraseC
var phraseF = ["the nature of", "the inner workings of", "the idea of",
	       "the deeper meaning of", "the beauty within", "the reality of",
	       "the meaning of", "the truth of", "the cultural meaning of",
	       "the concept of"];
var phraseG = ["life", "the universe", "humanity", "human nature", "the world",
	       "nature", "nothingness", "reality", "truth", "consciousness",
	       "the present", "now", "us"];
var reviews = ["nature is amazing", "a real work of art", "10/10",
	       "the pinnacle of human accomplishment",
	       "an emotional roller coaster",
	       "a tasteful addition to any d&eacute;cor", "wow",
	       "this made me reconsider my purpose in life"];
var prices = ["Priceless.", "Your soul.", "Five.", "All of the money.",
	      "A human sacrifice.", "A small country."];

function makeAMeaningfulNounPhrase() {
    var totalPhrases = phraseG.length + phraseD.length;
    
    if(Math.random() < phraseG.length / totalPhrases) {
	if(Math.random() < .75)
	    return randomItem(phraseF) + " " + randomItem(phraseG);
	else
	    return randomItem(phraseG);
    } else {
	return randomItem(phraseD);
    }
}

// generate title
var titleElement = document.getElementById("artTitle");
titleElement.innerHTML = randomItem(artName) + " #" + randomInt(1000);


// generate caption
var captionElement = document.getElementById("artCaption");
var captionString = "This " + randomItem(phraseA) + " "
    + randomItem(phraseB) + " " ;
var random = Math.random();
if(random < .3)
    captionString += randomItem(phraseBDetails) + " ";
else if(random < .35)
    captionString += "inspired by " + randomItem(phraseG) + " ";
captionString = captionString + randomItem(phraseC) + " "
    + makeAMeaningfulNounPhrase()
if(Math.random() < .8)
    captionString = captionString + ", and " + randomItem(phraseC) + " "
    + makeAMeaningfulNounPhrase() + ".";
else
    captionString = captionString + ".";
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
if(Math.random() < .2) {
    artPrice.innerHTML = randomItem(prices);
} else {
    artPrice.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
}
