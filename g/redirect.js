// go to repository
if(getParameterByName("r") != null) {
	var repository = getParameterByName("r")
	window.location.href = "https://github.com/vanjac/" + repository
}
// special codes
else if(getParameterByName("c") != null) {
	var code = getParameterByName("c")
	if(code == "a")
		window.location.href = "http://vanjac.github.io/modernart/"
	else {
		var repository = ""
		if(code == "b")
			repository = "Betsy"
		if(code == "m")
			repository = "Minus"
		if(code == "t")
			repository = "three"
		if(code == "g")
			repository = "MusicGenerator"
		if(code == "k")
			repository = "HexKey"
		window.location.href = "https://github.com/vanjac/" + repository
	}
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
