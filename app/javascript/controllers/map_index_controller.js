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
    if (markers.length === 0) return

    const bounds = new mapboxgl.LngLatBounds()

    this.map.on("load", () => {
      markers.forEach((marker, i) => {
        const coords = [marker.lng, marker.lat]

        if (marker.status === "accepted") {
          const popup = new mapboxgl.Popup().setHTML(`
            <strong>${marker.name}</strong><br>
            ${marker.description}<br>
            <img src="/assets/chef.png" alt="Chef" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;">
            <strong>${marker.owner}</strong><br>
            <a href="${marker.path}" class="btn btn-sm btn-outline-primary mt-1">View</a>
          `)

          new mapboxgl.Marker()
            .setLngLat(coords)
            .setPopup(popup)
            .addTo(this.map)
        } else {
          const sourceId = `blurred-${i}`
          const layerId = `circle-${i}`

          this.map.addSource(sourceId, {
            type: "geojson",
            data: {
              type: "Feature",
              geometry: {
                type: "Point",
                coordinates: coords
              }
            }
          })

          this.map.addLayer({
            id: layerId,
            type: "circle",
            source: sourceId,
            paint: {
              "circle-radius": {
                stops: [[0, 0], [20, 5000]],
                base: 2
              },
              "circle-color": "#88f065",
              "circle-opacity": 0.15,
              "circle-stroke-color": "#88f065",
              "circle-stroke-width": 1
            }
          })

          this.map.on("click", layerId, (e) => {
            const exactMatches = markers.filter(m => m.lat === marker.lat && m.lng === marker.lng)

            const popupHTML = `
              <ul style="padding-left: 0; list-style: none;">
                ${exactMatches.map(m => `
                  <li style="margin-bottom: 10px;">
                    <strong>${m.name}</strong><br>
                    <img src="/assets/chef.png" alt="Chef" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;">
                    <strong>${m.owner}</strong><br>
                    <a href="${m.path}" class="btn-green-sm mt-1">View</a>
                  </li>
                `).join("")}
              </ul>
            `

            new mapboxgl.Popup({ className: "custom-popup" })
              .setLngLat(e.lngLat)
              .setHTML(popupHTML)
              .addTo(this.map)
          })

          this.map.on("mouseenter", layerId, () => {
            this.map.getCanvas().style.cursor = "pointer"
          })
          this.map.on("mouseleave", layerId, () => {
            this.map.getCanvas().style.cursor = ""
          })
        }

        bounds.extend(coords)
      })

      this.map.fitBounds(bounds, { padding: 60, maxZoom: 15, duration: 0 })
    })

    this.map.on("moveend", () => {
      const center = this.map.getCenter()
      this.updateCityLabel(center.lat, center.lng)
    })

    window.addEventListener("resize", () => this.map.resize())
    this.element.addEventListener("map:visible", () => this.map.resize())
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
      .then(res => res.json())
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
