# deploy.ps1 - Despliegue automático a gh-pages
hugo -d public

cd public
git init
git remote add origin https://github.com/haospina/superacion-personal-blog.git
git checkout -b gh-pages
git add .
git commit -m "Deploy automático $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push -f origin gh-pages
cd ..
