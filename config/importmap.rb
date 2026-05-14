# Pin npm packages by running ./bin/importmap
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@rails/actioncable", to: "@rails--actioncable.js"

pin_all_from "app/javascript/channels", under: "channels"