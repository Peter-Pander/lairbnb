import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput"];

  // Triggered when the user clicks the "Edit" button.
  editPhoto() {
    this.fileInputTarget.click();
  }

  // Triggered when a file is selected.
  upload() {
    // Automatically submit the form when a file is chosen.
    this.fileInputTarget.closest("form").submit();
  }
}
