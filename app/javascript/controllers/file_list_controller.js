import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]

  connect() {
    this.files = []
    this.renderPlusBox()
  }

  preview(event) {
    const selectedFiles = Array.from(event.target.files)
    selectedFiles.forEach(file => this.addFile(file))
  }

  addFile(file) {
    if (!this.files.find(f => f.name === file.name)) {
      this.files.push(file)
      this.renderPreview(file)
      this.syncFileInput()
    }
  }

  renderPreview(file) {
    const wrapper = document.createElement("div")
    wrapper.className = "position-relative"
    wrapper.style = "width: 100px; height: 100px; border-radius: 8px; overflow: hidden; box-shadow: 0 0 4px rgba(0,0,0,0.1); margin-bottom: 8px;"

    const img = document.createElement("img")
    img.src = URL.createObjectURL(file)
    img.style = "width: 100%; height: 100%; object-fit: cover;"

    const btn = document.createElement("button")
    btn.type = "button"
    btn.innerText = "✕"
    btn.className = "btn btn-sm btn-danger position-absolute top-0 end-0 d-flex align-items-center justify-content-center rounded-circle"
    btn.style = "width: 20px; height: 20px; font-size: 12px; padding: 0; line-height: 1;"
    btn.addEventListener("click", () => {
      this.removeFile(file.name, wrapper)
    })

    wrapper.appendChild(img)
    wrapper.appendChild(btn)
    this.listTarget.insertBefore(wrapper, this.plusBox)
  }

  renderPlusBox() {
    this.plusBox = document.createElement("div")
    this.plusBox.className = "d-flex align-items-center justify-content-center bg-white border border-secondary-subtle"
    this.plusBox.style = "width: 100px; height: 100px; border-radius: 8px; cursor: pointer; font-size: 32px; font-weight: bold; color: #999; box-shadow: 0 0 4px rgba(0,0,0,0.1);"
    this.plusBox.innerText = "+"
    this.plusBox.addEventListener("click", () => this.inputTarget.click())
    this.listTarget.appendChild(this.plusBox)
  }

  removeFile(name, wrapper) {
    this.files = this.files.filter(f => f.name !== name)
    wrapper.remove()
    this.syncFileInput()
  }

  syncFileInput() {
    const dataTransfer = new DataTransfer()
    this.files.forEach(file => dataTransfer.items.add(file))
    this.inputTarget.files = dataTransfer.files
  }
}
