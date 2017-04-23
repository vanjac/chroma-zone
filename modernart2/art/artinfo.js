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

function phraseGenRecursive(o, phraseGroupName) {
    console.log("Phrase gen recursive " + phraseGroupName);
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
    usedPhrases.push(chosenPhrase);
    
    var phraseText = chosenPhrase.text;
    
    var phraseRegex = /\$.+?;/;
    while(phraseRegex.test(phraseText)) {
        var phraseGroupSub = phraseRegex.exec(phraseText)[0];
        phraseGroupSub = phraseGroupSub.substring(1, phraseGroupSub.length - 1);
        var textSub = phraseGenRecursive(o, phraseGroupSub);
        phraseText = phraseText.replace(phraseRegex, textSub);
    }
    
    console.log("done with " + phraseGroupName + " returning " + phraseText);
    return phraseText;
}

document.getElementById("artCaption").innerHTML = phraseGenRecursive(phrases, "caption");

var reviewString = phraseGenRecursive(phrases, "review");
reviewString = reviewString.substring(0, 1).toUpperCase()
    + reviewString.substring(1);
document.getElementById("artReview").innerHTML = reviewString;

document.getElementById("artTitle").innerHTML = phraseGenRecursive(phrases, "art-title") + " #" + randomInt(1000);

var priceElement = document.getElementById("artPrice");
if(random() < .2) {
    priceElement.innerHTML = phraseGenRecursive(phrases, "price") + ".";
} else {
    priceElement.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
}
