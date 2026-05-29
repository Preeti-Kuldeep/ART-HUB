document.addEventListener('DOMContentLoaded', function() {

    const images = document.querySelectorAll(".slider img");
    let currentIndex = 0;

    function showNextImage() {
        images[currentIndex].classList.remove("active");
        currentIndex = (currentIndex + 1) % images.length;
        images[currentIndex].classList.add("active");
    }

    images[currentIndex].classList.add("active");
    setInterval(showNextImage, 3000);
    
    const cartButtons = document.querySelectorAll('.cart-btn');

    cartButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();  // 💬 Prevent any default form behavior

            const productId = this.dataset.productId;
            const action = this.dataset.action;
            const url = action === 'add' ? `/add-to-cart/${productId}/` : `/remove-from-cart/${productId}/`;

            fetch(url, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': '{{ csrf_token }}',  // Django CSRF protection
                    'Accept': 'application/json',
                },
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.action === 'added') {
                    this.innerText = 'Remove from Cart';
                    this.dataset.action = 'remove';
                } else if (data.action === 'removed') {
                    this.innerText = 'Add to Cart';
                    this.dataset.action = 'add';
                }
            // Show notification
            showNotification(data.message);
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification("Something went wrong!");
        });
});
});

// Notification function
function showNotification(message) {
const notification = document.getElementById('notification');
notification.textContent = message;
notification.classList.add('show');
notification.style.display = 'block';

setTimeout(() => {
    notification.classList.remove('show');
    setTimeout(() => {
        notification.style.display = 'none';
    }, 500);
}, 3000); // Hide after 3 seconds
}
});