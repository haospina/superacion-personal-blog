# deploy.ps1 — Deploy a gh-pages/root sin repos anidados ni publishDir="."
$ErrorActionPreference = "Stop"

Write-Host "🧹 Generando sitio con Hugo en ./public ..."
hugo -D -d public

# Excluir del espejo: tus carpetas/archivos de código que NO deben borrarse
$excludeDirs = @(".git", ".github", "public", "content", "layouts", "themes", "archetypes", "resources", "static", "scripts")
$excludeFiles = @("config.toml","config.yaml","config.yml","deploy.ps1","README.md","LICENSE")

# Construye los argumentos /XD y /XF
$xdArgs = @()
foreach ($d in $excludeDirs) { $xdArgs += @("/XD", $d) }
$xfArgs = @()
foreach ($f in $excludeFiles) { $xfArgs += @("/XF", $f) }

Write-Host "📦 Copiando build a la raíz (gh-pages/root) ..."
# /MIR = espejo; /E = subdirs; excluimos fuente y metadatos para no tocarlos
robocopy "public" "." /MIR /E /NFL /NDL /NJH /NJS /NP $xdArgs $xfArgs | Out-Null

# (Opcional) limpia la carpeta public para que no se acumule
# Remove-Item -Recurse -Force public

# Git commit & push
Write-Host "📌 Preparando commit ..."
git add -A
$ts = Get-Date -Format "yyyy-MM-dd HH:mm"
try {
  git commit -m "🚀 Deploy a gh-pages/root ($ts)" | Out-Null
} catch {
  Write-Host "✔️ Nada nuevo para commitear."
}

Write-Host "⬆️ Haciendo push a origin/gh-pages ..."
# Usa push normal; si está detrás, reintenta con --force-with-lease
$pushOK = $true
try {
  git push origin gh-pages
} catch {
  $pushOK = $false
}
if (-not $pushOK) {
  Write-Host "↪️ Reintentando con --force-with-lease ..."
  git push origin gh-pages --force-with-lease
}

Write-Host "✅ Deploy listo. Revisa GitHub Pages (gh-pages / root)."
