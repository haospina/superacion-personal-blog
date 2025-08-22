# deploy.ps1
Write-Host "🚀 Iniciando despliegue con Hugo..."

# 1. Construir el sitio con Hugo
hugo

# 2. Verificar si el build fue exitoso
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al construir el sitio con Hugo."
    exit $LASTEXITCODE
}

# 3. Copiar el archivo CNAME al directorio public/
$CNAME_PATH = "CNAME"
if (Test-Path $CNAME_PATH) {
    Copy-Item $CNAME_PATH -Destination "public/CNAME" -Force
    Write-Host "✅ Archivo CNAME copiado a public/"
} else {
    Write-Host "⚠️ No se encontró el archivo CNAME en la raíz del repo."
}

# 4. Ir al directorio public/ y hacer push a gh-pages
cd public
if (!(Test-Path ".git")) {
    git init
    git checkout -b gh-pages
}

git add -A
git commit -m "Deploy automático $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push -f origin gh-pages

cd ..

Write-Host "✅ Deploy listo. Revisa GitHub Pages (branch gh-pages)."
