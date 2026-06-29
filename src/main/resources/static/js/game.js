// ==================== GLOBALS ====================
let isLoggedIn = $("#voucher-section").data("auth") === true;
let gameId = null;
let gameName = null;
let packageName = null;

let selectedPackageId = null;
let paymentMethod = null;
let selectedVoucher = null;
let selectedRegion = null;

let selectedPackagePrice = 0;
let totalPrice = 0;
let processFee = 0;

let playerName = null;
let recieptEmail = null;

let referenceCode = null;






// ==================== INIT ====================
$(document).ready(function (){
  getData();
  loadTitle();
  getGameInformation();
  getTopupPackages();
  addPaymentBoxEffect();
  addElementFunctionalities();
  updatePaymentInfoState();
  addOtpFunctionalities();
  onValueUpdates();
})


// ==================== DATA ====================
function getData(){
  gameId = $("#game-data").data("id");
  gameName = $("#game-data").data("name");
}

function getGameInformation(){
  const bannerDir = getImageUrl(gameId, "banner");
  const bannerImg = $("#banner-image");
  bannerImg.attr("src", bannerDir);

  const gameNameCaps = gameName.toUpperCase();
  const gameDisplayName = $("#game-display-name");
  gameDisplayName.text(gameNameCaps);
}

async function getTopupPackages(){
  const container = $("#package-grid");
  try {
    const packages = await $.ajax({
      url: `/api/games/${gameId}/packages`,
      method: "GET"
    });

    const placeholder = `<div class="package-grid-item-placeholder"></div>`;
    container.html(placeholder.repeat(packages.length));

    const htmlList = await Promise.all(
      packages.map(pkg => createPackageFragment(pkg))
    );
    
    container.html(htmlList.join(""));

    $(".package-grid-item").on("click", function () {
      const id = $(this).data("topup-id");
      const isSelected = $(this).hasClass("selected");

      const packageBase = $(this).data("package-base");
      const bonusAmount = $(this).data("bonus-amount");
      const packageName = $(this).data("currency-name");
      const basePrice = $(this).data("base-price");

      const packageDisplay = $("#package-base");
      const bonusAmountDisplay = $("#bonus-amount");
      const gameNameDisplay = $("#game-name"); 
      const baseAmountDisplay = $("#base-amount");
      const totalAmountDisplay = $("#total-price");

      $(".package-grid-item").removeClass("selected");

      if (!isSelected) {
          $(this).addClass("selected");
          selectedPackageId = id;
          selectedPackagePrice = parseFloat(basePrice);
          gameNameDisplay.text(gameName);
          packageDisplay.text(`${packageBase} ${packageName}`);
          bonusAmountDisplay.text(`+${bonusAmount} Bonus`);    
          baseAmountDisplay.text(`₱ ${basePrice}`);
          totalAmountDisplay.text(`₱ ${basePrice}`);
          calculateTotal();
          updatePaymentInfoState();
      } else {
          selectedPackageId = null;
          updateToDefaultValues();
          updatePaymentInfoState();
      }
    });

    updateToDefaultValues();

  } catch (err) {
    console.log("STATUS:", err.status);
    console.log("RESPONSE TEXT:", err.responseText);
    console.log("FULL ERROR:", err);
  }
}


// ==================== DISPLAY ====================
function loadTitle() {
  document.title = `AURA GAMES | ${gameName}`;
}

function updateToDefaultValues(){
  $("#game-name").text(`${gameName}`);
  $("#package-base").text(`0 ${packageName}`);
  $("#bonus-amount").text(`+0 Bonus`);
  $("#processing-fee").text(`₱ 0.00`);
  $("#total-price").text(`₱ 0.00`);
  selectedPackagePrice = 0;
  totalPrice = 0;
}

function getImageUrl(gameId, imageType) {
  return `/api/games/${gameId}/image/${imageType}`;
}

