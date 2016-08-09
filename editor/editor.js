var box = document.getElementById("textbox");
var mark = 0;
var clipboard = "";

function focusBox() {
    box.focus();
}

function setMark() {
    focusBox();
    mark = getCaretPosition(box);
    console.log("Mark set to " + mark);
}

function select() {
    focusBox();
    setSelection(box, mark, getCaretPosition(box));
}

function copy() {
    focusBox();
    clipboard = box.value.substring(getSelectionStart(box),
				    getSelectionEnd(box));
    console.log("Copied " + clipboard);
}

function cut() {
    focusBox();
    copy();
    var start = getSelectionStart(box);
    var end = getSelectionEnd(box);
    box.value = box.value.substring(0, start)
	+ box.value.substring(end, box.value.length);
}

function paste() {
    focusBox();
    var caret = getCaretPosition(box);
    box.value = box.value.substring(0, caret) + clipboard
	+ box.value.substring(caret, box.value.length);
}


// from: http://stackoverflow.com/questions/512528/set-cursor-position-in-html-textbox
function setCaretPosition(elem, caretPos) {
    if(elem != null) {
        if(elem.createTextRange) { // Legacy IE
            var range = elem.createTextRange();
            range.move('character', caretPos);
            range.select();
        } else {
	    elem.focus();
            if(elem.selectionStart || elem.selectionStart) {
                elem.setSelectionRange(caretPos, caretPos);
            }
        }
    }
}

function setSelection(elem, startPos, endPos) {
    if(endPos < startPos) {
	temp = endPos;
	endPos = startPos;
	startPos = temp;
    }
    console.log("Select from " + startPos + " to " + endPos);
    if(elem != null) {
        if(elem.createTextRange) { // Legacy IE
            var range = elem.createTextRange();
            range.moveStart('character', startPos);
	    range.moveEnd('character', endPos);
            range.select();
        } else {
	    elem.focus();
            if(elem.selectionStart || elem.selectionStart) {
                elem.setSelectionRange(startPos, endPos);
            }
        }
    }
}

function getCaretPosition(elem) {
    if (elem.selectionStart || elem.selectionStart == 0) {
	return elem.selectionStart;
    } else if (document.selection) { // Legacy IE
	elem.focus();
	var range = document.selection.createRange();
	range.moveStart ('character', -elem.value.length);
	return range.text.length;
    }
    
    return 0;
}

function getSelectionStart(elem) {
    if (elem.selectionStart || elem.selectionStart == 0) {
	return elem.selectionStart;
    } else if (document.selection) { // Legacy IE
	elem.focus();
	var range = document.selection.createRange();
	range.moveStart ('character', -elem.value.length);
	return range.text.length;
    }
    
    return 0;
}

function getSelectionEnd(elem) {
    if (elem.selectionEnd || elem.selectionEnd == 0) {
	return elem.selectionEnd;
    } else if (document.selection) { // Legacy IE
	elem.focus();
	var range = document.selection.createRange();
	var start = getSelectionStart(elem);
	return range.text.length + start;
    }
    
    return 0;
}
