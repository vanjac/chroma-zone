var base64String = getRandomBase64();
console.log("Permalink length: " + base64String.length);
var permalink = window.location.href.split('?')[0] + "?v=0&b=" + base64String;

permalinkElement = document.getElementById("permalink");
permalinkElement.setAttribute("href", permalink);
