$(document).ready(function (){
  addElementFunctions();
  loadProfileButton();
})

function addElementFunctions(){
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
    window.location.href = "/user";
  })

  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 10) {
        navBar.css('background-color', '#16161fff');
    } else {
        navBar.css('background-color', '#16161f65');
    }
  });

}
async function loadProfileButton(){
  const profileBtn = $('#profileBtn');
  $.get("/api/user/me", function(user) {
      profileBtn.text(user.name);
  });
}