'use strict'

var tableCells = document.querySelectorAll('header td')
var parts = location.pathname.split('/')

var url = ''
for (var i = 1; i < parts.length && i < tableCells.length - 1; i++) {
  var text = parts[i].replace(/\.html$/, '')
  url += parts[i]
  if (i < parts.length - 1) {
    text += '/'
    url += '/'
  }
  if (text) {
    var link = document.createElement('a')
    link.href = url
    link.textContent = text
    tableCells[i].textContent = ''
    tableCells[i].appendChild(link)
    tableCells[i].removeAttribute('role')
  }
}
