# deploy.ps1

# Borrar la carpeta docs/
if (Test-Path docs) {
    Remove-Item -Recurse -Force docs
}

# Generar el sitio en docs/
hugo -d docs

# Añadir cambios a Git
git add -A

# Crear commit con la fecha/hora como mensaje
$commitMessage = "Actualización automática: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m "$commitMessage"

# Subir al repositorio
git push origin master
