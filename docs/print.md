# print  

* `print()`雖然很簡單，但有一些我原本不清楚的東西，所以整理一下  

## print可以放多個element進去  

* 例如：  


```python
a = "number"
b = 123
print(a, b, "cool")
#> number 123 cool
```

* 可以發現，他不同的element間，用空格幫你隔開。這個空格是預設的，可以改。  

## 用`sep=`來改間隔  

* 看一下help文件(`?print`)，可以發現有`sep = ' '`這個argument，預設值是空格。所以改一下就可以換了  


```python
a = "number"
b = 123
print(a, b, "cool", sep = "++")
#> number++123++cool
```



