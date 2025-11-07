#!/bin/sh
set -e

# Forzar a escuchar en todas las interfaces
export PGADMIN_LISTEN_ADDRESS="${PGADMIN_LISTEN_ADDRESS:-0.0.0.0}"

# Usar el puerto que Render inyecta; si no existe, usar 8080 como fallback
# Render define la variable PORT en tiempo de ejecución.
export PGADMIN_LISTEN_PORT="${PORT:-8080}"

echo "Iniciando pgAdmin en ${PGADMIN_LISTEN_ADDRESS}:${PGADMIN_LISTEN_PORT}"

# Si existe el entrypoint original, lo ejecutamos (intentar mantener comportamiento original)
if [ -x "/entrypoint.sh.orig" ]; then
  exec /entrypoint.sh.orig
fi

# Si no hay entrypoint.original (varía entre versiones), arrancamos pgAdmin directamente.
# Intentamos ejecutar el script de arranque conocido; si falla, mostramos el error para depuración.
if command -v python >/dev/null 2>&1; then
  # Intentamos localizar run_pgadmin.py en rutas típicas
  if [ -f /usr/local/lib/python3.*/run_pgadmin.py ] 2>/dev/null; then
    exec python /usr/local/lib/python3.*/run_pgadmin.py --port="$PGADMIN_LISTEN_PORT"
  fi

  # Fallback: arrancar la instancia por defecto (la imagen oficial normalmente usa /entrypoint.sh)
  if [ -x "/entrypoint.sh" ]; then
    exec /entrypoint.sh
  fi
fi

echo "No se pudo arrancar pgAdmin: no se encontró script de inicio. Revisa la imagen base."
exec sh

