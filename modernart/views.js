var views = getCookie("views");
if(views == "")
    views = 0;
else
    views = parseInt(views);
views++;
setCookie("views", views);
console.log("User has visited page " + views + " times");
if(views == 50)
    alert("You have visited this page 50 times in a row."
	  + "\nMaybe you should take a break --"
	  + " art is meant to be savored and contemplated.");

// cookie code based on: http://www.w3schools.com/js/js_cookies.asp

function setCookie(name, value) {
    document.cookie = name + "=" + value;
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
