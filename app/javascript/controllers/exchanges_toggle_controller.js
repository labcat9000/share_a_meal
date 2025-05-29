import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    currentUrl: String,
    pastUrl: String
  }

  toggle(event) {
    event.preventDefault()
    const view = event.target.dataset.view
    const url = view === "current" ? this.currentUrlValue : this.pastUrlValue

    Turbo.visit(url)
  }
}
