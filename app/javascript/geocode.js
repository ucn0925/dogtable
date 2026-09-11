let openInfoWindow = null;
let markers = [];

function initMap() {

    const map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 35.663, lng: 138.568 },
        zoom: 13
    });

    const currentLocationBtn = document.getElementById("current-location-btn");

    if (currentLocationBtn) {
        currentLocationBtn.addEventListener("click", () => {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const userLat = position.coords.latitude;
                        const userLng = position.coords.longitude;

                        map.setCenter({ lat: userLat, lng: userLng });
                        map.setZoom(15);

                        new google.maps.Marker({
                            position: { lat: userLat, lng: userLng },
                            map: map,
                            icon: {
                                url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png"
                            }
                        });
                    },
                    () => {
                        alert("現在地を取得できませんでした。");
                    }
                );
            } else {
                alert("このブラウザは位置情報に対応していません。");
            }
        });
    }

    markers.forEach((marker) => marker.setMap(null));
    markers = [];

    if (typeof shops !== "undefined") {
        window.shops.forEach((shop) => {
            if (shop.latitude && shop.longitude) {

                const marker = new google.maps.Marker({
                    position: { lat: shop.latitude, lng: shop.longitude },
                    map: map,
                    title: shop.name
                });

                markers.push(marker);

                const infoWindow = new google.maps.InfoWindow({
                    content: `
                      <div style="font-size: 14px; line-height: 1.5; padding: 6px 4px;">
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
                    if (openInfoWindow) openInfoWindow.close();
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
  return new Promise ((resolve, reject) => {
    const addressField = document.getElementById("shop-address");
    const cityField = document.getElementById("shop_city_id");

    if (!addressField || !cityField) return;

    const cityName = cityField.options[cityField.selectedIndex].text;
    const address = addressField.value;

    if (!address) return;

    const fullAddress = `山梨県${cityName}${address}`;

    const geocoder = new google.maps.Geocoder();
    geocoder.geocode({ address: fullAddress }, (results, status) => {
        if (status === "OK") {
          
            const lat = results[0].geometry.location.lat();
            const lng = results[0].geometry.location.lng();

            document.getElementById("shop-latitude").value = lat;
            document.getElementById("shop-longitude").value = lng;

            resolve();

        } else {
            console.error("ジオコーディング失敗：" + status);
            reject();
        }
    });
  });
}

document.addEventListener("turbo:load", () => {

  const form = document.querySelector("#shop-form");

  if (form) {
    form.addEventListener("submit", async (event) => {
      event.preventDefault();
      await geocodeAddress();
      form.submit();
  });

  }

    if (document.getElementById("map") && window.google) {
        initMap();
    }

});

window.initMap = initMap;