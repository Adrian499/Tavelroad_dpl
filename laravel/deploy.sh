#!/bin/bash
# --- CONFIGURACIÓN ---
USER_PROD="dplprod_adrian"
IP_PROD="10.102.25.40"
APP_PATH="/home/dplprod_adrian/Tavelroad_dpl/laravel"
FECHA=$(date +"%Y-%m-%d %H:%M:%S")

echo "💻 --- TAREAS EN LOCAL ---"

# 1. Generar requirements.txt si tienes el entorno virtual activo
if [ -d "travelroad" ] || [ -d "venv" ]; then
    echo "📄 Actualizando lista de requisitos Python..."
    pip freeze > requirements.txt
fi

# 2. Add manual "a dedillo" de archivos necesarios
echo "📝 Preparando archivos para commit..."
git add app/ bootstrap/ config/ database/ public/ resources/ routes/ tests/
git add artisan composer.json composer.lock package.json phpunit.xml vite.config.js README.md .editorconfig .gitattributes .gitignore deploy.sh
# NOTA: No añadimos .env, vendor, storage ni carpetas de venv

# 3. Commit con fecha y hora
git commit -m "Deploy: $FECHA"

# 4. Push a GitHub
echo "📤 Subiendo a GitHub..."
git push origin main

echo "🛫 --- CONECTANDO CON PRODUCCIÓN ($IP_PROD) ---"

ssh -t $USER_PROD@$IP_PROD << EOF
  cd $APP_PATH || { echo "❌ Carpeta no encontrada"; exit 1; }

  echo "📥 Actualizando código..."
  git pull origin main

  echo "🐍 Refrescando Entorno Virtual..."
  # Borramos y recreamos para asegurar limpieza total
  rm -rf venv_prod
  python3 -m venv venv_prod
  source venv_prod/bin/activate
  
  if [ -f "requirements.txt" ]; then
    pip install --upgrade pip
    pip install -r requirements.txt
  fi

  echo "🐘 Actualizando Laravel..."
  # Instalamos dependencias de PHP sin las de desarrollo
  composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

  echo "🧹 Limpiando cachés de Laravel..."
  php artisan optimize:clear
  php artisan config:cache
  php artisan route:cache
  php artisan view:cache

  echo "🚀 Proceso en producción terminado."
EOF

echo "✅ ¡Todo listo! Despliegue finalizado el $FECHA"
