import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    console.log("Conectado ao canal")
  },

  received(data) {
    console.log("Mensagem recebida:", data)
  }
})