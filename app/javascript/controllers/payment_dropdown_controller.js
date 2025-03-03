import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];

  connect() {
    console.log("PaymentDropdownController connected");
  }

  toggleDropdown(event) {
    event.stopPropagation(); // Prevents event bubbling issues
    this.menuTarget.classList.toggle("show");
  }

  selectPaymentMethod(event) {
    const item = event.currentTarget; // The clicked element
    const value = item.getAttribute("data-value");
    const iconHTML = item.querySelector("i").outerHTML;
    const text = item.innerText.trim();

    // Update the button with the selected payment method
    this.buttonTarget.innerHTML = `${iconHTML} ${text}`;

    // Close the dropdown
    this.menuTarget.classList.remove("show");
  }

  closeDropdown(event) {
    if (this.hasMenuTarget && !this.element.contains(event.target)) {
      this.menuTarget.classList.remove("show");
    }
  }
}
