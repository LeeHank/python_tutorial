# int & float 整理與實戰  

## 建立int/float變數  

* int是整數，float是浮點數，當你assign variable時，python基本上就是看你有沒有小數點來做type的判定：  


```python
x = 1
print(type(x))
#> <class 'int'>
y = 1.0
print(type(y))
#> <class 'float'>
```

## 宣告int/float變數  

* 我們可以用casting的方式，來直接標明我的變數類型  


```python
x = int(1)
print(type(x))
#> <class 'int'>
y = float(1.0)
print(type(y))
#> <class 'float'>
```


## 型別轉換  

* 如果把int轉成float，就幫你加小數點：e.g. 1 -> 1.0  
* 如果把float轉成int，會無條件捨去  


```python
x = 1
print(float(x))
#> 1.0
y = 1.6
print(int(y))
#> 1
```
