// Disable scrolling. From: http://stackoverflow.com/a/10739042
document.body.addEventListener('touchstart', function(e){
    e.preventDefault();
});

//  Fix for links in web apps from http://stackoverflow.com/a/7390672
var a=document.getElementsByTagName("a");
for(var i=0;i<a.length;i++) {
    if(!a[i].onclick && a[i].getAttribute("target") != "_blank") {
        a[i].onclick=function() {
                window.location=this.getAttribute("href");
                return false; 
        }
    }
}

