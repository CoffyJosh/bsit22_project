$(document).ready(function (){
  const loginBtn = $('#loginBtn');
  const profileBtn = $('#profileBtn');
  const homeBtn = $('#homeBtn');
  const navBar = $('#navbar')

  loginBtn.click(function (){
    window.location.href = "/login";
  })

  homeBtn.click(function(){
    window.location.href = "/";
  })

  profileBtn.click(function (){
    alert("You have been diddled by the Diddler!");
  })

  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 10) {
        navBar.css('background-color', '#16161fff');
    } else {
        navBar.css('background-color', '#16161f65');
    }
  });
})