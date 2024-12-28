'use strict'

function $(s) { return document.querySelector(s) }

function resetNav() {
    $('#navigation').style.display = ''
    $('#content-box').style.display = ''
    $('#collapse-nav-button').style.display = ''
    $('#expand-nav-button').style.display = ''
    $('#open-nav-button').style.display = ''
    $('#close-nav-button').style.display = ''
}

$('#collapse-nav-button').onclick = function() {
    $('#navigation').style.display = 'none'
    $('#collapse-nav-button').style.display = 'none'
    $('#expand-nav-button').style.display = 'block'
}

$('#expand-nav-button').onclick = resetNav

$('#open-nav-button').onclick = function() {
    $('#navigation').style.display = 'block'
    $('#content-box').style.display = 'none'
    $('#open-nav-button').style.display = 'none'
    $('#close-nav-button').style.display = 'block'
}

$('#close-nav-button').onclick = resetNav

var showTagsCheck = $('#show-tags')

function updateTags() {
    var dispstyle = showTagsCheck.checked ? 'inline' : 'none'
    var anchors = document.querySelectorAll('.tech-tag')
    for (var i = 0; i < anchors.length; i++) {
        var anchor = anchors[i]
        if (anchor.hash === window.location.hash) {
            anchor.className = 'tech-tag tech-hilite'
        } else {
            anchor.className = 'tech-tag'
        }
        anchor.style.display = dispstyle
    }
}

window.onload = function() {
    if (showTagsCheck) {
        updateTags()
        window.onhashchange = updateTags
        showTagsCheck.onclick = updateTags
    }
}

// https://web.dev/bfcache/
window.onpageshow = function(e) {
    if (e.persisted) {
        resetNav()
    }
}
