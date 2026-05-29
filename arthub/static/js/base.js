// Show message notification
function showNotification(message) {
    const box = document.getElementById("notification");
    if (!box) return;

    box.textContent = message;
    box.style.display = "block";
    box.style.backgroundColor = "#6C63FF";
    box.style.color = "white";
    box.style.padding = "10px 20px";
    box.style.position = "fixed";
    box.style.top = "20px";
    box.style.right = "20px";
    box.style.zIndex = "9999";
    box.style.borderRadius = "10px";
    box.style.fontWeight = "bold";

    setTimeout(() => {
        box.style.display = "none";
    }, 3000);
}

// Load messages from Django
document.addEventListener("DOMContentLoaded", () => {
    if (window.DJANGO_MESSAGES && Array.isArray(window.DJANGO_MESSAGES)) {
        window.DJANGO_MESSAGES.forEach(msg => showNotification(msg));
    }
});



