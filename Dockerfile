
FROM dpage/pgadmin4:latest

# Cambiar temporalmente a root para poder cambiar permisos
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# (Opcional) volver al usuario original de la imagen si lo conoces
# USER pgadmin   <-- solo si sabes que ese es el user en la imagen

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
