# deploy.ps1
# Borra docs/, regenera el sitio y sube cambios a GitHub

Write-Host "🧹 Borrando carpeta docs..."
Remove-Item -Recurse -Force .\docs

Write-Host "⚙️ Generando sitio con Hugo..."
hugo -d docs

Write-Host "📦 Agregando cambios a Git..."
git add -A

$commitMessage = "Actualización automática del sitio Hugo"
git commit -m $commitMessage

Write-Host "🚀 Subiendo cambios a GitHub..."
git push origin master

Write-Host "✅ Sitio actualizado con éxito"
