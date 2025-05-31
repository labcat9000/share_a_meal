import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    console.log("✅ ProfilePhotoController connected")
  }

  previewPhoto(event) {
    const file = event.target.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = () => {
      this.previewTarget.src = reader.result
    }
    reader.readAsDataURL(file)
  }
}
