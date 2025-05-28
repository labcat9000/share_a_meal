import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]

  connect() {
    this.files = []
  }

  preview(event) {
    const selectedFiles = Array.from(event.target.files)
    selectedFiles.forEach(file => this.addFile(file))
  }

  addFile(file) {
    if (!this.files.find(f => f.name === file.name)) {
      this.files.push(file)
      this.renderFile(file)
      this.syncFileInput()
    }
  }

  renderFile(file) {
    const li = document.createElement("li")
    li.className = "d-flex justify-content-between align-items-center mb-2"
    li.dataset.filename = file.name

    const span = document.createElement("span")
    span.textContent = file.name

    const btn = document.createElement("button")
    btn.type = "button"
    btn.className = "btn btn-sm btn-outline-danger ms-2"
    btn.textContent = "Remove"
    btn.addEventListener("click", () => {
      this.removeFile(file.name, li)
    })

    li.appendChild(span)
    li.appendChild(btn)
    this.listTarget.appendChild(li)
  }

  removeFile(filename, listItem) {
    this.files = this.files.filter(f => f.name !== filename)
    listItem.remove()
    this.syncFileInput()
  }

  syncFileInput() {
    const dataTransfer = new DataTransfer()
    this.files.forEach(file => dataTransfer.items.add(file))
    this.inputTarget.files = dataTransfer.files
  }
}
