import consumer from "./consumer"

consumer.subscriptions.create("RatesChannel", {
  received(data) {
    this.updateRates(data)
  },

  updateRates(data) {
    const element = document.querySelector("[data-channel='rates']")
    element.textContent = data
  }
});
