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
    document.querySelectorAll('.tech-tag').forEach(function(anchor) {
        if (anchor.hash === window.location.hash) {
            anchor.classList.add('tech-hilite')
        } else {
            anchor.classList.remove('tech-hilite')
        }
        anchor.style.display = dispstyle
    })
}

if (showTagsCheck) {
    updateTags()
    window.onhashchange = updateTags
    showTagsCheck.onchange = updateTags
}

// https://web.dev/bfcache/
window.onpageshow = function(e) {
    if (e.persisted) {
        resetNav()
    }
}
