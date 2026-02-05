#!/bin/bash

# --- CONFIGURACIÓN REMOTA (Producción) ---
USER_PROD="dplprod_adrian"
IP_PROD="10.102.25.40"
APP_PATH="/home/dplprod_adrian/Tavelroad_dpl/laravel"

echo "🛫 Conectando con Producción ($IP_PROD)..."

# Todo lo que esté dentro de las comillas se ejecutará en la máquina de producción
ssh -t $USER_PROD@$IP_PROD << EOF
  cd $APP_PATH || { echo "❌ Carpeta no encontrada"; exit 1; }

  echo "🚧 Entrando en modo mantenimiento..."
  php artisan down --retry=15 || echo "⚠️ Ya estaba en mantenimiento"

  echo "📥 Actualizando código desde GitHub..."
  git pull origin main

  echo "📦 Instalando dependencias de Composer..."
  composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

  echo "🗄️ Ejecutando migraciones..."
  # Importante: Esto usa la conexión Postgres que ya configuramos
  php artisan migrate --force

  echo "🧹 Limpiando y optimizando caches..."
  php artisan config:cache
  php artisan route:cache
  php artisan view:cache

  echo "🔑 Asegurando permisos de escritura..."
  # Usamos sudo si es necesario para los permisos de la web
  chmod -R 775 storage bootstrap/cache

  echo "🚀 Saliendo del modo mantenimiento..."
  php artisan up

  echo "✅ ¡Despliegue en Producción finalizado!"
EOF
