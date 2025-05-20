import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-display"
export default class extends Controller {
  static targets = [
    "listButton",
    "mapButton",
    "mealList",
    "mealMap"
  ]

  connect() {
  }

  displayMealList() {
    this.listButtonTarget.classList.add('active')
    this.mapButtonTarget.classList.remove('active')
    this.mealListTarget.style.display = 'block'
    this.mealMapTarget.style.display = 'none'
  }

  displayMealMap() {
    this.mapButtonTarget.classList.add('active')
    this.listButtonTarget.classList.remove('active')
    this.mealListTarget.style.display = 'none'
    this.mealMapTarget.style.display = 'block'
  }
}
