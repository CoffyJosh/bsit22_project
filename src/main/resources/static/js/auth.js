// ----------------------------
// LOAD SCRIPT HELPER
// ----------------------------
function loadScript(src, callback) {
  const existing = document.querySelector(`script[src="${src}"]`);
  if (existing) existing.remove();

  const script = document.createElement('script');
  script.src = src;
  script.onload = callback;
  document.body.appendChild(script);
}

function initPageByUrl() {

  const url = window.location.pathname;

  if (url.includes("/register")) {

    loadScript("/js/register.js", () => {
      if (typeof initPage === 'function') initPage();
    });

  } else if (url.includes("/login")) {

    if (typeof initPage === 'function') initPage();

  } else if (url.includes("/account-recovery")) {

    loadScript("/js/account-recovery.js", () => {
      if (typeof initPage === 'function') initPage();
    });
  }
}


// ----------------------------
// PAGE SWAPPING
// ----------------------------
function updatePageTitle() {
  const fragment = document.querySelector('[data-page-title]');
  if (fragment) {
    document.title = fragment.getAttribute('data-page-title');
  }
}

// ----------------------------
// FADE OUT BEFORE SWAP
// ----------------------------
document.addEventListener("htmx:beforeSwap", function (e) {
  if (e.detail.target.id !== 'auth-form-content') return;

  const container = document.getElementById("auth-form-content");

  // Prevent automatic swap
  e.detail.shouldSwap = false;

  // Fade out
  container.style.transition = "opacity 0.3s ease";
  container.style.opacity = "0";

  // Swap after fade completes
  setTimeout(() => {
    e.detail.target.innerHTML = e.detail.serverResponse;
    htmx.process(e.detail.target);

    // Manually push URL to history
    const url = e.detail.xhr.responseURL || window.location.pathname;
    window.history.pushState({}, "", url);

    // Fade in
    setTimeout(() => {
      container.style.transition = "opacity 0.3s ease";
      container.style.opacity = "1";

      updatePageTitle();

      // Load scripts
      if (url.includes("/register")) {
        loadScript("/js/register.js", () => {
          if (typeof initPage === 'function') initPage();
        });
      } else if (url.includes("/login")) {
        if (typeof initPage === 'function') initPage();
      } else if (url.includes("/account-recovery")) {
        loadScript("/js/account-recovery.js", () => {
          if (typeof initPage === 'function') initPage();
        });
      }
    }, 50);
  }, 300);
});

// ----------------------------
// HANDLE BROWSER BACK BUTTON
// ----------------------------
window.addEventListener('popstate', function (e) {
  const currentUrl = window.location.pathname;
  const container = document.getElementById("auth-form-content");

  // Fade out
  container.style.transition = "opacity 0.3s ease";
  container.style.opacity = "0";

  setTimeout(() => {
    htmx.ajax('GET', currentUrl, {
      target: '#auth-form-content',
      swap: 'innerHTML',
      onLoad: function () {
        // Fade in after swap completes
        setTimeout(() => {
          container.style.transition = "opacity 0.3s ease";
          container.style.opacity = "1";
          updatePageTitle();

          // Load scripts
          if (currentUrl.includes("/register")) {
            loadScript("/js/register.js", () => {
              if (typeof initPage === 'function') initPage();
            });
          } else if (currentUrl.includes("/login")) {
            if (typeof initPage === 'function') initPage();
          } else if (currentUrl.includes("/account-recovery")) {
            loadScript("/js/account-recovery.js", () => {
              if (typeof initPage === 'function') initPage();
            });
          }
        }, 50);
      }
    });
  }, 300);
});

// ----------------------------
// PAGE TITLE ON LOAD
// ----------------------------
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', function () {
    updatePageTitle();
    initPageByUrl();
  });
} else {
  // Already loaded (if script runs after DOM is ready)
  setTimeout(updatePageTitle, 0);
}

// ----------------------------
// SUBTITLE CHANGE EFFECT
// ----------------------------
const texts = [
  "FAST & SECURE DIGITAL GAME TOP-UPS",
  "INSTANT IN-GAME CURRENCY DELIVERY",
  "BUY V-BUCKS, UC, DIAMONDS INSTANTLY",
  "LEVEL UP WITH INSTANT TOP-UPS"
];

let i = 0;

setInterval(() => {
  const el = document.querySelector(".logo-subtitle");

  el.style.letterSpacing = "10px";
  el.style.opacity = "0";

  setTimeout(() => {
    i = (i + 1) % texts.length;
    el.textContent = texts[i];
    el.style.letterSpacing = "5px";
    el.style.opacity = "1";
  }, 200);

}, 8000);


