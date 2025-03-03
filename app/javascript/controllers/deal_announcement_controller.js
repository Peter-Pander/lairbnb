import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["text"];

  connect() {
    this.displayDeal();
  }

  displayDeal() {
    const deals = [
      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Time is money, friend! 💸 Lock in that deal ‘fore someone else snags it!</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>I got the best deals, anywhere! 🔥 Ya won’t find a price like this again!</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Oi! You booking or just window shopping? 👀 Get it while it's hot! 🔥</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Cha-ching! 💰 Best price ya gonna get—don’t wait ‘til it’s gone! ⏳</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>A deal so good, it’s almost criminal! 😏💰 Hurry up ‘n’ book it!</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Can I interest ya in a limited-time offer? ⏳ ‘Cause this one won’t last! 🚀</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Gold ain't gonna save itself! 🏆 Lock in this steal before it vanishes! ✨</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Fast as lightning ⚡ Book now and secure your spot in the lair!</span>",

      "<strong class='deal-title'>Lower price.</strong> <span class='money-emoji'>💸</span><br>" +
        "<span>Make haste, ya never know when this deal’ll be gone! ⚡ Hurry up ‘n’ get it! 🎯</span>",
    ];

    const dealText = deals[Math.floor(Math.random() * deals.length)];
    if (this.hasTextTarget) {
      this.textTarget.innerHTML = dealText;
    }
  }
}

// Ensure the deal updates on Turbo page load
document.addEventListener("turbo:load", () => {
  const controller = document.querySelector("[data-controller='deal-announcement']");
  if (controller) {
    controller.dispatchEvent(new Event("connect"));
  }
});
