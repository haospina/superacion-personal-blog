hugo
cd public
git init
git remote add origin https://github.com/haospina/superacion-personal-blog.git
git checkout -b gh-pages
git add .
git commit -m "Publicación inicial del blog de superación personal"
git push -f origin gh-pages
cd ..
