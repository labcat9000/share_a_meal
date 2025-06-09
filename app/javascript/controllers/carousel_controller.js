import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "dot"]

  connect() {
    this.index = 0
    this.total = this.dotTargets.length
    this.container = this.trackTarget.parentElement
    this.updateDots()
    this.attachListeners()
    window.addEventListener("resize", () => this.updateSlide())
  }

  attachListeners() {
    // Touch events
    this.trackTarget.addEventListener("touchstart", this.startTouch.bind(this), { passive: true })
    this.trackTarget.addEventListener("touchmove", this.onTouchMove.bind(this), { passive: true })
    this.trackTarget.addEventListener("touchend", this.endTouch.bind(this))

    // Mouse events (desktop)
    this.trackTarget.addEventListener("mousedown", this.startMouse.bind(this))
    this.trackTarget.addEventListener("mouseup", this.endMouse.bind(this))
  }

  // Touch handling
  startTouch(event) {
    this.startX = event.touches[0].clientX
    this.moved = false
  }

  onTouchMove(event) {
    this.moved = true
  }

  endTouch(event) {
    if (!this.moved) return
    const endX = event.changedTouches[0].clientX
    this.handleSwipe(endX - this.startX)
  }

  // Mouse handling
  startMouse(event) {
    this.startX = event.clientX
  }

  endMouse(event) {
    const endX = event.clientX
    this.handleSwipe(endX - this.startX)
  }

  // Swipe logic
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
    const width = this.container.clientWidth
    this.trackTarget.style.transform = `translateX(-${this.index * width}px)`
    this.updateDots()
  }

  updateDots() {
    this.dotTargets.forEach((dot, i) => {
      dot.style.backgroundColor = i === this.index ? "#000" : "#bbb"
    })
  }
}
