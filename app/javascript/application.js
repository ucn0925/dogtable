// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "geocode"

document.addEventListener("DOMContentLoaded", () => {
  const sortSelect = document.getElementById("sort-select");

  if (sortSelect) {
    sortSelect.addEventListener("change", () => {
      sortSelect.formdata.submit();
    });
  }
});