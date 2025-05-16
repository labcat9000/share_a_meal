document.addEventListener("turbo:load", () => {
  const mapboxToken = document.querySelector("meta[name='mapbox-token']")?.content;

  const mapElement = document.getElementById("map");
  if (mapElement && mapboxToken) {
    mapboxgl.accessToken = mapboxToken;

    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: [-73.5673, 45.5019],
      zoom: 13
    });

    map.addControl(new mapboxgl.NavigationControl(), 'top-left');

    const locateBtn = document.getElementById("locate-btn");
    if (locateBtn) {
      locateBtn.addEventListener("click", () => {
        navigator.geolocation.getCurrentPosition(position => {
          const lng = position.coords.longitude;
          const lat = position.coords.latitude;

          map.flyTo({ center: [lng, lat], zoom: 14 });

          new mapboxgl.Marker({ color: "#d00" })
            .setLngLat([lng, lat])
            .addTo(map);
        });
      });
    }

    const listBtn = document.getElementById("list-view-btn");
    const mapBtn = document.getElementById("map-view-btn");
    const mealList = document.getElementById("meal-list");
    const mealMap = document.getElementById("meal-map");

    if (listBtn && mapBtn && mealList && mealMap) {
      listBtn.addEventListener("click", () => {
        listBtn.classList.add("active");
        mapBtn.classList.remove("active");
        mealList.style.display = "block";
        mealMap.style.display = "none";
      });

      mapBtn.addEventListener("click", () => {
        mapBtn.classList.add("active");
        listBtn.classList.remove("active");
        mealList.style.display = "none";
        mealMap.style.display = "block";
      });
    }
  }

  const showMap = document.getElementById("show-map");
  if (showMap && mapboxToken) {
    mapboxgl.accessToken = mapboxToken;

    const showMapInstance = new mapboxgl.Map({
      container: "show-map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: [-73.5673, 45.5019],
      zoom: 13
    });

    showMapInstance.addControl(new mapboxgl.NavigationControl(), 'top-left');
  }
});

// debug
