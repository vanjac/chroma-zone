function random() {
    return Math.random();
}

// max is exclusive
function randomInt(max) {
    return Math.floor((Math.random() * max));
}

// after choosing a random item, removes it so it won't be used again
function randomItem(array) {
    var index = randomInt(array.length);
    var item = array[index];
    array.splice(index, 1);
    return item;
}
