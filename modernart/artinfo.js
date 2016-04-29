// from: http://stackoverflow.com/a/2901298
function addCommas(numberString) {
    return numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// phrases
var artName = ["Untitled", "Experiment", "Sketch", "Idea", "Inspiration",
	       "Thought", "Epiphany"];
var phraseA = ["", "revolutionary", "thought-provoking", "intellectual",
	       "visionary", "profound", "ground-breaking", "inspirational",
	       "awe-inspiring", "breathtaking", "fascinating", "beautiful",
	       "experimental", "enlightening", "outstanding", "exciting",
	       "dramatic", "sensational", "remarkable", "phenomenal",
	       "captivating", "riveting", "compelling", "thrilling",
	       "creative", "controversial", "mind-boggling", "enthralling",
	       "minimalistic", "unbelievable", "powerful", "philisophical",
	       "poignant", "avant-garde", "overwhelming", "collaborative",
	       "contemporary", "modern", "gluten-free", "vegan", "delicate",
	       "gender neutral", "abstract", "cutting edge", "spectacular",
	       "moving", "stunning", "compelling", "miraculous", "vivid",
	       "impressive", "extraordinary", "resonating"];
var phraseB = ["masterpiece", "artistic breakthrough", "piece", "painting",
	       "portrait", "picture", "landscape piece", "drawing", "sketch",
	       "watercolor piece", "print", "illustration", "artwork",
	       "photograph", "artistic journey", "mixed-media piece",
	       "recycled art piece", "sculpture", "two-dimensional sculpture",
	       "still art", "forgery", "self-portrait", "oil painting"];
var phraseBDetails = ["by a renowned artist", "drawn while blindfolded",
		      "by an anonymous artist", "by a convicted criminal",
		      "created over the course of a year", "painted yesterday",
		      "sent from the future", "found in a time capsule",
		      "created by humanity", "drawn by a five-year-old"];
var phraseC = ["exposes", "reveals", "comments on", "sparks conversation on",
	       "reflects", "depicts", "explores", "analyzes", "evidences",
	       "raises questions about", "makes a statement about", "uncovers",
	       "considers", "showcases", "expresses", "interprets",
	       "reconsiders", "upends our understanding of", "is", "transcends",
	       "provides thoughts on", "reinerprets", "ponders", "represents",
	       "contemplates",
	       //contains some duplicates:
	       "is a reflection of", "is a depiction of",
	       "is an exploration of", "is an analyzation of",
	       "is an interpretation of", "is a realization of",
	       "is a reinterpretation of", "is a representation of"];
var phraseD = ["our human weakness", "our persuit of meaning",
	       "our persuit of happiness", "our place in society",
	       "our modern society", "our place in the universe",
	       "our culture", "our cultural values", "our cultural norms",
	       "our generation", "what it means to be alive",
	       "what it means to be human", "the human condition"];
// phraseE: same as phraseC
var phraseF = ["the nature of", "the inner workings of", "the idea of",
	       "the deeper meaning of", "the beauty within", "the reality of",
	       "the meaning of", "the truth of", "the cultural meaning of",
	       "the concept of", "the futility of", "the fallacy of",
	       "the consequences of"];
var phraseG = ["life", "the universe", "humanity", "human nature", "the world",
	       "nature", "nothingness", "reality", "truth", "consciousness",
	       "the present", "now", "us", "art", "beauty", "human endeavor",
	       "religion", "technology", "sorrow", "existence", "darkness",
	       "the environment", "consumerism", "the subconscious", "dreams"];
var reviews = ["nature is amazing", "a real work of art", "10/10",
	       "the pinnacle of human accomplishment",
	       "an emotional roller coaster", "wow",
	       "a tasteful addition for any d&eacute;cor", "yes", "indeed",
	       "this made me reconsider my purpose in life",
	       "life is a gift", "new, yet familiar", "worth every penny",
	       "the massive scope hurts my brain",
	       "this reminds me of my late aunt Stephine", "amateur",
	       "garbage", "trump 2016"];
var prices = ["Priceless.", "Your soul.", "Five.", "All of the money.",
	      "A human sacrifice.", "A small country.",
	      "50% off at selected stores."];

// examples include "the deeper meaning of life", or "what it means to be human"
function makeAMeaningfulNounPhrase() {
    var totalPhrases = phraseG.length + phraseD.length;
    
    if(random() < phraseG.length / totalPhrases) {
	if(random() < .75)
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
var randomNum = random();
if(randomNum < .3)
    captionString += randomItem(phraseBDetails) + " ";
else if(randomNum < .35)
    captionString += "inspired by " + randomItem(phraseG) + " ";
captionString = captionString + randomItem(phraseC) + " "
    + makeAMeaningfulNounPhrase()
if(random() < .8)
    captionString = captionString + ", and " + randomItem(phraseC) + " "
    + makeAMeaningfulNounPhrase() + ".";
else
    captionString = captionString + ".";
captionElement.innerHTML = captionString;


// generate critical review
var reviewElement = document.getElementById("artReview");
var reviewString;
if(random() < .5) {
    reviewString = randomItem(reviews);
} else {
    reviewString = randomItem(phraseA);
    if(reviewString.length == 0)
	reviewString = randomItem(phraseA);

    if(random() < .5) {
	var reviewString2 = randomItem(phraseA);
	if(reviewString2.length == 0)
	    reviewString2 = randomItem(phraseA);
	if(random() < .25)
	    reviewString = reviewString + ", yet " + reviewString2;
	else
	    reviewString = reviewString + " and " + reviewString2;
    }
}
//make the first letter uppercase, and add a period
reviewString = reviewString.substring(0, 1).toUpperCase()
    + reviewString.substring(1) + ".";
reviewElement.innerHTML = reviewString;


// generate price
var priceElement = document.getElementById("artPrice");
if(random() < .2) {
    artPrice.innerHTML = randomItem(prices);
} else {
    artPrice.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
}
