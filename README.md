# 🏀 BasketHub

**BasketHub** é uma plataforma web colaborativa projetada para conectar a comunidade de basquete. O sistema permite que os usuários cadastrem, avaliem e descubram quadras de basquete pela cidade, detalhando infraestrutura (tipo de piso, iluminação) e compartilhando fotos e comentários.


## ⚙️ Como executar o projeto localmente

Este projeto foi totalmente dockerizado pensando na facilidade de avaliação. **Não é necessário ter Ruby, PostgreSQL ou RabbitMQ instalados na sua máquina física.**

### 📋 Pré-requisitos
* [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado e em execução.
* [Git](https://git-scm.com/) instalado.

## Passo a Passo

```bash
git clone https://github.com/Helmelhor/web2_projeto.git
```
```bash
cd baskethub
```
```bash
docker-compose up
```

### ⚠️ Atenção Importante (Quebra de Linha LF vs CRLF)
Como a aplicação roda dentro de containers Linux, todos os scripts da pasta `bin/` (especialmente o `bin/docker-entrypoint`) **devem obrigatoriamente utilizar quebras de linha no padrão LF** em vez de CRLF.

## 🚀 Arquitetura e Diferenciais Técnicos

1. **Publisher (App Rails):** Quando um usuário posta uma quadra, o controller salva no PostgreSQL e dispara uma mensagem para um *Message Broker*.
2. **Message Broker (RabbitMQ):** Recebe e enfileira a notificação com alta resiliência.
3. **Subscriber (Worker Background):** Um processo Ruby rodando em segundo plano consome a fila do RabbitMQ, processa o HTML em background e envia para o servidor de WebSockets.


## 🛠️ Tecnologias Utilizadas

* **Backend:** Ruby on Rails
* **Banco de Dados:** PostgreSQL
* **Mensageria:** RabbitMQ
* **Tempo Real:** ActionCable (WebSockets) + Turbo/Stimulus
* **Infraestrutura:** Docker & Docker Compose 



