import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  connect() {
    console.log("✅ FilterController connected")
  }

  toggle() {
    console.log("🔁 toggle() fired")
    this.panelTarget.hidden = !this.panelTarget.hidden
  }
}
