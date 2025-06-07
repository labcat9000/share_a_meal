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

    const allMarkers = JSON.parse(this.markersValue)
    const accepted = []
    const blurred = []

    allMarkers.forEach(marker => {
      if (marker.status === "accepted") {
        accepted.push(marker)
      } else {
        blurred.push(marker)
      }
    })

    const bounds = new mapboxgl.LngLatBounds()

    accepted.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(`
        <strong>${marker.name}</strong><br>
        ${marker.description}<br>
        Cooked by: ${marker.owner}<br>
        <a href="${marker.path}" class="btn btn-sm btn-outline-primary mt-1">View</a>
      `)

      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)

      bounds.extend([marker.lng, marker.lat])
    })

    this.map.on("load", () => {
      this.map.addSource("blurred-meals", {
        type: "geojson",
        data: {
          type: "FeatureCollection",
          features: blurred.map(m => ({
            type: "Feature",
            geometry: {
              type: "Point",
              coordinates: [m.lng, m.lat]
            },
            properties: { name: m.name }
          }))
        },
        cluster: true,
        clusterMaxZoom: 14,
        clusterRadius: 60
      })

      this.map.addLayer({
        id: "clusters",
        type: "circle",
        source: "blurred-meals",
        filter: ["has", "point_count"],
        paint: {
          "circle-color": "#87da5e",
          "circle-opacity": 0.2,
          "circle-stroke-color": "#87da5e",
          "circle-stroke-width": 1,
          "circle-radius": [
            "interpolate",
            ["linear"],
            ["get", "point_count"],
            1, 50,
            5, 60,
            10, 70,
            20, 80,
            40, 90,
            100, 80
          ]
        }
      })



      this.map.addLayer({
        id: "cluster-count",
        type: "symbol",
        source: "blurred-meals",
        filter: ["has", "point_count"],
        layout: {
          "text-field": "{point_count_abbreviated}",
          "text-font": ["DIN Offc Pro Medium", "Arial Unicode MS Bold"],
          "text-size": 14
        }
      })

      this.map.addLayer({
        id: "unclustered-point",
        type: "circle",
        source: "blurred-meals",
        filter: ["!", ["has", "point_count"]],
        paint: {
          "circle-color": "#1e90ff",
          "circle-radius": 35,
          "circle-opacity": 0.15,
          "circle-stroke-color": "#1e90ff",
          "circle-stroke-width": 1
        }
      })

      if (accepted.length > 0) {
        this.map.fitBounds(bounds, { padding: 60, maxZoom: 15 })
      }
    })

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
