// Constants and Variables ---------------------------------
// ---------------------------------------------------------
const doc = $(document);


// Helper Methods ------------------------------------------
// ---------------------------------------------------------
async function getImageUrl(gameId, imageType, sortNumber) {
  try {
    // Get game's thumbnail
    return await $.ajax({
      url: `/api/games/${gameId}/files/image/${imageType}/${sortNumber}`,
      method: "GET",
    })
  } catch (err){
    console.error("Failed to load thumbnail: ", err);
    return '/images/thumbnail_placeholder.jpg';
  }
}

async function loadGamesIntoGrid(container, games) {
  const fragment = $(document.createDocumentFragment());

  // Show the placeholder first
  const gameCount = games.length;
  const placeholder = `<div class="grid-item-placeholder"></div>`;
  for(let i = 0; i < gameCount; i++){
    fragment.append(placeholder);
  }

  container.empty();
  container.append(fragment);
  fragment.empty();

  // Load games
  for (const game of games) {
    const html = await displayGameCard(game);
    fragment.append(html);
  }

  container.empty();
  container.append(fragment);
}

async function displayGameCard(game) {
  const isPC = game.platform === 'PC' || game.platform === 'BOTH';
  const isMobile = game.platform === 'MOBILE' || game.platform === 'BOTH';
  const imgUrl = await getImageUrl(game.gameId, "thumbnail", 1);

  return `
    <div class="grid-item" data-game-id='${game.id}'>
      <img class="grid-image" src="${imgUrl}" alt="${game.name}" 
           onerror="this.onerror=null; this.src='/images/thumbnail_placeholder.jpg';">

      <div class="grid-info">
        <p class="grid-title">${game.name}</p>

        <div class="grid-icon-wrapper">
          ${isPC ? `<img class="grid-icon" src="/images/computer_icon.svg">` : ``}
          ${isMobile ? `<img class="grid-icon" src="/images/mobile_icon.svg">` : ``}
        </div>
      </div>
    </div>
  `;
}

async function getListOfGames(url){
  try{
    const listOfGames = await $.ajax({
      url: url,
      method: "GET",
    })

    return listOfGames;
  }
  catch (err){
    console.error("Failed: ", err);
    return [];
  }
}



// Loading Stuff -----------------------------------
// ---------------------------------------------------------
async function loadProfileButton(){
  $.get("/api/user/me", function(user) {
      profileBtn.text(user.name);
  });
}

async function loadPopularGames() {
  const games = await getListOfGames("/api/games/popular");
  loadGamesIntoGrid($('#popular-games-grid'), games);
}

async function loadAllGames() {
  const games = await getListOfGames("/api/games/all");
  loadGamesIntoGrid($('#all-games-grid'), games);
}

doc.ready(function (){
  loadPopularGames();
  loadProfileButton();
  loadAllGames();
  registerEvents();
});



// Add event to all grid item ------------------------------
// ---------------------------------------------------------
doc.on('click', '.grid-item', async function(){
    let id = $(this).data('game-id');

    try {
        const gameData = await $.ajax({
            url: `/api/games/${id}/info`,
            method: 'GET'
        });

        // Debug
        alert(`Game Information\n---------------------------------\nName: ${gameData.name}\nID: ${gameData.id}\nPlatform: ${gameData.platform}`);

    } catch (err) {
        console.error(err);
        alert("Request failed");
    }
});


// Buttons and Stuff -------------------------------------------------
// ---------------------------------------------------------
function registerEvents(){
  const registerBtn = $('#registerBtn');
  const loginBtn = $('#loginBtn');
  const profileBtn = $('#profileBtn');
  const homeBtn = $('#homeBtn');
  const shopBtn = $('#shopBtn');
  const navBar = $('#navbar')

  loginBtn.click(function (){
    window.location.href = "/login";
  })

  registerBtn.click(function (){
    window.location.href = "/register";
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

  shopBtn.click(function (){
    $('html, body').animate({
      scrollTop: $('#popular-games').offset().top - $('#navbar').outerHeight()
    }, 500,'easeOutCubic');
  });


}

