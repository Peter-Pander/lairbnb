// app/javascript/controllers/datepicker_controller.js
import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      minDate: "today" // only allow today and future dates
    });
  }
}
