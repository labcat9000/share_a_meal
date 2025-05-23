import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      const closeBtn = this.element.querySelector('[data-bs-dismiss="alert"]')
      if (closeBtn) {
        closeBtn.click()
      }
    }, 3000)
  }
}
