// go to repository
if(getParameterByName("r") != null) {
    var repository = getParameterByName("r");
    window.location.href = "https://github.com/vanjac/" + repository;
}

// special codes
else if(getParameterByName("c") != null) {
    var code = getParameterByName("c");
	    
    // projects
	if(code == "ard")
	    window.location.href = "https://github.com/Seamonsters-2605/Ardroid";
	    
    // web apps
    else if(code == "art")
	    window.location.href = "http://vanjac.github.io/modernart/";
    else if(code == "col")
        window.location.href = "http://vanjac.github.io/colortest/";
    else if(code == "edi")
        window.location.href = "http://vanjac.github.io/editor/";
    
    else {
	    var repository = ""
	    
	    // projects
	    if(code == "tim")
	        repository = "InteractiveTimeline";
	    if(code == "bet")
	        repository = "Betsy";
        if(code == "thr")
	        repository = "three";
	    if(code == "igs")
	        repository = "IGSim";
	    if(code == "min")
	        repository = "Minus";
        if(code == "chr")
            repository = "ChristmasEngine";
	    if(code == "hex")
	        repository = "HexKey";
	    if(code == "sea")
	        repository = "SeatingChartGenerator";
	    if(code == "mus")
	        repository = "MusicGenerator";
	    if(code == "ter")
	        repository = "TerrainGenerator";
	        
        // other
        if(code == "min2")
            repository = "MinusMinus";
	
	    window.location.href = "https://github.com/vanjac/" + repository;
    }
}

// from: http://stackoverflow.com/a/901144
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)");
    results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
