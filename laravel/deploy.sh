#!/bin/bash

# --- CONFIGURACIÓN ---
# El script detecta si está en producción o desarrollo
APP_PATH="/home/dplprod_adrian/Tavelroad_dpl/laravel"

echo "🏁 Iniciando despliegue..."

cd $APP_PATH || { echo "❌ No se encontró la carpeta"; exit 1; }

# 1. Modo mantenimiento
php artisan down --retry=15 || echo "⚠️ Ya estaba en mantenimiento"

# 2. Actualizar código
git pull origin main

# 3. Dependencias de PHP
# Usamos --no-dev para que producción sea más ligero y seguro
composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

# 4. Migraciones (EL PUNTO CRÍTICO)
# --force es obligatorio para que no pida confirmación y se detenga el script
php artisan migrate --force

# 5. Optimización de rendimiento
# Estos comandos combinan toda la configuración en archivos únicos
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 6. Permisos (Aseguramos que storage sea escribible por el servidor web)
chmod -R 775 storage bootstrap/cache

# 7. Salir de mantenimiento
php artisan up

echo "🚀 ¡Despliegue terminado con éxito!"