// Home button on auth
$(document).on('click', '.logo-image', function () {
  window.location.href = "/";
});

$(document).on('click', '.logo-image', function () {
  window.location.href = "/";
});

/* ======================================================================= */
$(document).on('click', '#open-terms', function (e) {
  e.preventDefault();
  setTermsAndConditions();
});

$(document).on('click', '#open-privacy', function (e) {
  e.preventDefault();
  setPrivacyPolicy();
});

$(document).on('click', '.to-close, .to-footer-btn', function () {
  hideTermsOverlay();
});

function setTermsAndConditions() {
  $('#termsOverlayTitle').text('Terms & Conditions');

  $('#termsOverlayContent').html(`
    <h3>1. Acceptance of Terms</h3>
    <p>By creating an account or topping up in-game currency through our platform, you agree to be bound by these Terms & Conditions. If you do not agree, please discontinue use of the service.</p>

    <h3>2. Eligibility</h3>
    <p>You must be at least 13 years old, or the minimum age of digital consent in your country, to use this service. Users under 18 should have permission from a parent or guardian, particularly for payment-related actions.</p>

    <h3>3. Account & Login</h3>
    <p>Certain features are only available while logged in, including viewing your transaction history, redeeming vouchers, and tracking top-up orders. You are responsible for keeping your login credentials secure and for all activity under your account.</p>

    <h3>4. Top-Ups & Digital Currency</h3>
    <p>All purchases of in-game currency are final once delivered to the linked game account. Delivery times may vary by game publisher and are outside our direct control. Please double-check your Game ID and server before confirming a purchase.</p>

    <h3>5. Vouchers & Promotions</h3>
    <p>Vouchers, discount codes, and promotional credits are non-transferable, may have expiration dates, and can only be applied while logged into your account. We reserve the right to revoke vouchers obtained through fraud or abuse.</p>

    <h3>6. Refunds & Disputes</h3>
    <p>Due to the digital nature of in-game currency, refunds are generally not available once a top-up is successfully delivered. Exceptions may apply in cases of duplicate charges or failed delivery — contact support with your order ID.</p>

    <h3>7. Prohibited Use</h3>
    <p>You may not use the platform to purchase currency for accounts you do not own or have authorization to top up, exploit pricing errors, or use automated tools to place orders.</p>

    <h3>8. Changes to These Terms</h3>
    <p>We may update these Terms from time to time. Continued use of the platform after changes are posted constitutes acceptance of the revised Terms.</p>

    <h3>9. Contact</h3>
    <p>Questions about these Terms can be sent to our support team through the Help Center while logged into your account.</p>
  `);

  if (typeof showTermsOverlay === 'function') showTermsOverlay();
}

function setPrivacyPolicy() {
  $('#termsOverlayTitle').text('Privacy Policy');

  $('#termsOverlayContent').html(`
    <h3>1. Information We Collect</h3>
    <p>We collect information you provide directly, such as your email, username, and linked Game ID, as well as transaction data when you top up currency or redeem a voucher.</p>

    <h3>2. How We Use Your Information</h3>
    <p>Your information is used to process top-up orders, maintain your transaction history, apply vouchers to your account, prevent fraud, and provide customer support.</p>

    <h3>3. Account-Restricted Data</h3>
    <p>Some data, including your transaction history and active vouchers, is only viewable while logged in. We do not display this information publicly or to other users.</p>

    <h3>4. Payment Information</h3>
    <p>Payment details are processed through third-party payment providers. We do not store full card numbers on our servers; only limited transaction metadata is retained for order verification.</p>

    <h3>5. Data Sharing</h3>
    <p>We do not sell your personal information. Limited data, such as your Game ID and order amount, may be shared with the relevant game publisher solely to complete currency delivery.</p>

    <h3>6. Data Retention</h3>
    <p>We retain account and transaction data for as long as your account is active, or as required to comply with legal, tax, or fraud-prevention obligations.</p>

    <h3>7. Your Choices</h3>
    <p>You may request access to, correction of, or deletion of your personal data by contacting support through your account, subject to limits where data must be kept for legal or security reasons.</p>

    <h3>8. Cookies & Tracking</h3>
    <p>We use cookies and similar technologies to keep you logged in, remember preferences, and understand how the platform is used so we can improve it.</p>

    <h3>9. Changes to This Policy</h3>
    <p>We may revise this Privacy Policy periodically. Material changes will be communicated through the platform or via email where applicable.</p>
  `);

  if (typeof showTermsOverlay === 'function') showTermsOverlay();
}

function showTermsOverlay() {
  $('#termsOverlay').addClass('active');
}
function hideTermsOverlay() {
  $('#termsOverlay').removeClass('active');
}