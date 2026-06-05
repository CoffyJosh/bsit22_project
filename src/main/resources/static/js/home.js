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
  container.empty();

  for (const game of games) {
    const html = await displayGameCard(game);
    const el = $(html).css({ opacity: 0, transform: 'translateY(20px)', transition: 'opacity 1s ease, transform 0.3s ease' });
    container.append(el);

    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        el.css({ opacity: 1, transform: 'translateY(0)' });
      });
    });

    await new Promise(resolve => setTimeout(resolve, 50));
  }
}

async function displayGameCard(game) {
  const isPC = game.platform === 'PC' || game.platform === 'BOTH';
  const isMobile = game.platform === 'Mobile' || game.platform === 'BOTH';
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


// Nav bar -------------------------------------------------
// ---------------------------------------------------------
const authBtn = $('#authBtn')
authBtn.click(function (){
  window.location.href = "/login";
})

const homeBtn = $('#homeBtn')
homeBtn.click(function(){
  window.location.href = "/";
})

const profileBtn = $('#profileBtn')
profileBtn.click(function (){
  alert("You have been diddled by the Diddler!");
})

const navBar = $('#navbar')
$(window).on('scroll', function() {
  if ($(this).scrollTop() > 10) {
      navBar.css('background-color', '#16161fff');
  } else {
      navBar.css('background-color', '#16161f65');
  }
});

const shopBtn = $('#shopBtn');
shopBtn.click(function (){
  $('html, body').animate({
    scrollTop: $('#popular-games').offset().top - $('#navbar').outerHeight()
  }, 500,'easeOutCubic');
});


