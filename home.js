const $ = s => document.querySelector(s);

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

if (window.performance.getEntriesByType("navigation")[0].type === "back_forward")
  resetNav(); // some mobile browsers preserve the style changes
