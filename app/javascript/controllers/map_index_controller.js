import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: String
  }

  static targets = ["map", "locationInfo"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [-73.5673, 45.5019],
      zoom: 13
    })

    this.map.addControl(new mapboxgl.NavigationControl(), 'top-left')

    const markers = JSON.parse(this.markersValue)

    if (markers.length > 0) {
      const bounds = new mapboxgl.LngLatBounds()

      markers.forEach((marker, i) => {
        const coordinates = [marker.lng, marker.lat]

        if (marker.status === "accepted") {
          const popup = new mapboxgl.Popup().setHTML(`
            <strong>${marker.name}</strong><br>
            ${marker.description}<br>
            Cooked by: ${marker.owner}<br>
            <a href="${marker.path}" class="btn btn-sm btn-outline-primary mt-1">View</a>
          `)

          new mapboxgl.Marker()
            .setLngLat(coordinates)
            .setPopup(popup)
            .addTo(this.map)
        } else {
          this.map.on("load", () => {
            this.map.addSource(`meal-${i}`, {
              type: "geojson",
              data: {
                type: "Feature",
                geometry: {
                  type: "Point",
                  coordinates: coordinates
                }
              }
            })

            this.map.addLayer({
              id: `blur-circle-${i}`,
              type: "circle",
              source: `meal-${i}`,
              paint: {
                "circle-radius": {
                  stops: [[0, 0], [20, 35000 / 2]],
                  base: 2
                },
                "circle-color": "#1e90ff",
                "circle-opacity": 0.15,
                "circle-stroke-color": "#1e90ff",
                "circle-stroke-width": 1
              }
            })
          })
        }

        bounds.extend(coordinates)
      })

      this.map.fitBounds(bounds, { padding: 60, maxZoom: 15, duration: 0 })
    }

    this.element.addEventListener("map:visible", () => {
      if (this.map) this.map.resize()
    })

    window.addEventListener("resize", () => {
      if (this.map) this.map.resize()
    })

    this.map.on("moveend", () => {
      const center = this.map.getCenter()
      this.updateCityLabel(center.lat, center.lng)
    })
  }

  locatePosition() {
    navigator.geolocation.getCurrentPosition(position => {
      const lat = position.coords.latitude
      const lng = position.coords.longitude

      this.map.flyTo({ center: [lng, lat], zoom: 14 })

      new mapboxgl.Marker({ color: "#d00" })
        .setLngLat([lng, lat])
        .addTo(this.map)

      this.updateCityLabel(lat, lng)
    })
  }

  updateCityLabel(lat, lng) {
    fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${lng},${lat}.json?access_token=${this.apiKeyValue}`)
      .then(response => response.json())
      .then(data => {
        const city = data.features.find(f => f.place_type.includes("place"))
        const country = data.features.find(f => f.place_type.includes("country"))

        if (city && country) {
          this.locationInfoTarget.innerHTML = `
            <p><strong>${city.text}, ${country.text}</strong><br><small>Location is approximate</small></p>
          `
        }
      })
      .catch(err => console.error("Geocoding error:", err))
  }
}