async function createPackageFragment(pkg){
  const amount = pkg.amount;
  const name = pkg.game.packageName;
  const price = pkg.price;
  const bonus = pkg.bonus ?? 0;
  const totalValue = amount + bonus;

  const gameId = pkg.game.id;
  const topupId = pkg.id;

  const img = getImageUrl(gameId, "package");
  packageName = name;

  return `
    <div class="package-grid-item" 
      data-topup-id="${topupId}" 
      data-currency-name="${name}"
      data-package-base="${amount}"
      data-bonus-amount="${bonus}"
      data-total-amount="${totalValue}"
      data-base-price="${price}">
      <img src="${img}" alt="${name}" onerror="this.onerror=null; this.src='/images/currency_placeholder.png';">
      <h1>${amount}</h1>
      <h2>${name}</h2>
      <h3>₱${price}</h3>
      ${bonus > 0 ? `<h4>+${bonus} bonus</h4>` : " "}
    </div>
  `;
}

function createVoucherFragment(voucher) {
  const remainingUses = voucher.usageLimit - voucher.usedCount;
  const discountText = voucher.type === "PERCENT"
      ? `${voucher.discountValue}% OFF VOUCHER`
      : `₱${voucher.discountValue} OFF VOUCHER`;

  const expiryDate = new Date(voucher.expirationDate).toLocaleString("en-PH", {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit"
  });

  return `
    <div class="voucher-box" data-voucher-id="${voucher.id}">
      <div class="voucher-info-row">
        <div class="voucher-info-left">
          <p class="voucher-info amount">${discountText}</p>
          <p class="voucher-info expiry">Expiration Date: ${expiryDate}</p>
        </div>
        <div class="voucher-info-right">
          <div style="width: 1px; align-self: stretch; background: rgba(255, 255, 255, 0.432); margin: 0;"></div>
          <p class="voucher-info remaining">x${remainingUses}</p>
          <button class="remove-btn">x</button>
        </div>
      </div>
    </div>
  `;
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
        ${isInstant ? `<div class="payment-instant-tag"><h3>Instant</h3></div>` : ""}
        <div class="payment-toggle-circle"></div>
      </div>
    </div>
  `;
}


// ==================== PRICING ====================
function calculateTotal() {
  let finalPrice = selectedPackagePrice;

  // Apply voucher
  if (selectedVoucher) {
    if (selectedVoucher.type === "PERCENT") {
      finalPrice = finalPrice * (1 - selectedVoucher.discountValue / 100);
    } else if (selectedVoucher.type === "FIXED") {
      finalPrice = finalPrice - selectedVoucher.discountValue;
    }
  }

  if (finalPrice < 0) finalPrice = 0;

  // Get fee rate from selected payment box
  const feeRate = paymentMethod 
    ? Number($('.payment-box.selected').data("processing-fee")) 
    : 0;

  processFee = finalPrice * (feeRate / 100);
  totalPrice = Math.floor((finalPrice + processFee) * 4) / 4;

  // Update displays
  $("#processing-fee").text(`₱ ${processFee.toFixed(2)}`);
  $("#total-price").text(`₱ ${totalPrice.toFixed(2)}`);
}

function addVoucher(newVoucher) {
  // Remove existing voucher display if any
  $(".voucher-box").remove();

  selectedVoucher = newVoucher;

  const $fragment = $(createVoucherFragment(selectedVoucher));
    $fragment.find(".remove-btn").on("click", function () {
      selectedVoucher = null;
      $(".notice-text").text("");
      calculateTotal();
      $fragment.remove(); 
    });

    $(".voucher-container").append($fragment);
    calculateTotal();
  }


// ==================== EVENTS ====================
  function addPaymentBoxEffect(){
    $(".payment-box").on("click", function () {
      const $currentBox = $(this);
      const $toggleCircle = $(this).find(".circle-toggle");
      const $processFeeEl = $('#processing-fee');

      const type = $(this).data("payment-type");
      const isSelected = $(this).hasClass("selected");

      const processFeeData = $(this).data("processing-fee"); 
      const feeRate = Number(processFeeData); // percent rate

      $(".payment-box").removeClass("selected");
      $(".circle-toggle").removeClass("selected");

      if (!isSelected) {
          $currentBox.addClass("selected");
          $toggleCircle.addClass("selected");

          paymentMethod = type;
          processFee = (totalPrice * feeRate) / 100;

          $processFeeEl.text(`₱ ${processFee.toFixed(2)}`);

          calculateTotal();
          updatePaymentInfoState();
      } else {
          paymentMethod = null;
          processFee = 0;
          $processFeeEl.text(`₱ 0.00`);
          updatePaymentInfoState();
          calculateTotal();
      }
    });
  }

async function applyVoucher() {
  const $input = $("#voucher-code");
  const codeValue = $input.val().trim();
  const $noticeText = $(".notice-text");

  $noticeText.text("").removeClass("success warning error");

  if (!codeValue) {
    $noticeText.addClass("warning").text("Please enter a voucher code.");
    return;
  }

  try {
    const fetchedVoucher = await $.ajax({  // renamed from voucher
      url: `/api/voucher?code=${codeValue}`,
      type: "GET"
    });

    $input.val("");

    const result = isVoucherValid(fetchedVoucher);
    if (!result.ok) {
      $noticeText.addClass("warning").text(result.msg);
      return;
    }

    addVoucher(fetchedVoucher);  // pass fetchedVoucher, not the shadowed var
    
  } catch(err) {
    if (err.status === 404) {
      $noticeText.addClass("error").text("Voucher does not exist.");
    } else {
      $noticeText.addClass("error").text("Something went wrong. Please try again.");
    }
  }
}

function addElementFunctionalities(){
  // Apply voucher when button is clicked
  $(".voucher-button").on("click", function(event) {
    event.preventDefault();
    applyVoucher();
  });

  // Apply voucher when Enter is pressed in voucher input
  $("#voucher-code").on("keydown", function(event) {
    if (event.key === "Enter") applyVoucher();
  });

  // Update payment info state when any input inside payment info box changes
  $('.payment-info-box').on('input change', 'input, select, textarea', function() {
    updatePaymentInfoState();
  });

  // Restrict mobile number input to digits only, max 11 characters
  $('input[name="mobile"]').on('keydown', function(e) {
    const allowedKeys = ['Backspace', 'Delete', 'Tab', 'ArrowLeft', 'ArrowRight'];
    if (allowedKeys.includes(e.key)) return;
    if ((e.ctrlKey || e.metaKey) && e.key === 'v') return;
    if (!/^[0-9]$/.test(e.key)) { e.preventDefault(); return; }
    if ($(this).val().length >= 11) { e.preventDefault(); return; }
  });

  // Strip non-digits and limit to 11 characters on paste into mobile input
  $('input[name="mobile"]').on('paste', function(e) {
    e.preventDefault();
    const pasted = e.originalEvent.clipboardData.getData('text').replace(/[^0-9]/g, '').slice(0, 11);
    $(this).val(pasted);
    updatePaymentInfoState();
  });

  // Trigger OTP request when checkout button is clicked
  $('#send-otp').on('click', function () {
    onOtpRequest();
  });

  // Confirm OTP when confirm button is clicked
  $('#otp-confirm-btn').on('click', function () {
      onOtpConfirm($(this));
  });

  // Toggle region dropdown open/close
  $("#gameDropdown .dropdown-selected").on("click", function () {
    $("#gameDropdown .dropdown-options").toggle();
  });

  // Select a region option from the dropdown
  $("#gameDropdown .option").on("click", function () {
    const value = $(this).data("value");
    const text = $(this).text();
    selectedRegion = value;
    updatePaymentInfoState();

    $("#gameDropdown .dropdown-selected").text(text);
    $("#gameDropdown .dropdown-options").hide();

    if (!$('#gameDropdown .dropdown-selected').hasClass('filled')) {
      $("#gameDropdown .dropdown-selected").addClass('filled');
    }

    console.log("Selected:", value);
  });

  // Close dropdown when clicking outside of it
  $(document).on("click", function (e) {
    if (!$(e.target).closest("#gameDropdown").length) {
      $("#gameDropdown .dropdown-options").hide();
    }
  });

  // Helper to validate and set email
  function updateEmail(val) {
    const trimmed = val.trim();
    const isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(trimmed);
    recieptEmail = isValid ? trimmed : null;
  }

  // Pre-fill recieptEmail on load if Thymeleaf already populated the field
  updateEmail($('#email').val());

  // Track email input value for receipt with validation
  $('#email').on("input", function(){
    updateEmail($(this).val());
  });

  // Copy reference code to clipboard and show feedback
  $('.copy-button').on('click', function() {
      const text = $('#reference-code').text();
      navigator.clipboard.writeText(text).then(function() {
          $('.copy-button').text('COPIED!');
          setTimeout(() => $('.copy-button').html('<div class="copy-icon"></div> COPY'), 2000);
      });
  });

  // Reload the page when done button is clicked
  $('#done-button').on('click', function() {
    window.location.href=`/game?id=${gameId}`;
  });
}
function onValueUpdates(){
  const username = $("#username");
  const uid = $("#uid");
  let timer;

  username.on('input', function(){
    clearTimeout(timer);
    timer = setTimeout(() => uid.text(username.val() || "-"), 500);
    playerName = username.val();
  });
}

// ==================== HELPERS ====================
function isFieldFilled(selector) {
    const $el = $(selector);
    if (!$el.length) return false;

    const value = $el.val();
    return value !== null && value !== undefined && value.trim() !== '';
}

function isVoucherValid(voucher) {
  if (!voucher) return { ok: false, msg: "Invalid voucher." };

  const now = new Date();
  const expiry = new Date(voucher.expiration_date);

  if (voucher.status !== "ACTIVE") {
    return { ok: false, msg: "Voucher is inactive." };
  }

  if (expiry < now) {
    return { ok: false, msg: "Voucher has expired." };
  }

  if (voucher.usedCount >= voucher.usageLimit) {
    return { ok: false, msg: "Voucher has already been fully used." };
  }

  return { ok: true, msg: "Voucher applied." };
}


// ==================== PAYMENT ====================
function updatePaymentInfoState() {
    if (paymentMethod === null) {
        $('.payment-info-box').addClass('locked');
    } else {
        $('.payment-info-box').removeClass('locked');
    }
}

function getOtpValidationMessage() {

    const mobile = $('input[name="mobile"]').val().trim();

    const fields = {
        package: selectedPackageId !== null,
        paymentMethod: paymentMethod !== null,
        region: selectedRegion !== null,
        account: isFieldFilled('#username'),
        mobile: isFieldFilled('input[name="mobile"]'),
        mobileValid: /^(09)\d{9}$/.test(mobile),
        email: recieptEmail !== null
    };

    // ✅ Order matters (this fixes your wrong message issue)

    if (!fields.package) return "Please select a package.";
    if (!fields.paymentMethod) return "Please select a payment method.";
    if (!fields.region) return "Please select a region.";
    if (!fields.account) return "Please enter your User ID.";
    if (!fields.mobile) return "Please enter your mobile number.";
    if (!fields.mobileValid) return "Enter a valid mobile number (09XXXXXXXXX).";
    if (!fields.email) return "Please enter email for reciept.";

    return null;
}

function onOtpRequest(){
    const mobile = $('input[name="mobile"]').val().trim();

    const msg = getOtpValidationMessage();
    if (msg) {
        $('#send-warning').text(msg);
        return;
    }
      
    if (!/^(09)\d{9}$/.test(mobile)) {
        alert('Please enter a valid mobile number (09XXXXXXXXX).');
        return;
    }

    // locked + spinner
    $('#send-otp').addClass('locked').html('<span class="spinner"></span>');

    $.ajax({
        url: '/api/auth/send-code',
        method: 'POST',
        data: { recipient: mobile, purpose: 'PAYMENT' },
        complete: function (xhr) {

            if (xhr.status !== 200 && xhr.status !== 202) {
                // fail, restore button
                $('#send-otp').removeClass('locked').text('Send OTP →');
                alert('Failed to send OTP. Please try again.');
                return;
            }

            // success thenstays locked, overlay opens
            const secondsRemaining = xhr.status === 202 ? Number(xhr.responseText) : 0;
            showOtpOverlay(mobile, secondsRemaining);
        }
    });
}

// ==================== OTP ====================
let currentMobile = null;
let otpTimerInterval = null;

function updateOtpConfirmState() {
    const code = $('.otp-box').map(function () { return $(this).val(); }).get().join('');
    $('#otp-confirm-btn').prop('disabled', code.length !== 6);
}

function startOtpTimer(seconds) {
    $('#otp-resend-btn').prop('disabled', true)
        .css({ opacity: '0.4', cursor: 'not-allowed' })
        .text(`RESEND IN ${seconds}s`);

    if (otpTimerInterval) clearInterval(otpTimerInterval);

    otpTimerInterval = setInterval(() => {
        seconds--;
        $('#otp-resend-btn').text(`RESEND IN ${seconds}s`);
        if (seconds <= 0) {
            clearInterval(otpTimerInterval);
            $('#otp-resend-btn').prop('disabled', false)
                .css({ opacity: '1', cursor: 'pointer' })
                .text('RESEND CODE');
        }
    }, 1000);
}

function setOtpResendAvailable() {
    $('#otp-resend-btn').prop('disabled', false)
        .css({ opacity: '1', cursor: 'pointer' })
        .text('RESEND CODE');
}

function showOtpOverlay(mobile, secondsRemaining) {
    currentMobile = mobile;
    $('#otp-target-display').text(mobile);
    $('.otp-box').val('');
    $('#otp-warning').text('');
    updateOtpConfirmState();
    $('#transaction-overlay').css('display', 'flex');

    if (secondsRemaining > 0) startOtpTimer(secondsRemaining);
    else setOtpResendAvailable();
}

function hideOtpOverlay() {
    $('#transaction-overlay').css('display', 'none');
    $('.otp-box').val('');
    $('#otp-warning').text('');
    if (otpTimerInterval) clearInterval(otpTimerInterval);
    $('#send-otp').removeClass('locked').text('Send OTP →');
}

function addOtpFunctionalities() {

    // 1 & 2 — confirm state + enter to submit
    $(document).on('keydown', '.otp-box', function (e) {
        const $boxes = $('.otp-box');
        const index = $boxes.index(this);

        // 2. enter submits if all 6 filled
        if (e.key === 'Enter') {
            const code = $boxes.map(function () { return $(this).val(); }).get().join('');
            if (code.length === 6 && !$('#otp-confirm-btn').prop('disabled')) {
                $('#otp-confirm-btn').trigger('click');
            }
            return;
        }

        if ((e.ctrlKey || e.metaKey) && e.key === 'v') return;

        // 6. backspace goes back to previous box
        if (e.key === 'Backspace') {
            if ($(this).val()) {
                $(this).val('');
            } else if (index > 0) {
                $boxes.eq(index - 1).val('').focus();
            }
            updateOtpConfirmState();
            e.preventDefault();
            return;
        }

        const allowedKeys = ['Delete', 'Tab', 'ArrowLeft', 'ArrowRight'];
        if (allowedKeys.includes(e.key)) return;
        if (!/^[0-9]$/.test(e.key)) { e.preventDefault(); return; }

        $(this).val(e.key);
        updateOtpConfirmState();
        if (index < 5) $boxes.eq(index + 1).focus();
        e.preventDefault();
    });

    // 3. paste across all boxes
    $(document).on('paste', '.otp-box', function (e) {
        e.preventDefault();
        const pasted = e.originalEvent.clipboardData.getData('text').replace(/[^0-9]/g, '').slice(0, 6);
        const $boxes = $('.otp-box');
        pasted.split('').forEach((char, i) => { if ($boxes.eq(i).length) $boxes.eq(i).val(char); });
        $boxes.eq(Math.min(pasted.length - 1, 5)).focus();
        updateOtpConfirmState();
    });

    // 4. resend
    $('#otp-resend-btn').on('click', function () {
        $(this).prop('disabled', true)
            .css({ opacity: '0.4', cursor: 'not-allowed' })
            .html('<span class="spinner"></span>');

        $.ajax({
            url: '/api/auth/resend-code',
            method: 'POST',
            data: { recipient: currentMobile, purpose: 'PAYMENT' },
            complete: function (xhr) {
                console.log('RESEND STATUS:', xhr.status);
                console.log('RESEND RESPONSE:', xhr.responseText);

                if (xhr.status === 429) {
                    startOtpTimer(Number(xhr.responseText));
                } else if (xhr.status === 200) {
                    $('.otp-box').val('');
                    $('#otp-warning').text('Code resent!').css('color', '#34D399');
                    startOtpTimer(60);
                } else {
                    $('#otp-warning').text('Failed to resend.').css('color', '#f54242');
                    setOtpResendAvailable();
                }
            }
        });
    });

    // cancel button
    $('#otp-cancel-btn').on('click', function () {
        hideOtpOverlay();
    });
}

function onOtpConfirm($btn) {
  const code = $('.otp-box').map(function () { return $(this).val(); }).get().join('');

  $('#otp-warning').text('');
  $btn.prop('disabled', true).html('<span class="spinner"></span>');

  $.ajax({
    url: '/api/auth/verify-code',
    method: 'POST',
    data: { recipient: currentMobile, code: code, purpose: 'PAYMENT' },
    complete: function (xhr) {
        $btn.text('CONFIRM →');

        switch (xhr.status) {
            case 200:
                // OTP verified — payment logic goes here
                $('.otp-wrapper').hide();
                $('.topup-wrapper').css('display', 'flex');
                handleFakeAssTransactionScreen();
                break;
            case 400:
                $('#otp-warning').text('Invalid code, try again.');
                $btn.prop('disabled', false);
                break;
            case 410:
                $('#otp-warning').text('Code expired, please request a new one.');
                setOtpResendAvailable();
                break;
            case 404:
                $('#otp-warning').text('No code found, please resend.');
                setOtpResendAvailable();
                break;
            default:
                $('#otp-warning').text('Something went wrong.');
                $btn.prop('disabled', false);
        }
    }
  });
}

async function handleFakeAssTransactionScreen() {
  setStartMessage("pb1", "Verifying OTP");
  setStartMessage("pb2", `Authorizing ${paymentMethod}`);
  setStartMessage("pb3", `Dispatching ${packageName}`);

  await setStep("pb1", 2000, "OTP Verified");
  await setStep("pb2", 4000, `Authorizing ${paymentMethod}`);

  const packageData = await processTransaction();
  if (!packageData) {
    const parent = $('#pb3');
    const dot = parent.find(".processing-dot");
    parent.removeClass("processing").addClass("failed");
    dot.removeClass("processing").addClass("failed");

    await sleep(2000);
    window.location.href = `/game?id=${gameId}`; 
    return;
  }

  const parent = $('#pb3');
  const dot = parent.find(".processing-dot");
  const currentAction = parent.find("#process-message");
  
  parent.removeClass("processing").addClass("done");
  dot.removeClass("processing").addClass("done");
  currentAction.text(`${packageName} Dispatched!`);

  // Step 5: Stop the global spinners
  $('.transaction-spinner')
    .children('.inner-spinner, .outer-spinner, .center-spinner')
    .addClass('done');

  await sleep(2000);
  showReciept(packageData);
}

async function setStep(id, delay, endMsg) {
  const parent = $(`#${id}`);
  const dot = parent.find(".processing-dot");
  const currentAction = parent.find("#process-message");
  parent.addClass("processing");
  dot.addClass("processing");

  await sleep(delay);
  parent.removeClass("processing").addClass("done");
  dot.removeClass("processing").addClass("done");
  currentAction.text(`${endMsg}`)
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function setStartMessage(id, message){
  const parent = $(`#${id}`);
  const currentAction = parent.find("#process-message");
  currentAction.text(`${message}`)
}


// ==================== TRANSACTIONS ====================
async function processTransaction(){
  const parent = $('#pb3');
  const dot = parent.find(".processing-dot");
  const currentAction = parent.find("#process-message");
  
  parent.addClass("processing");
  dot.addClass("processing");
  currentAction.text(`Dispatching ${packageName}`);

  await sleep(2000);

  try {
    const order = await $.ajax({
      url: '/api/orders',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        packageId: selectedPackageId,
        quantity: 1,
        voucherCode: selectedVoucher ? selectedVoucher.code : null,
        accountId: playerName,
        server: selectedRegion,
        email: recieptEmail
      })
    });

    const payment = await $.ajax({
      url: '/api/payments',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        orderId: order.id,
        paymentMethod: paymentMethod,
        amount: totalPrice
      })
    });

    referenceCode = payment.transactionReference;

    // Fetch the critical package details
    const packageData = await $.ajax({
      url: `/api/games/package`,
      method: "GET",
      data: { id: selectedPackageId }
    });

    // Fire email payload silently in background
    const emailPayload = {
      gameName: packageData.game.name,
      totalAmount: `${packageData.amount + packageData.bonus} ${packageData.game.packageName}`,
      playerName: playerName,
      receiptEmail: recieptEmail,
      paymentMethod: paymentMethod,
      totalPrice: totalPrice.toFixed(2),
      referenceCode: referenceCode,
      packageName: packageData.game.packageName
    };
    console.log(emailPayload);
    await sleep (9999);
    const completeHtmlBody = generateReceiptEmail(emailPayload);

    $.ajax({
      url: '/mail/sendMsg',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        recipient: recieptEmail,
        subject: `Aura Games - Purchase Complete [${referenceCode}]`,
        body: completeHtmlBody
      })
    }).catch(e => console.error("Background email failed:", e));

    // Simply return the data object to the waiting orchestrator function
    return packageData;

  } catch (err) {
    console.error("Backend process failed:", err);
    return null;
  }
}

