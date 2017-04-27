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
if(views == 100)
    alert("You have visited this page 100 times in a row."
	  + "\nI'm impressed. You've found a way to binge-watch art.");
if(views == 150)
    alert("You have visited this page 150 times in a row."
	  + "\nPlease stop, your friends are starting to worry.");
if(views == 200) {
    alert("You have visited this page 200 times in a row."
	  + "\nI can't let you continue like this."
	  + " I'm blocking you from accessing this page.");
}
if(views >= 200) {
    var bodyElement = document.getElementsByTagName("BODY")[0];
    bodyElement.innerHTML = "<p>go away</p>";
}

var today = new Date();
var date = today.getDate();
var month = today.getMonth()+1;
if(views == 3 && date == 3 && month == 5) {
	document.getElementById("artReview").innerHTML = "Happy Birthday Adrian!";
}

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
