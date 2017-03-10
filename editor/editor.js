var box = document.getElementById("textbox");
var mark = 0;
var clipboard = "";

function focusBox() {
    box.focus();
}

function indent() {
    var pos = getCaretPosition(box);
    var text = box.value;
    var currentLinePos = text.substring(0, pos).lastIndexOf('\n') + 1;
    if(currentLinePos != 0) {
        // it's okay if the newline isn't found
        // 1 will be added and the value will be 0
        // so the indent at the beginning of the file will be checked
        var prevLinePos = text.substring(0, currentLinePos - 1)
            .lastIndexOf('\n') + 1;
        
        var currentIndent = indentAt(currentLinePos);
        var targetIndent = indentAt(prevLinePos);
        
        if(currentIndent < targetIndent) {
            box.value = text.substring(0, currentLinePos)
                + Array(targetIndent - currentIndent + 1).join(' ')
                + text.substring(currentLinePos);
        } else if(currentIndent > targetIndent) {
            box.value = text.substring(0, currentLinePos)
                + text.substring(
                    currentLinePos + currentIndent - targetIndent)
        }
    }
}

function indentAt(pos) {
    if(box.value[pos] == ' ') {
        var indentLength = 0;
        while(box.value[pos + indentLength] == ' ')
            indentLength++;
        return indentLength;
    } else {
        return 0;
    }
}

function select() {
    focusBox();
    var newMark = getCaretPosition(box);
    setSelection(box, mark, newMark);
    mark = newMark;
    console.log("Mark set to " + mark);
}

function copy() {
    focusBox();
    clipboard = box.value.substring(getSelectionStart(box),
				    getSelectionEnd(box));
    console.log("Copied " + clipboard);
}

function cut() {
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
