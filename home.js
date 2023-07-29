const $ = s => document.querySelector(s);
const $all = s => document.querySelectorAll(s);

function resetNav() {
  $('#navigation').style.display = null;
  $('#content-box').style.display = null;
  $('#collapse-nav-button').style.display = null;
  $('#expand-nav-button').style.display = null;
  $('#open-nav-button').style.display = null;
  $('#close-nav-button').style.display = null;
}

$('#collapse-nav-button').addEventListener('click', () => {
  $('#navigation').style.display = 'none';
  $('#collapse-nav-button').style.display = 'none';
  $('#expand-nav-button').style.display = 'block';
});

$('#expand-nav-button').addEventListener('click', resetNav);

$('#open-nav-button').addEventListener('click', () => {
  $('#navigation').style.display = 'block';
  $('#content-box').style.display = 'none';
  $('#open-nav-button').style.display = 'none';
  $('#close-nav-button').style.display = 'block';
});

$('#close-nav-button').addEventListener('click', resetNav);

function updateTags() {
  let dispstyle = $('#show-tags').checked ? 'inline' : 'none';
  $all('.tech-tag').forEach(anchor => {
    if (anchor.hash === window.location.hash) {
      anchor.classList.add('tech-hilite');
    } else {
      anchor.classList.remove('tech-hilite');
    }
    anchor.style.display = dispstyle;
  });
}

updateTags();
window.addEventListener('hashchange', updateTags);
$('#show-tags').addEventListener('change', updateTags);

// https://web.dev/bfcache/
window.addEventListener('pageshow', e => {
  if (e.persisted)
    resetNav();
});
