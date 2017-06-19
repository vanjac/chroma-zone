
var state = [ ];
for(var i = 0; i < 20; i++) {
    state.push(false);
}
var prevState = state.slice();

updateState();



function updateState() {
    el("js-warning").style.display = "none";
    
    el("button1-p").style.display = "block";
    
    if(stateChanged(0, true)) {
        el("button2-p").style.display = "block";
    } else if(stateChanged(0, false)) {
        el("button2-p").style.display = "none";
    }
    
    if(stateChanged(2, true)) {
        el("button3-p").style.display = "block";
    } else if(stateChanged(2, false)) {
        el("button3-p").style.display = "none";
    }
    
    if(stateChanged(3, true)) {
        el("button1").style.display = "none";
        el("button2").style.display = "none";
        el("button1-color").style.display = "initial";
        el("button2-color").style.display = "initial";
    } else if(stateChanged(3, false)) {
        el("button1").style.display = "initial";
        el("button2").style.display = "initial";
        el("button1-color").style.display = "none";
        el("button2-color").style.display = "none";
    }
    
    if(stateChanged(4, true)) {
        el("button1-p").style.color = "#FF00FF";
        el("button1-p").style.fontWeight = "bold";
    } else if(stateChanged(4, false)) {
        el("button1-p").style.color = "black";
        el("button1-p").style.fontWeight = "normal";
    }
    
    if(stateChanged(5, true)) {
        el("button2-p").style.color = "#3333FF";
        el("button2-p").style.fontWeight = "bold";
    } else if(stateChanged(5, false)) {
        el("button2-p").style.color = "black";
        el("button2-p").style.fontWeight = "normal";
    }
    
    if(stateChanged(6, true)) {
        el("button3-p").style.color = "#44FFFF";
        el("button3-p").style.fontWeight = "bold";
    } else if(stateChanged(6, false)) {
        el("button3-p").style.color = "black";
        el("button3-p").style.fontWeight = "normal";
    }
    
    if(state[4] && state[5] && state[6])
        state[7] = true;
    
    if(stateChanged(7, true)) {
        document.body.style.backgroundColor = "#55FF55";
    } else if(stateChanged(7, false)) {
        document.body.style.backgroundColor = "initial";
    }
    
    if(stateChanged(8, true)) {
        el("button1").style.fontSize = "24px";
    } else if(stateChanged(8, false)) {
        el("button1").style.fontSize = "initial";
    }
    
    if(stateChanged(9, true)) {
        el("score").style.fontSize = "48px";
        el("score").style.fontWeight = "bold";
        el("score").style.color = "#CC00CC";
        el("score").style.textShadow = "3px 3px 0 #0000CC";
    } else if(stateChanged(9, false)) {
        el("score").style.fontSize = "initial";
        el("score").style.fontWeight = "normal";
        el("score").style.color = "black";
        el("score").style.textShadow = "none";
    }
    
    if(state[8] && !state[9])
        state[10] = true;
    
    if(stateChanged(10, true)) {
        document.body.style.transform = "rotate(7deg) translate(50px, 100px)";
    } else if(stateChanged(10, false)) {
        document.body.style.transform = "none";
    }
    
    var score = 0;
    for(var i = 0; i < state.length; i++) {
        if(state[i])
            score += 1;
    }
    el("score").innerHTML = score;
    
    console.log(state);
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

function allOff(i) {
    for(var i = 0; i < state.length; i++)
        state[i] = false;
}

function tog(i) {
    state[i] = !state[i];
}

function el(name) {
    return document.getElementById(name);
}