'use strict'

var tableCells = document.querySelectorAll('header td')
var parts = location.pathname.split('/')

var url = ''
for (var i = 1; i < parts.length && i < tableCells.length; i++) {
  url += '/' + parts[i]
  var text = parts[i].replace(/\.html$/, '')
  if (i < parts.length - 1) {
    text += '/'
  }
  if (text) {
    var link = document.createElement('a')
    link.href = url
    link.textContent = text
    tableCells[i].textContent = ''
    tableCells[i].appendChild(link)
    tableCells[i].setAttribute('role', null)
  }
}
