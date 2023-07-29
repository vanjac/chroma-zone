const $ = s => document.querySelector(s);
const $all = s => document.querySelectorAll(s);

function resetNav(e) {
  $('#navigation').style.display = null;
  $('#content-box').style.display = null;
  $('#collapse-nav-button').style.display = null;
  $('#expand-nav-button').style.display = null;
  $('#open-nav-button').style.display = null;
  $('#close-nav-button').style.display = null;
}

$('#collapse-nav-button').addEventListener('click', e => {
  $('#navigation').style.display = 'none';
  $('#collapse-nav-button').style.display = 'none';
  $('#expand-nav-button').style.display = 'block';
});

$('#expand-nav-button').addEventListener('click', resetNav);

$('#open-nav-button').addEventListener('click', e => {
  $('#navigation').style.display = 'block';
  $('#content-box').style.display = 'none';
  $('#open-nav-button').style.display = 'none';
  $('#close-nav-button').style.display = 'block';
});

$('#close-nav-button').addEventListener('click', resetNav);

$all('.tech-tag').forEach(anchor => {
  if (anchor.hash === window.location.hash) {
    anchor.classList.add("tech-hilite");
  }
})

// https://web.dev/bfcache/
window.addEventListener('pageshow', e => {
  if (e.persisted)
    resetNav();
});
