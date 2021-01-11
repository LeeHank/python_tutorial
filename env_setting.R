install.packages("renv")
install.packages("reticulate")

renv::init()
renv::use_python()
reticulate::py_install("pandas")

# bash
# pip install --upgrade pip