// Accept packageData directly to eliminate the duplicate API call
function showReciept(packageData){
  $('.topup-wrapper').hide();
  $('.transaction-box').addClass('reciept');
  $('.reciept-wrapper').css('display', 'flex');

  $('#reciept-game').text(`${packageData.game.name}`);
  $('#reciept-amount').text(`${packageData.amount + packageData.bonus} ${packageData.game.packageName}`);
  $('#reciept-player').text(`${playerName}`);
  $('#reciept-email').text(`${recieptEmail}`);
  $('#reciept-payment').text(`${paymentMethod}`);
  $('#reciept-price').text(`₱${totalPrice.toFixed(2)}`);
  $('#reference-code').text(`${referenceCode}`);
}

function generateReceiptEmail(data) {
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Aura Games - Purchase Complete</title>
  <style>
    body, table, td, p, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; margin: 0; padding: 0; }
    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse !important; }
    body { height: 100% !important; width: 100% !important; background-color: #13101a; margin: 0 !important; padding: 0 !important; }
    @import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Inter:wght@300;600&family=Rajdhani:wght@500;600;700&display=swap');
  </style>
</head>
<body style="background-color: #13101a; font-family: 'DM Sans', Arial, sans-serif; margin: 0; padding: 0;">

  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #13101a; table-layout: fixed;">
    <tr>
      <td align="center" style="padding: 50px 15px;">
        
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 480px; background-color: #111111; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 16px; overflow: hidden; border-collapse: separate;">
          <tr>
            <td style="background-image: radial-gradient(circle at 50% 0%, rgba(0, 102, 51, 0.4) 0%, rgba(17, 17, 17, 0) 75%); background-color: #111111; border-radius: 16px; padding-bottom: 35px;">

              <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-bottom: 1px solid rgba(255, 255, 255, 0.055); background-color: rgba(0, 0, 0, 0.45);">
                <tr>
                  <td align="center" style="padding: 18px 0;">
                    <p style="font-size: 22px; font-weight: 600; font-family: 'Rajdhani', Arial, sans-serif; color: #ffffff; letter-spacing: 1px; margin: 0;">
                      AURA <span style="color: #7C3AED;">GAMES</span>
                    </p>
                  </td>
                </tr>
              </table>

              <table border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: center;">
                <tr>
                  <td align="center" style="padding: 40px 30px 0 30px;">
                    <h1 style="font-family: 'Rajdhani', Arial, sans-serif; font-size: 38px; font-weight: 700; color: #ffffff; margin: 0 0 12px 0; padding: 0; letter-spacing: 0.5px; text-transform: uppercase;">
                      Purchase Complete
                    </h1>
                    <p style="font-family: 'DM Sans', Arial, sans-serif; font-size: 15px; font-weight: 400; color: rgba(255, 255, 255, 0.6); width: 85%; margin: 0 auto; padding: 0; line-height: 1.5;">
                      Your <span style="color: #ffffff; font-weight: 500;">${data.packageName}</span> have been dispatched to your account. Check your inbox for the receipt.
                    </p>
                  </td>
                </tr>
              </table>

              <table border="0" cellpadding="0" cellspacing="0" width="90%" style="background-color: rgba(255, 255, 255, 0.015); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 12px; margin: 40px auto 0 auto; padding: 25px 25px;">
                <tr>
                  <td>
                    <p style="font-family: 'Rajdhani', Arial, sans-serif; font-weight: 600; font-size: 16px; color: rgba(255, 255, 255, 0.4); margin: 0 0 25px 0; text-align: center; letter-spacing: 2px; text-transform: uppercase;">
                      Transaction Details
                    </p>

                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 6px 0;">Game</td>
                        <td align="right" style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: #ffffff; font-weight: 500; padding: 6px 0;">${data.gameName}</td>
                      </tr>
                      <tr><td colspan="2" style="height: 1px; background: rgba(255, 255, 255, 0.08); margin: 12px 0; display: block;"></td></tr>
                      
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 6px 0;">Amount</td>
                        <td align="right" style="font-family: 'Rajdhani', Arial, sans-serif; font-size: 16px; font-weight: 600; color: #A78BFA; padding: 6px 0;">${data.totalAmount}</td>
                      </tr>
                      <tr><td colspan="2" style="height: 1px; background: rgba(255, 255, 255, 0.08); margin: 12px 0; display: block;"></td></tr>
                      
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 6px 0;">User ID</td>
                        <td align="right" style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: #ffffff; padding: 6px 0;">${data.playerName}</td>
                      </tr>
                      <tr><td colspan="2" style="height: 1px; background: rgba(255, 255, 255, 0.08); margin: 12px 0; display: block;"></td></tr>
                      
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 6px 0;">Email</td>
                        <td align="right" style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: #ffffff; padding: 6px 0;">${data.receiptEmail}</td>
                      </tr>
                      <tr><td colspan="2" style="height: 1px; background: rgba(255, 255, 255, 0.08); margin: 12px 0; display: block;"></td></tr>
                      
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 6px 0;">Payment Method</td>
                        <td align="right" style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: #ffffff; padding: 6px 0;">${data.paymentMethod}</td>
                      </tr>
                      <tr><td colspan="2" style="height: 1px; background: rgba(255, 255, 255, 0.08); margin: 12px 0; display: block;"></td></tr>
                      
                      <tr>
                        <td style="font-family: 'DM Sans', Arial, sans-serif; font-size: 14px; color: rgba(255, 255, 255, 0.5); padding: 18px 0 0 0; vertical-align: middle;">Payment Amount</td>
                        <td align="right" style="font-family: 'Rajdhani', Arial, sans-serif; font-size: 34px; font-weight: 700; color: #ffffff; padding: 18px 0 0 0;">₱${data.totalPrice}</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>

              <table border="0" cellpadding="0" cellspacing="0" width="90%" style="background-color: rgba(255, 255, 255, 0.015); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 12px; margin: 24px auto 0 auto; padding: 22px; text-align: center;">
                <tr>
                  <td>
                    <p style="font-family: 'Inter', Arial, sans-serif; font-size: 11px; font-weight: 400; padding: 0; margin: 0 0 6px 0; color: rgba(255, 255, 255, 0.3); text-transform: uppercase; letter-spacing: 1.5px;">
                      Reference Code
                    </p>
                    <p style="font-family: 'Inter', Arial, sans-serif; font-size: 24px; font-weight: 700; padding: 0; margin: 0 0 24px 0; color: #ffffff; letter-spacing: 0.5px;">
                      ${data.referenceCode}
                    </p>
                  </td>
                </tr>
              </table>

            </td>
          </tr>
        </table>

      </td>
    </tr>
  </table>

</body>
</html>
  `;
}