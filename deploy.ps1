# deploy.ps1
# Script de despliegue para Hugo + GitHub Pages (rama gh-pages)

Write-Host "🚀 Iniciando proceso de deploy..." -ForegroundColor Cyan

# 1. Generar el sitio con Hugo
Write-Host "📦 Generando sitio con Hugo..."
hugo

# 2. Verificar que la carpeta public exista
if (!(Test-Path "public")) {
    Write-Host "❌ ERROR: No se encontró la carpeta 'public'. Revisa la compilación de Hugo." -ForegroundColor Red
    exit 1
}

# 3. Asegurar que el archivo CNAME esté dentro de public/
$customDomain = "www-haosp.org"
$CNAMEPath = "public/CNAME"

if (!(Test-Path $CNAMEPath)) {
    Write-Host "📝 Creando archivo CNAME con el dominio: $customDomain"
    Set-Content -Path $CNAMEPath -Value $customDomain
} else {
    Write-Host "✅ Archivo CNAME ya existe en public/"
}

# 4. Entrar a carpeta public
Set-Location public

# 5. Configuración para evitar advertencias LF/CRLF en Windows
git config core.autocrlf false

# 6. Agregar, commitear y pushear
Write-Host "📡 Subiendo cambios a gh-pages..."
git add -A
git commit -m "🚀 Deploy automático $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push -f origin gh-pages

# 7. Volver al directorio raíz
Set-Location ..

Write-Host "✅ Deploy completo. Revisa tu sitio en GitHub Pages." -ForegroundColor Green
