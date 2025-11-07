# Usa la imagen oficial
FROM dpage/pgadmin4:latest

# Copiamos el entrypoint personalizado
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponemos (nota: Render inyecta $PORT en runtime)
EXPOSE 80

# Ejecutamos nuestro entrypoint que ajusta el puerto y lanza el original
ENTRYPOINT ["/entrypoint.sh"]

