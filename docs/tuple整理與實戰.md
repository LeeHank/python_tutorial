# tuple整理與實戰  

* tuple是python內建的一種collection  
* 既然是collection，我們就可以把它當資料庫看，所以會依序介紹作為資料庫最基礎的幾個part：  
  * 如何建立？  
  * 如何增、刪、查、改？  
* 這些基礎會了後，就確認一下是否為mutable物件，來決定如何做copy  
* 接著就開始介紹如何loop他(用for, comprehension)  
* 最後就是補齊這個object還沒介紹到的methods  
* 實戰的部分，就會以"How to..."的方式整理常見的需求  

## [建] tuple定義與創建  

* tuple用小括號來創建，例如：  


```python
my_tuple = ("apple", "banana", "cherry")
print(my_tuple)
#> ('apple', 'banana', 'cherry')
print(type(my_tuple))
#> <class 'tuple'>
```

* 特別提醒，如果只有一個元素，那必須加上逗號才會是tuple  


```python
thistuple = ("apple",)
print(type(thistuple))

#NOT a tuple
#> <class 'tuple'>
thistuple = ("apple")
print(type(thistuple))
#> <class 'str'>
```

* tuple的特色是  
  * ordered: 所以他也是用index來取裡面的items  
  * unchangeable: 這是他最大的特色，不可修改。所以你要改裡面的item，或是要新增/刪除item，都是不允許的  
  * allow duplicate: tuple裡面的item可以重複  

## 主要用在保護數據和unpack  

* 已經有了list，為何還要tuple？有以下三個時機用tuple比list好  
  * tuple比list快，所以element爆多時，可以選tuple: tuple會比較快的原因是，他不可修改，所以建立tuple時，會開"一個"大小固定的記憶體空間給他。但如果是建立list，會開"兩個"記憶體空間，一個是給實際的list數據，另一個是拿來當擴展使用的。所以tuple較快，但list較彈性  
  * tuple不可修改，所以比較安全：如果我們寫程式時，有一段資料要重複使用(e.g. 已經設定好的一組黃金參數)，那就傾向用tuple，因為沒有人可以修改他。但如果用list，就很怕出亂子  
  * 寫function時，tuple有unpack的特性，可以unpack a tuple into several variables!先看例子：  



```python
fruits = ("apple", "banana", "cherry")

green, yellow, red = fruits

print(green)
#> apple
print(yellow)
#> banana
print(red)
#> cherry
```

* 這個的好處是，寫function時，要return的東西如果是多個variable，在R就會寫成list，然後之後就要用錢字號去取裡面的每個element。但在python，就喜歡return一個tuple，然後之後用unpack的特性去接這些結果：  


```python
def raise_both(value1, value2):
  """
  Raise value1 to the power of value2
  and vice versa.
  """
  
  new_value1 = value1 ** value2
  new_value2 = value2 ** value1
  
  new_tuple = (new_value1, new_value2)
  
  return new_tuple
```

* 那實際使用這個function時，就會這樣做：  


```python
result1, result2 = raise_both(2,3)
print(result1)
#> 8
print(result2)
#> 9
```

* 最後講一個小trick，如果要assign的variable個數，小於吐出來的value的個數怎辦？  
* 可以把星號加在某個variable前面，就會把剩餘的value全包給那個變數:  


```python
fruits = ("apple", "banana", "cherry", "strawberry", "raspberry")

(green, yellow, *red) = fruits

print(green)
#> apple
print(yellow)
#> banana
print(red)
#> ['cherry', 'strawberry', 'raspberry']
```


## [查] 取用tuple中的item  

* tuple在查的部分，和list是一模一樣的  

### 用`list1[index]`取數據    


```python
thistuple = ("apple", "banana", "cherry")
print(thistuple[1])
#> banana
```

### 用負號往回取  


```python
thistuple = ("apple", "banana", "cherry")
print(thistuple[-1])
#> cherry
```

### 2:5是指取index=2到index=4  


```python
thistuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
print(thistuple[2:5])
#> ('cherry', 'orange', 'kiwi')
```

### 找index用`.index('a')`  


```python
thistuple = ("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")
thistuple.index("banana")
#> 1
```

### 確認每個item有沒有在tuple內也是用`in`  


```python
thistuple = ("apple", "banana", "cherry")
if "apple" in thistuple:
  print("Yes, 'apple' is in the fruits tuple")
#> Yes, 'apple' is in the fruits tuple
```



## [改, 增, 刪] tuple不可修改  

* tuple是unchangable，所以不能改，不能增，也不能刪


```python
x = ("apple", "banana", "cherry")
x[0] = "orange"
#> Error in py_call_impl(callable, dots$args, dots$keywords): TypeError: 'tuple' object does not support item assignment
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
```

* 如果真的要改，就要先轉成list，再轉回tuple，但有點脫褲子放屁拉  


```python
x = ("apple", "banana", "cherry")
y = list(x)
y[0] = "orange"
x = tuple(y)

print(x)
#> ('orange', 'banana', 'cherry')
```
## immutable  

* tuple根本不能改，所以其實不太需要去討論`tuple1_copy = tuple1`之後，改動tuple1_copy會不會影響到tuple1的問題  

## [loop] for回圈    

* loop index  


```python
a_tuple = ("apple", "banana", "cherry")
for index in range(len(a_tuple)): 
    print(index)
#> 0
#> 1
#> 2
```

* loop items  


```python
a_tuple = ("apple", "banana", "cherry")
for item in a_tuple:
    print(item)
#> apple
#> banana
#> cherry
```

* loop index & items  


```python
a_tuple = ("apple", "banana", "cherry")
for index, item in enumerate(a_tuple):
    print("index = ", index, ", number in tuple = ", item)
#> index =  0 , number in tuple =  apple
#> index =  1 , number in tuple =  banana
#> index =  2 , number in tuple =  cherry
```

## [loop] comprehension  

* tuple可以做list comprehension嗎？  
* 之後再釐清，依樣畫葫蘆的結果，竟然是吐一個generator給我！？  


```python
doctor = ['house', 'cuddy', 'chase', 'thirteen', 'wilson']

# 目標：抓出每個element中的第一個字  
doc_tuple = (doc[0] for doc in doctor)

print(doc_tuple)
#> <generator object <genexpr> at 0x11a3f1040>
```

## join兩個tuple用加號  


```python
tuple1 = ("a", "b" , "c")
tuple2 = (1, 2, 3)

tuple3 = tuple1 + tuple2
print(tuple3)
#> ('a', 'b', 'c', 1, 2, 3)
```








