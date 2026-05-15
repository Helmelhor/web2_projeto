import consumer from "channels/consumer"

consumer.subscriptions.create("FeedChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const feed = document.querySelector(".timeline") // ou o ID da sua lista
    if (feed && data.html) {
      feed.insertAdjacentHTML('afterbegin', data.html)
    }
  }
});
