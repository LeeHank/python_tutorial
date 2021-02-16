# Python Data Types  

## Built-in Data Types  

* python內建的data type，我喜歡把他分成三大類：  
  * 基本款 
  * collections  
  * binary  

### 基本款  
  
* 基本款：  
  * Text:  `str`  
  * Numeric: `int`, `float`, `complex`  
  * Boolean: `bool`  


### collections  

* collections(array):  
  * Sequence: `list`, `tuple`, `range`  
  * mapping: `dict`  
  * set: `set`, `frozenset` 
  
### binary  

* binary types: `bytes`, `bytearray`  

## Getting the data type  

* 用`type()`，可以獲取此variable的類型  

## Setting the specific data type  

* 我們只要在value的前面，加上想宣告的資料類型，就可明確的定義出這種type的value   


```python
# 基本款  
x = str("Hello World")
x = int(20)  
x = float(20.5)  
x = complex(1j)
x = bool(True)

# collections  
x = list(("apple", "banana", "cherry"))
x = tuple(("apple", "banana", "cherry"))
x = range(6)
x = dict(name = "john", age = 36)
x = set(("apple", "banana", "cherry"))
x = frozenset(("apple", "banana", "cherry"))

# binary
x = bytes(5)
x = bytearray(5)
x = memoryview(bytes(5))
```

