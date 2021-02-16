# boolean整理與實戰  

* boolean就True/False兩種，主要用在條件判斷時使用  
* 雖然只有True/False兩種，聽起來很簡單，但還是蠻多細節可以講的  

## 大部分的value，轉成boolean都是True  

* `str`轉成boolean會是True，除非是空的string  
* `int`, `float`轉成boolean會是True，除非是0  
* `list`, `tuple`, `set`, `dic`轉成boolean都是True，除非是空值  


```python
bool("abc")
#> True
bool(123)
#> True
bool(123.123)
#> True
bool(["apple", "cherry", "banana"])
#> True
```

## 少部分value，轉成boolean會是False  

* 就如同上面的舉例，你是以下三種狀況，那轉成boolean，會是False
  * 沒有值(None)
  * 空值(e.g. "", [], {},...)
  * 0  


```python
example = [
  None, "", [], (), {}, 0
]

for i in example:
  res = bool(i)
  print(f"{i} transform to boolean will be {res}")
#> None transform to boolean will be False
#>  transform to boolean will be False
#> [] transform to boolean will be False
#> () transform to boolean will be False
#> {} transform to boolean will be False
#> 0 transform to boolean will be False
```

## 搭配if statement  

* 如果要做： "if 一個list是空值，我就..."，那可以這樣寫：  


```python
a = []
if not a: # a 是[]時，轉成 boolean 會是False，所以加個not就變True了  
  print("a is empty")  
#> a is empty
```

* 當然，你還是可以用土法煉鋼的寫法，但在Python社群就很少人這樣寫了：  


```python
a = []
if a == []:
  print("a is empty")  
#> a is empty
```

