import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import Rails from "@rails/ujs"
Rails.start()
document.addEventListener("DOMContentLoaded", function () {
  const alerts = document.querySelectorAll('.alert');
  alerts.forEach((alert) => {
    setTimeout(() => {
      alert.classList.remove('show');
      alert.classList.add('fade');
    }, 4000); // hides after 4 seconds
  });
});
