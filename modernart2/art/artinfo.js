// from: http://stackoverflow.com/a/2901298
function addCommas(numberString) {
    return numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


// generate price
var priceElement = document.getElementById("artPrice");
if(random() < .2) {
    artPrice.innerHTML = randomItem(prices);
} else {
    artPrice.innerHTML = "$" + addCommas((randomInt(10000) + 1) + "00000");
}
