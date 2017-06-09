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
