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
document.addEventListener("htmx:beforeSwap", function(e) {
    const container = document.getElementById("auth-form-content");
    
    container.style.transition = "opacity 0.3s ease";
    container.style.opacity = "0";

    e.detail.shouldSwap = false;

    setTimeout(function() {
        e.detail.target.innerHTML = e.detail.serverResponse;
        htmx.process(e.detail.target);

        const url = e.detail.pathInfo.requestPath;
        window.history.pushState({}, "", url);
        document.title = url === "/register" ? "AURA GAMES | Register" : "AURA GAMES | Login";
        
        container.style.transition = "opacity 0.3s ease";
        container.style.opacity = "1";

        if (url === "/register") {
            loadScript("/js/register.js", () => {
                if (typeof initPage === 'function') initPage();
            });
        } else {
            if (typeof initPage === 'function') initPage();
        }

    }, 300);
});

// ----------------------------
// PAGE TITLE ON LOAD
// ----------------------------
if (window.location.pathname === "/register") {
    document.title = "AURA GAMES | Register";
} else {
    document.title = "AURA GAMES | Login";
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