// from: http://stackoverflow.com/a/2901298
function addCommas(numberString) {
    return numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

var usedPhrases = [ ]

function resetPhraseGen() {
    usedPhrases = [ ];
}

function findPhraseGroup(o, phraseGroupName) {
    for(var i = 0; i < o.PhraseGroups.length; i++) {
        if(o.PhraseGroups[i].name == phraseGroupName) {
            return o.PhraseGroups[i];
        }
    }
    return null;
}

function phraseGen(o, phraseGroupName) {
    var phrase = phraseGenRecursive(o, phraseGroupName);
    // replace "a" followed by a word starting with a vowel with "an"
    phrase = phrase.replace(/ a (?=[aeiou])/gi, " an ");
    return phrase;
}

function phraseGenRecursive(o, phraseGroupName) {
    console.log("Generating " + phraseGroupName + " phrase");
    var phraseGroup = findPhraseGroup(o, phraseGroupName);
    if(phraseGroup == null) {
        console.log("ERROR: couldn't find phrase group " + phraseGroupName);
        return;
    }
    
    var phrases = [ ];
    var totalWeights = [ ];
    var totalWeight = 0;
    for(var i = 0; i < phraseGroup.Phrases.length; i++) {
        var phrase = phraseGroup.Phrases[i];
        if(phrase.isUnique && usedPhrases.indexOf(phrase) != -1)
            continue;
        phrases.push(phrase);
        var weight = phrase.weight;
        for(var j = 0; j < phrase.weightFactors.length; j++) {
            var numItems =
                findPhraseGroup(o, phrase.weightFactors[j]).Phrases.length;
            weight *= numItems;
        }
        //console.log(phrase.text + ": " + weight);
        totalWeight += weight;
        totalWeights.push(totalWeight)
    }
    var weight = random() * totalWeight;
    var chosenPhrase = null;
    for(var i = 0; i < phrases.length; i++) {
        if(weight < totalWeights[i]) {
            chosenPhrase = phrases[i];
            break;
        }
    }
    if(chosenPhrase == null) {
        console.log("ERROR choosing phrase");
        return;
    }
    console.log("Chose phrase '" + chosenPhrase.text + "'");
    usedPhrases.push(chosenPhrase);
    
    var phraseText = chosenPhrase.text;
    
    var phraseRegex = /\$.+?;/;
    while(phraseRegex.test(phraseText)) {
        var phraseGroupSub = phraseRegex.exec(phraseText)[0];
        phraseGroupSub = phraseGroupSub.substring(1, phraseGroupSub.length - 1);
        var textSub = phraseGenRecursive(o, phraseGroupSub);
        phraseText = phraseText.replace(phraseRegex, textSub);
    }
    
    console.log("Done with " + phraseGroupName + " returning '" + phraseText
        + "'");
    return phraseText;
}

console.log("Using phrase set " + version);
var phrases = phraseSets[version];

var caption = phraseGen(phrases, "caption");
caption = caption.substring(0, 1).toUpperCase()
    + caption.substring(1);
document.getElementById("artCaption").innerHTML = caption;

var reviewString = phraseGen(phrases, "review");
reviewString = reviewString.substring(0, 1).toUpperCase()
    + reviewString.substring(1);
document.getElementById("artReview").innerHTML = reviewString;

var title = phraseGen(phrases, "art-title");
title = title.substring(0, 1).toUpperCase() + title.substring(1);
var r = random();
if(r < .3) {
    title += " #" + randomInt(10)
} else if(r < .4) {
    title += " #" + randomInt(100)
} else if(r < .5) {
     title += " #" + randomInt(1000)
}
document.getElementById("artTitle").innerHTML = title;

var priceElement = document.getElementById("artPrice");
if(random() < .2) {
    priceElement.innerHTML = phraseGen(phrases, "price") + ".";
} else {
    if(random() < .8) {
        price = addCommas((randomInt(10000) + 1) + "00000");
    } else {
        price = randomInt(30);
    }
    priceElement.innerHTML = "$" + price;
}
