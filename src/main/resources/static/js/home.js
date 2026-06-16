// Constants and Variables ---------------------------------
// ---------------------------------------------------------
const doc = $(document);


// Helper Methods ------------------------------------------
// ---------------------------------------------------------
async function getImageUrl(gameId, imageType) {
  try {
    // Get game's thumbnail
    return await $.ajax({
      url: `/api/games/${gameId}/image/${imageType}`,
      method: "GET",
    })
  } catch (err){
    console.error(`Failed to load ${imageType}: `, err);
    return '/images/thumbnail_placeholder.jpg';
  }
}

async function loadGamesIntoGrid(container, games) {
  // show placeholder first 
    const placeholder = `<div class="grid-item-placeholder"></div>`;
    container.html(placeholder.repeat(games.length));

    const htmlList = await Promise.all(
      games.map(game => createGameFragment(game))
    );
    
    container.html(htmlList.join(""));
}

async function createGameFragment(game) {
  const isPC = game.platform === 'PC' || game.platform === 'BOTH';
  const isMobile = game.platform === 'MOBILE' || game.platform === 'BOTH';
  const imgUrl = await getImageUrl(game.id, "image");

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

async function filterGamesWithPackages(games) {
  const results = await Promise.all(
    games.map(async (game) => {
      try {
        const packages = await $.ajax({
          url: `/api/games/${game.id}/packages`,
          method: "GET"
        });

        return packages && packages.length > 0 ? game : null;
      } catch (err) {
        console.error(`Failed to fetch packages for game ${game.id}`, err);
        return null;
      }
    })
  );

  return results.filter(Boolean);
}



// Loading Stuff -----------------------------------
// ---------------------------------------------------------
async function loadAllGames() {
  const popularGames = await getListOfGames("/api/games/popular");
  const filteredPopularGames = await filterGamesWithPackages(popularGames);
  loadGamesIntoGrid($('#popular-games-grid'), filteredPopularGames);

  const allGames = await getListOfGames("/api/games/all");
  const filteredGames = await filterGamesWithPackages(allGames);
  loadGamesIntoGrid($('#all-games-grid'), filteredGames);
}

doc.ready(function (){
  loadProfileButton();
  loadAllGames();
  registerEvents();
});



// Add event to all grid item ------------------------------
// ---------------------------------------------------------
doc.on('click', '.grid-item', async function(){
    let id = $(this).data('game-id');

    try {
        window.location.href = `/game?id=${id}`;

    } catch (err) {
        console.error(err);
        alert("Request failed");
    }
});


// Buttons and Stuff -------------------------------------------------
// ---------------------------------------------------------
function registerEvents(){
  const registerBtn = $('#registerBtn');
  const shopBtn = $('#shopBtn');

  registerBtn.click(function (){
    window.location.href = "/register";
  })

  shopBtn.click(function (){
    $('html, body').animate({
      scrollTop: $('#popular-games').offset().top - $('#navbar').outerHeight()
    }, 500,'easeOutCubic');
  });
}

