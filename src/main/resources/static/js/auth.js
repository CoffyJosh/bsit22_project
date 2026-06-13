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
document.addEventListener("htmx:beforeSwap", function(e) {
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
            } else if (url.includes("/login")){
                if (typeof initPage === 'function') initPage();
            } else if (url.includes("/account-recovery")){
                if (typeof initPage === 'function') initPage();
            }
        }, 50);
    }, 300);
});

// ----------------------------
// HANDLE BROWSER BACK BUTTON
// ----------------------------
window.addEventListener('popstate', function(e) {
    const currentUrl = window.location.pathname;
    const container = document.getElementById("auth-form-content");
    
    // Fade out
    container.style.transition = "opacity 0.3s ease";
    container.style.opacity = "0";

    setTimeout(() => {
        htmx.ajax('GET', currentUrl, {
            target: '#auth-form-content',
            swap: 'innerHTML',
            onLoad: function() {
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
                    } else if (currentUrl.includes("/login")){
                        if (typeof initPage === 'function') initPage();
                    } else if (currentUrl.includes("/account-recovery")){
                        if (typeof initPage === 'function') initPage();
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
    document.addEventListener('DOMContentLoaded', updatePageTitle);
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
