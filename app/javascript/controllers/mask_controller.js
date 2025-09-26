import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mask"
export default class extends Controller {
  cpf(event) {
    let value = event.target.value
    value = value.replace(/\D/g, "")
    value = value.replace(/(\d{3})(\d)/, "$1.$2")
    value = value.replace(/(\d{3})(\d)/, "$1.$2")
    value = value.replace(/(\d{3})(\d{2,3})$/, "$1-$2")
    event.target.value = value.slice(0, 14)
  }

  phone(event) {
    let value = event.target.value
    value = value.replace(/\D/g, "")
    value = value.replace(/^(\d{2})(\d)/, "($1) $2")
    if (value.length > 13) {
      // Handle 9-digit mobile numbers
      value = value.replace(/(\d{5})(\d)/, "$1-$2")
    } else {
      // Handle 8-digit landlines
      value = value.replace(/(\d{4})(\d)/, "$1-$2")
    }
    event.target.value = value.slice(0, 15)
  }
}