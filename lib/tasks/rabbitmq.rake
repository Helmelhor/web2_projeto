namespace :rabbitmq do
  desc "Inicia o consumidor de eventos do Coliseum"
  task listen: :environment do
    require "json"
    require "bunny"

    puts "⏳ Iniciando conexão com RabbitMQ..."

    connection = Bunny.new(
      hostname: ENV.fetch("RABBITMQ_HOST", "localhost"),
      port: ENV.fetch("RABBITMQ_PORT", 5672),
      user: ENV.fetch("RABBITMQ_USER", "guest"),
      pass: ENV.fetch("RABBITMQ_PASSWORD", "guest"),
      # Adicionamos a recuperação automática caso a rede pisque:
      automatically_recover: true,
      network_recovery_interval: 3
    )

    # A Mágica da Paciência (Retry Loop)
    begin
      connection.start
      puts "✅ Conectado ao RabbitMQ com sucesso!"
    rescue Bunny::TCPConnectionFailedForAllHosts, Bunny::TCPConnectionFailed, Errno::ECONNREFUSED => e
      puts "⚠️ RabbitMQ ainda não está pronto. Tentando conectar novamente em 3 segundos..."
      sleep 3
      retry
    end

    channel = connection.create_channel

    # Conecta no MESMO exchange que o Publisher
    exchange = channel.fanout("coliseum.events")

    # Cria uma fila exclusiva e liga ao exchange
    queue = channel.queue("", exclusive: true)
    queue.bind(exchange)

    puts " [*] Aguardando eventos do BasketHub... (Pressione CTRL+C para sair)"

    queue.subscribe(block: true) do |delivery_info, properties, body|
      dados = JSON.parse(body)

      if dados["evento"] == "nova_quadra"
        # Buscamos a quadra no banco
        quadra = Quadra.find(dados["quadra_id"])

        # Renderizamos o HTML parcial da quadra
        html = ApplicationController.render(
          partial: "quadras/quadra",
          locals: { quadra: quadra, current_user: nil }
        )

        puts "\n[NOVA QUADRA] 🏀 Transmitindo quadra '#{quadra.nome}' via ActionCable!"
        ActionCable.server.broadcast("feed_channel", { html: html })
      end
    end
  rescue Interrupt => _
    connection.close
    exit(0)
  end
end
