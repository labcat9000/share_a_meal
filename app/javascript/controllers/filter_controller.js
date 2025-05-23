import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  connect() {
    console.log("✅ FilterController connected")
  }

  toggle() {
    console.log("🔁 toggle() fired")
    if (this.hasPanelTarget) {
      const isHidden = this.panelTarget.hasAttribute("hidden")
      if (isHidden) {
        this.panelTarget.removeAttribute("hidden")
      } else {
        this.panelTarget.setAttribute("hidden", "")
      }
    } else {
      console.warn("⚠️ panelTarget not found")
    }
  }
}
