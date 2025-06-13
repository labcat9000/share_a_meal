import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    latitude: Number,
    longitude: Number,
    status: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    const center = [this.longitudeValue, this.latitudeValue]

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center,
      zoom: 13
    })

    this.map.addControl(new mapboxgl.NavigationControl(), "top-left")

    this.map.on("load", () => {
      if (this.statusValue === "accepted") {
        new mapboxgl.Marker()
          .setLngLat(center)
          .addTo(this.map)
      } else {
        this.map.addSource("blurred-meal", {
          type: "geojson",
          data: {
            type: "Feature",
            geometry: {
              type: "Point",
              coordinates: center
            }
          }
        })

        this.map.addLayer({
          id: "blurred-circle",
          type: "circle",
          source: "blurred-meal",
          paint: {
            "circle-radius": {
              stops: [[0, 0], [20, 5000]],
              base: 2
            },
            "circle-color": "#54a23a",
            "circle-opacity": 0.15,
            "circle-stroke-color": "#54a23a",
            "circle-stroke-width": 1
          }
        })
      }
    })
  }
}
