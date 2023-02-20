import { Controller } from "@hotwired/stimulus"
import debounced from "debounced"

export default class extends Controller {
  initialize() {
    debounced.initialize({input: {wait: 600}});
  }

  urlChange(e) {
    this.element.requestSubmit()
  }
}
