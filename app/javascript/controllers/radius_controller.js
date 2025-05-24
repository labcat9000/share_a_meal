import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["radiusValue"]

  updateDisplay(event) {

    this.radiusValueTarget.innerText = event.target.value
    this.setGeolocation()
  }

  setGeolocation() {
    const latInput = document.getElementById("radius-lat")
    const lngInput = document.getElementById("radius-lng")

    if (!latInput.value || !lngInput.value) {
      navigator.geolocation.getCurrentPosition(position => {
        latInput.value = position.coords.latitude
        lngInput.value = position.coords.longitude
      }, () => {
        alert("Location access is needed to apply the radius filter.")
      })
    }
  }
}
