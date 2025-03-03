import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDatetime", "endDatetime", "guests", "finalPrice", "priceBreakdown"];

  connect() {
    this.pricePerNight = parseFloat(this.element.dataset.reservationPricePerNight); // Get price from data attribute
  }

  calculateTotal() {
    const startDate = this.startDatetimeTarget.value;
    const endDate = this.endDatetimeTarget.value;
    const guests = parseInt(this.guestsTarget.value);

    if (startDate && endDate && guests > 0) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      const timeDifference = end - start;
      const nights = timeDifference / (1000 * 3600 * 24); // Convert ms to days

      if (nights > 0) {
        const totalPrice = this.pricePerNight * nights * guests;

        // Update all elements with the final price
        this.finalPriceTargets.forEach(element => {
          element.innerHTML = `${totalPrice} gold`;
        });

        // Price breakdown
        this.priceBreakdownTarget.innerHTML = `${this.pricePerNight} gold x ${nights} nights x ${guests} guests`;

      } else {
        this.finalPriceTargets.forEach(element => {
          element.innerHTML = `Invalid date range`;
        });
        this.priceBreakdownTarget.innerHTML = ''; // Clear breakdown
      }
    } else {
      this.finalPriceTargets.forEach(element => {
        element.innerHTML = '';
      });
      this.priceBreakdownTarget.innerHTML = ''; // Clear breakdown
    }
  }
}
