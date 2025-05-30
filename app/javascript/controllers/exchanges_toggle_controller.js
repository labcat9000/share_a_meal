import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "currentExchangesSection",
    "pastExchangesSection",
    "currentExchangesButton",
    "pastExchangesButton"
  ]

  connect() {
    const section = new URLSearchParams(window.location.search).get("section")
    if (section === "current") {
      this.showCurrentExchanges()
    } else {
      this.showPastExchanges()
    }
  }

  showCurrentExchanges() {
    this.currentExchangesSectionTarget.style.display = "block"
    this.pastExchangesSectionTarget.style.display = "none"
    this.currentExchangesButtonTarget.classList.add("active")
    this.pastExchangesButtonTarget.classList.remove("active")
  }

  showPastExchanges() {
    this.pastExchangesSectionTarget.style.display = "block"
    this.currentExchangesSectionTarget.style.display = "none"
    this.pastExchangesButtonTarget.classList.add("active")
    this.currentExchangesButtonTarget.classList.remove("active")
  }
}
