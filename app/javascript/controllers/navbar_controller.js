import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggleMenu() {
    console.log("click")
    this.menuTarget.classList.toggle("hidden")
  }
}
