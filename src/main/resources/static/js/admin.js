$(document).ready(function () {
  console.log("Script Loaded");
  const currentPage = $('body').data('current-page');

  $('.sidebar-button').click(function () {
    const page = $(this).data('page');
    if (page === currentPage) return;

    const href = $(this).data('href');
    if (href) window.location.href = href;
  });

  const pageHeader = $('.page-header')
  $('.page-container').on('scroll', function() {
    if ($(this).scrollTop() > 2) {
        pageHeader.css('background-color', 'rgba(0, 0, 0, 1)');
    } else {
        pageHeader.css('background-color', 'rgba(0, 0, 0, 0.2)');
    }
  });

});