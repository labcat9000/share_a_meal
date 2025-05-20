import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["map"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [-73.5673, 45.5019],
      zoom: 13
    })

    this.map.addControl(new mapboxgl.NavigationControl(), 'top-left')
  }

  locatePosition() {
    navigator.geolocation.getCurrentPosition(position => {
    const lng = position.coords.longitude;
    const lat = position.coords.latitude;
    this.map.flyTo({ center: [lng, lat], zoom: 14 });
    new mapboxgl.Marker({ color: "#d00" })
      .setLngLat([lng, lat])
      .addTo(this.map);
  })
  }
}
