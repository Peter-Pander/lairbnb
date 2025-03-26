// app/javascript/controllers/photo_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput"]

  editPhoto() {
    this.fileInputTarget.click();
  }
}
