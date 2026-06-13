// ---------- Variable and Stuff ---------------
let gameId = null;
let gameName = null;
let selected = null;
let paymentType = null;
let currencyName = null;

// ---------- INIT ---------------
$(document).ready(function (){
  getData();
  loadTitle();
  getGameInformation();
  getTopupPackages();
  addPaymentBoxEffect();
  onValueUpdates();
})


// ---------- Functions ---------------
function loadTitle() {
  document.title = `AURA GAMES | ${gameName}`
};

function getData(){
  gameId = $("#game-data").data("id");
  gameName = $("#game-data").data("name");
}

async function getImageUrl(gameId, imageType) {
  try {
    return await $.ajax({
      url: `/api/games/${gameId}/image/${imageType}`,
      method: "GET",
    })
  } catch (err){
    console.error("AJAX FAILED");
    console.error("Status:", err.status);
    console.error("Response:", err.responseText);
    console.error("Full error:", err);
  }
}

async function createPackageFragment(pkg){
  const amount = pkg.amount;
  const name = pkg.currencyName;
  const price = pkg.price;
  const bonus = pkg.bonus ?? 0;
  const totalValue = amount + bonus;

  const gameId = pkg.game.id;
  const topupId = pkg.id;

  const img = await getImageUrl(gameId, "currency");

  // Set Global Variable
  currencyName = name;

  return `
    <div class="package-grid-item" 
      data-topup-id="${topupId}" 
      data-currency-name="${name}"
      data-package-base="${amount}"
      data-bonus-amount="${bonus}"
      data-total-amount="${totalValue}"
      data-total-price="${price}">
      <img src="${img}" alt="${name}" onerror="this.onerror=null; this.src='/images/currency_placeholder.png';">
      <h1>${totalValue}</h1>
      <h2>${name}</h2>
      <h3>₱${price}</h3>
      ${bonus > 0 ? `<h4>+${bonus} bonus</h4>` : " "}
    </div>
  `;
}

async function getTopupPackages(){
  const container = $("#package-grid");
  console.log(gameId);
  try {
    const packages = await $.ajax({
      url: `/api/games/${gameId}/packages`,
      method: "GET"
    });
    console.log("SUCCESS:", packages);

    // show placeholder first 
    const placeholder = `<div class="package-grid-item-placeholder"></div>`;
    container.html(placeholder.repeat(packages.length));

    const htmlList = await Promise.all(
      packages.map(pkg => createPackageFragment(pkg))
    );
    
    container.html(htmlList.join(""));

    // Add selected effect (one item at a time)
    $(".package-grid-item").on("click", function () {
      const id = $(this).data("topup-id");
      const isSelected = $(this).hasClass("selected");

      const packageBase = $(this).data("package-base");
      const bonusAmount = $(this).data("bonus-amount");
      const currencyName = $(this).data("currency-name");
      const totalPrice = $(this).data("total-price");

      const packageDisplay = $("#package-base")
      const bonusAmountDisplay = $("#bonus-amount");
      const gameNameDisplay = $("#game-name"); 
      const totalPriceDisplay = $("#base-amount")

      $(".package-grid-item").removeClass("selected");

      if (!isSelected) {
          $(this).addClass("selected");
          selected = id;
          gameNameDisplay.text(gameName);
          packageDisplay.text(`${packageBase} ${currencyName}`);
          bonusAmountDisplay.text(`+${bonusAmount} Bonus`);    
          totalPriceDisplay.text(`₱ ${totalPrice}`);
      } else {
          selected = null;
          addDefaultValues();
      }

      console.log(selected);
      
    });

    // Display default value
    addDefaultValues();

  } catch (err) {
    console.log("STATUS:", err.status);
    console.log("RESPONSE TEXT:", err.responseText);
    console.log("FULL ERROR:", err);
  }
}

function createVoucherFragment(voucher) {
  const remainingUses = voucher.usageLimit - voucher.usedCount;

  const discountText =
    voucher.type === "PERCENT"
      ? `${voucher.discountValue}% OFF VOUCHER`
      : `₱${voucher.discountValue} OFF VOUCHER`;

  const expiryDate = new Date(voucher.expirationDate).toLocaleString(
    "en-PH",
    {
      year: "numeric",
      month: "long",
      day: "numeric",
      hour: "numeric",
      minute: "2-digit"
    }
  );

  return `
    <div class="voucher-box" data-voucher-id="${voucher.id}">
      <div class="voucher-info-row">

        <div class="voucher-info-left">
          <p class="voucher-info amount">${discountText}</p>
          <p class="voucher-info expiry">
            Expiration Date: ${expiryDate}
          </p>
        </div>

        <div class="voucher-info-right">
          <div
            style="
              width: 1px;
              align-self: stretch;
              background: rgba(255, 255, 255, 0.432);
              margin: 0;
            ">
          </div>

          <p class="voucher-info remaining">
            x${remainingUses}
          </p>
          <button class="remove-btn">x</button>
        </div>

      </div>
    </div>
  `;
}

function addPaymentBoxEffect(){

  // Add selected effect (one item at a time)
  $(".payment-box").on("click", function () {
    const paymentType = $(this).data("payment-type");
    const isSelected = $(this).hasClass("selected");
    $(".payment-box").removeClass("selected");

    if (!isSelected) {
        $(this).addClass("selected");
        this.paymentType = paymentType;
    } else {
        this.paymentType = null;
    }

    console.log(this.paymentType);
  });
}

function addDefaultValues(){
  const packageDisplay = $("#package-base")
  const bonusAmountDisplay = $("#bonus-amount");
  const gameNameDisplay = $("#game-name"); 
  const totalPriceDisplay = $("#total-price")
  const processingFee = $("#processing-fee")

  gameNameDisplay.text(`${gameName}`);
  packageDisplay.text(`0 ${currencyName}`);
  bonusAmountDisplay.text(`+0 Bonus`);
  processingFee.text(`₱ 0.00`);

  totalPriceDisplay.text(`₱ 0.00`);
}



function createPaymentBox(nameOfPayment, isInstant, symbolLetter, symbolColor) {
  return `
    <div class="payment-box" data-payment-type="${nameOfPayment}">
      
      <div class="payment-content-left">
        <div class="payment-symbol-holder" style="background-color: ${symbolColor};">
          <p>${symbolLetter}</p>
        </div>

        <div>
          <h1>${nameOfPayment}</h1>
          <h2>Pay via ${nameOfPayment} e-wallet</h2>
        </div>
      </div>

      <div class="payment-content-right">
        ${
          isInstant
            ? `
              <div class="payment-instant-tag">
                <h3>Instant</h3>
              </div>
            `
            : ""
        }

        <div class="payment-toggle-circle"></div>
      </div>

    </div>
  `;
}

async function getGameInformation(){

  // Set banner image
  const bannerDir = await getImageUrl(gameId, "banner")
  const bannerImg = $("#banner-image");
  bannerImg.attr("src", bannerDir);

  const gameNameCaps = gameName.toUpperCase();
  const gameDisplayName = $("#game-display-name");
  gameDisplayName.text(gameNameCaps);
}


function onValueUpdates(){
  const username = $("#username");
  const uid = $("#uid");
  let timer; // Holds the countdown state

  username.on('input', function(){
    clearTimeout(timer); // Reset the clock on every single keystroke
    timer = setTimeout(() => uid.text(username.val() || "-"), 500); // Wait 0.5s before updating
  });
}