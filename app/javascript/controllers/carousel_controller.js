import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "dot"]

  connect() {
    this.index = 0
    this.total = this.dotTargets.length
    this.updateDots()

    console.log("Carousel connected")
    console.log("Total dots:", this.total)

    // Mobile
    this.trackTarget.addEventListener("touchstart", this.startTouch.bind(this))
    this.trackTarget.addEventListener("touchend", this.endTouch.bind(this))

    // Desktop
    this.trackTarget.addEventListener("mousedown", this.startMouse.bind(this))
    this.trackTarget.addEventListener("mouseup", this.endMouse.bind(this))
  }

  startTouch(event) {
    this.startX = event.changedTouches[0].clientX
  }

  endTouch(event) {
    const endX = event.changedTouches[0].clientX
    this.handleSwipe(endX - this.startX)
  }

  startMouse(event) {
    this.startX = event.clientX
  }

  endMouse(event) {
    const endX = event.clientX
    this.handleSwipe(endX - this.startX)
  }

  handleSwipe(diff) {
    if (Math.abs(diff) > 40) {
      diff < 0 ? this.next() : this.prev()
    }
  }

  next() {
    if (this.index < this.total - 1) {
      this.index++
      this.updateSlide()
    }
  }

  prev() {
    if (this.index > 0) {
      this.index--
      this.updateSlide()
    }
  }

  updateSlide() {
    const offset = this.index * this.trackTarget.offsetWidth
    this.trackTarget.style.transform = `translateX(-${offset}px)`
    this.updateDots()
  }

  updateDots() {
    this.dotTargets.forEach((dot, i) => {
      dot.style.backgroundColor = i === this.index ? "#000" : "#bbb"
    })
  }
}
