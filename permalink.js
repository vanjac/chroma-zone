var base64String = getRandomBase64();
var permalink = window.location.href.split('?')[0]+ "?v=0&b=" + base64String;

permalinkElement = document.getElementById("permalink");
permalinkElement.innerHTML = "<a href=\"" + permalink + "\">Permalink<a>";
