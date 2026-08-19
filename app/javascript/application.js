// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "geocode"
import "bootstrap"

document.addEventListener("DOMContentLoaded", () => {
  const sortSelect = document.getElementById("sort-select");

  if (sortSelect) {
    sortSelect.addEventListener("change", () => {
      sortSelect.form.submit();
    });
  }
});

document.addEventListener("turbo:load", () => {
  const hamburgerBtn = document.querySelector(".hamburger-btn");
  const navMenu = document.querySelector(".desktop-nav");

  if (!hamburgerBtn || !navMenu) return;

  hamburgerBtn.addEventListener("click", () => {
    navMenu.classList.toggle("is-open");

    const icon = hamburgerBtn.querySelector("i");
    icon.classList.toggle("fa-bars");
    icon.classList.toggle("fa-xmark");
  });
});
