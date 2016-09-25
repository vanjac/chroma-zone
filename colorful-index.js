var projectGroupsLeft = document.getElementsByClassName("block-group-left");
var projectGroupsRight = document.getElementsByClassName("block-group-right");

for(i = 0; i < projectGroupsLeft.length; i++) {
    projectGroupsLeft[i].style.backgroundColor = randomColor();
}

for(i = 0; i < projectGroupsRight.length; i++) {
    projectGroupsRight[i].style.backgroundColor = randomColor();
}


function randomColor() {
    var r = Math.floor(Math.random() * 192 + 64);
    var g = Math.floor(Math.random() * 96 + 160);
    var b = Math.floor(Math.random() * 192 + 64);
    return "rgb(" + r + "," + g + "," + b + ")";
}

