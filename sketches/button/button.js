
var state = [ ];
for(var i = 0; i < 20; i++) {
    state.push(false);
}
var prevState = state.slice();

updateState();



function updateState() {
    console.log(state);
    
    el("js-warning").style.display = "none";
    
    var score = 0;
    for(var i = 0; i < state.length; i++) {
        if(state[i])
            score += 1;
    }
    el("score").innerHTML = score;
    
    el("button1-p").style.display = "block";
    
    if(stateChanged(0, true)) {
        el("button2-p").style.display = "block";
    } else if(stateChanged(0, false)) {
        el("button2-p").style.display = "none";
    }
    
    prevState = state.slice();
}

function stateChanged(i, newState) {
    if(newState)
        return state[i] && !prevState[i];
    else
        return (!state[i]) && prevState[i];
}

function on(i) {
    state[i] = true;
}

function off(i) {
    state[i] = false;
}

function tog(i) {
    state[i] = !state[i];
}

function el(name) {
    return document.getElementById(name);
}