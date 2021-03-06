# flexible arguments  

## `*args`  

* `*args`是flexible arguments的縮寫，星號就把它翻譯成flexible就對了  
* 他的意思是，你可以很彈性的，要丟幾個argument進來，就丟幾個進來。  
* 舉例來說，我想寫一個加總的function，user丟3個數字進來，我就幫他加總3個，user丟9個數字進來，我就幫他加總9個，所以其實一開始我沒辦法訂好我的function要幾個參數，那我就把參數名稱定義成`*args`，來代表user想丟幾個進來都可以(事實上，只要星號開頭即可，星號後你要寫啥都沒關係，例如`*a`, `*abcd`都可以，因為星號就代表flexible，只是習慣上大家喜歡寫`*args`，因為照字面意義就知道他是flexible arguments)  
* 一旦你把參數定成`*args`，它吃進function後，就會先把這堆args串成list，並命名為args，所以在你的function內，可以調用`args`這個object\
* 直接看例子：


```python
def add_all(*args):
  """Sum all values in *args together."""
  
  ### Initialize sum
  sum_all = 0
  
  # Accumulate the sum
  for num in args: # args就是把user丟的所有arguments串成一個list，讓你使用
    sum_all = sum_all + num
  
  return sum_all

print(add_all(1,2,3))
#> 6
print(add_all(1,2,3,4,5))
#> 15
```

## `**kwargs`  

* `**kwargs`是flexible keyword arguments 的縮寫  
* 剛剛的`*args`，都是直接丟argument進來，沒有寫明他是哪個參數，而`**kwargs`，就會寫成key-value pair的輸入  
* 也因為現在的input都是key-value pair了，所以python會把user丟進來的東西，先存成`kwargs`這個dictionary，然後我們再用這個dictionary來工作：  


```python
def print_all(**kwargs):
  """Print out key-value pairs in **kwargs."""
  
  # Print out the key-value pairs
  for key, value in kwargs.items():
    print(key + ": " + value)
    
print_all(
  name = "Hank Lee", 
  job = "Data Scientist", 
  height = "184", 
  weight = "80"
)
#> name: Hank Lee
#> job: Data Scientist
#> height: 184
#> weight: 80
```

* 如果今天定義的是：`**haha`，那dictionary就會存在`haha`裡  

### 使用時機  

* `**kwargs`其實就類比於R的`...`參數，他特別適用在，你的function中要去call別的function，但不想逐一寫下別的function的arguments  
* 例如，我先定義一個function叫`my_sum`  


```python
def my_sum(a, b):
  return(a+b)
```

* 那我如果現在定義一個新的function，叫`conditional_sum`，要給他一個參數x，如果x是True，我才要做sum:  


```python
def conditional_sum(x, **kwargs):
  if x:
    return(my_sum(**kwargs))
  else:
    return("do not calculate")
  
print(conditional_sum(x = True, a = 3, b = 5))
#> 8
print(conditional_sum(x = False, a = 3, b = 5))
#> do not calculate
```

* 特別注意的是，`**kwargs`一定要放在arguments的最後面，如果寫：`def conditional_sum(**kwargs, x)`，那會直接error給你看


