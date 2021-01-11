install.packages("renv")
install.packages("reticulate")

renv::init()
renv::use_python()
reticulate::py_install("pandas")

# bash
# pip install --upgrade pip
# git init
# git add .
# git commit -m "initial bookdown template."
# 修改bookdown.yml和_output.yml
# git add .
# git commit -m "change bookdown output defaults."
