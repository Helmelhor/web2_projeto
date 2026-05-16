# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=4.0.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Pasta padrão da aplicação
WORKDIR /rails

# 1. Adicionado 'postgresql-client' e removido 'sqlite3'
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# 2. Removidas as restrições de Produção para permitir rodar em Development
ENV BUNDLE_PATH="/usr/local/bundle" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"



# ESTÁGIO DE BUILD (Onde as gems são compiladas)
FROM base AS build

# 3. Adicionado 'libpq-dev' necessário para instalar a gem do Postgres ('pg')
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips libyaml-dev pkg-config libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Instala as gems (agora incluindo as de development e test)
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile -j 1 --gemfile

# Copia o código da aplicação
COPY . .

# Pré-compila o código para boot mais rápido
RUN bundle exec bootsnap precompile -j 1 app/ lib/

# Ajusta permissões dos executáveis (previne erros de quebra de linha no Windows)
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*



# ESTÁGIO FINAL (A imagem enxuta que vai rodar de fato)
FROM base

# Copia tudo que foi construído no estágio anterior
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# O Entrypoint é o maestro. Ele vai garantir que o banco seja criado antes do servidor subir.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# 4. Alterado para a porta 3000, padrão do desenvolvimento Rails
EXPOSE 3000

# 5. Comando simples e direto para iniciar o Puma
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]