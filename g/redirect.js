// go to repository
if(getParameterByName("r") != null) {
	repository = getParameterByName("r")
	window.location.href = "https://github.com/vanjac/" + repository + "/"
} else {
	window.location.href = "https://github.com/vanjac/"
}

// from: http://stackoverflow.com/a/901144
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}