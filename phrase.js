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
