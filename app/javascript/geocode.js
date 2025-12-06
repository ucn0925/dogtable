let openInfoWindow = null;

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

                const marker = new google.maps.Marker({
                    position: { lat: shop.latitude, lng: shop.longitude },
                    map: map,
                    title: shop.name
                });

                const infoWindow = new google.maps.InfoWindow({
                    content: `
                      <div style="
                        font-size: 14px;
                        line-height: 1.5;
                        padding: 6px 4px;
                      ">
                        <div style="font-weight: bold; font-size: 15px; margin-bottom: 2px;">
                          ${shop.name}
                        </div>
                        <div style="color: #666; margin-bottom: 4px;">
                          ジャンル：${shop.genre_name}
                        </div>
                        <a href="/shops/${shop.id}" style="color: #007bff; text-decoration: underline;">
                          詳細ページを見る
                        </a>
                      </div>
                    `
                });

                marker.addListener("mouseover", () => {
                    if (openInfoWindow) {
                        openInfoWindow.close();
                    }
                    infoWindow.open({
                        anchor: marker,
                        map,
                    });
                    openInfoWindow = infoWindow;
                });

                marker.addListener("click", () => {
                    window.location.href = `/shops/${shop.id}`;
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
        if (status === "OK") {
            const lat = results[0].geometry.location.lat();
            const lng = results[0].geometry.location.lng();

            document.getElementById("shop-latitude").value = lat;
            document.getElementById("shop-longitude").value = lng;

            console.log(`セット完了！！ 緯度：${lat} 緯度：${lng}`);
        } else {
            console.error("ジオコーディング失敗：" + status);
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