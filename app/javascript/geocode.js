console.log("geocode.js loaded");

function initMap() {
    console.log("Google Maps セット完了！");

    const map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 35.663, lng: 138.568 },
        zoom: 13
    });

    if (typeof shops !== "undefined") {
        shops.forEach((shop) => {
            if (shop.latitude && shop.longitude) {
                new google.maps.Marker({
                    position: { lat: shop.latitude, lng: shop.longitude },
                    map: map,
                    title: shop.name
                });
            }
        });
    }
}

function geocodeAddress() {
    const addressField = document.getElementById("shop-address");
    if (!addressField) return;

    const address = addressField.value;
    if (!address) return;

    const geocoder = new google.maps.Geocoder();

    geocoder.geocode({ address: address }, function(results, status) {
        if (status === "OK"){
            const lat = results[0].geometry.location.lat();
            const lng = results[0].geometry.location.lng();

            document.getElementById("shop-latitude").value = lat;
            document.getElementById("shop-longitude").value = lng;

            console.log("緯度・経度セット完了：", lat, lng);
        } else {
            console.warn("Geocode failed: " + status);
        }
    });
}

document.addEventListener("turbo:load", () => {
    const addressField = document.getElementById("shop-address");
    if (addressField) {
        addressField.addEventListener("change", geocodeAddress);
    }
});

window.initMap = initMap;