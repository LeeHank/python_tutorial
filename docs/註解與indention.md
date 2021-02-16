# 註解與indention  

## 插入註解  

* python的註解和R一樣，都是用井字號，只要記得加空格來維持PEP8代碼風格即可： 


```python
# 有空一格就是好註解  
#沒有空格是爛註解
print("Hello, World!")
```

* 另外，在Python中，如果字串沒有被assign到一個變數，那會自動被忽略。所以，需要多行註解時，可以善用字串寫法:  


```python
"""
This is a comment
written in
more than just one line
"""
print("Hello, World!")
```

## indention  

* 在R或其他語言，經常是用大括號來包住function body，例如：  


```r
my_func = function(x){
  # 有大括號就是放心
  a = x + 1
  return(a)
}
```

* 但在Python都是靠indent:  


```python
def my_func(x):
  # 靠indent來營造出coding block  
  a = x + 1
  return(a)

my_func(4)
#> 5
```

