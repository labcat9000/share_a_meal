import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.clickOutside = (e) => {
      if (!this.element.contains(e.target)) {
        this.menuTarget.style.display = "none"
      }
    }
    document.addEventListener("click", this.clickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside)
  }

  toggleMenu() {
    const isVisible = this.menuTarget.style.display === "block"
    this.menuTarget.style.display = isVisible ? "none" : "block"
  }
}
