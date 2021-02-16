# Conditional Operators    

* 可以製作出True/False結果的operations有很多，這邊整理一下：  

### `==`, `!=`, `>=`, `<=`  

* 這些operator，我們稱為comparison operators，適用於數值型資料：      

* 比大小：  `a == b`, `a != b`, `a < b`, `a <= b`, `a > b`, `a >=b`  
* 餘數類： `a % 3 == 0`  
* 只想看商： `a // 3 == 1`  


```python
a = 33
b = 200
if b > a:
  print("b is greater than a")
#> b is greater than a
```

### `and`, `or`, `not`  

* 這種operator，我們稱為logical operators，適用於連接多個condition  
* logical operators就是 `and`, `or`, `not`，對應到R的`&`, `|`, `!`  


```python
a = 200
b = 33
c = 500
if a > b and c > a:
  print("Both conditions are True")
#> Both conditions are True
if a > b or a > c:
  print("At least one of the conditions is True")
#> At least one of the conditions is True
if not(b > a):
  print("a is greater or equal to b")
#> a is greater or equal to b
```

### `in`, `not in`  

* 這種operator稱為membership operator，適用於判斷某個item是否是別人的子集  
* `x in y`, `x not in y`  

### `is`, `is not`      

* 這種operator，我們稱為identity operator，適用於判斷資料是不是某種資料類型，或是兩個object是否相同    
* 看x和y是否為相同的object，可以用 `x is y`  


