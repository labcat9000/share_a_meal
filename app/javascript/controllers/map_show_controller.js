import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = { apiKey: String }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: "show-map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: [-73.5673, 45.5019],
      zoom: 13
    })

    this.map.addControl(new mapboxgl.NavigationControl(), 'top-left')
  }
}
