import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "myMealsSection",
    "myExchangesSection",
    "myMealsButton",
    "myExchangesButton"
  ]

  connect() {
    const section = new URLSearchParams(window.location.search).get("section")
    if (section === "meals") {
      this.showMyMeals()
    } else {
      this.showMyExchanges()
    }
  }

  showMyMeals() {
    this.myMealsSectionTarget.style.display = "block"
    this.myExchangesSectionTarget.style.display = "none"
    this.myMealsButtonTarget.classList.add("active")
    this.myExchangesButtonTarget.classList.remove("active")
  }

  showMyExchanges() {
    this.myMealsSectionTarget.style.display = "none"
    this.myExchangesSectionTarget.style.display = "block"
    this.myExchangesButtonTarget.classList.add("active")
    this.myMealsButtonTarget.classList.remove("active")
  }
}
