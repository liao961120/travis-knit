# Knit Rmd
dir=`ls -d ./*/`
cd $dir
Rscript -e 'rmarkdown::render("index.Rmd")'
cd -

# zip
zip -q -r $dir build

curl -F "file=@build.zip" https://file.io && printf "\nSee the link above of the form https://file.io/xxxxxx\n"
