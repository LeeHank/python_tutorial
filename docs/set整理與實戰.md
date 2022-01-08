# set應用實戰  

* set是python內建的一種collection  
* 既然是collection，我們就可以把它當資料庫看，所以會依序介紹作為資料庫最基礎的幾個part：  
  * 如何建立？  
  * 如何增、刪、查、改？  
* 這些基礎會了後，就確認一下是否為mutable物件，來決定如何做copy  
* 接著就開始介紹如何loop他(用for, comprehension)  
* 最後就是補齊這個object還沒介紹到的methods  
* 實戰的部分，就會以"How to..."的方式整理常見的需求  

## 定義set  

* 集合就是只有key，沒有value的dictionary  
* 例如，以下是dictionary  


```python
my_dict = {
  'a': 1,
  'b': 5
}
print(my_dict)
#> {'a': 1, 'b': 5}
```

* 而，以下就是set  


```python
my_set = {'a', 'b'}
print(my_set)
#> {'b', 'a'}
```

* set的特點，其實和dictionary的key的特點一樣(也和數學上的集合的特點一樣)，就是'唯一'和'無序'。  
* 唯一就是key值唯一，你多給他重複的key，他也幫你刪掉。無序就是你每次print的時候，他順序都會亂跳，所以你有不能用index的方法來獲取set裡面的element

## [查]  只能用`for loop`與`in`  

* 因為set又沒有list/tuple的index，也沒有dictionary的key，所以你既不能用`set1[index]`來取資料，也不能用`set1['key']`來取資料  
* 所以，只能做兩件事：  
  * 用for迴圈來loop看看總共有哪些item  
  * 用`in`來確認，你指定的item有沒有在這個set裡面


```python
thisset = {"apple", "banana", "cherry"}

for x in thisset:
  print(x)
#> apple
#> banana
#> cherry
```

* check "banana"是否在這個set中  


```python
thisset = {"apple", "banana", "cherry"}

print("banana" in thisset)
#> True
```

## [改] set無法做修改      

* set無法做修改的原因，是因為他無法取出你指定的那個item，所以他無法像list那樣，用`list1[index] = new_value`，也無法像dictionary那樣，用`dic1['key'] = new_value`來做修改  
* 但set可以做刪除和新增。所以如果一個set是`{"apple", "banana", "orange"}`，那我想把"banana"改成"kiwi"，那就是刪除"banana"，再新增"kiwi"就好  

## [刪] `.remove()`與`.discard()`  

* `.remove()`和`.discard()`的差別，是在remove一個不存在的值時，他會跳error，但discard一個不存在的值時，他就裝沒事而已  


```python
thisset = {"apple", "banana", "cherry"}

thisset.remove("banana")

print(thisset)
#> {'apple', 'cherry'}
```


```python
thisset = {"apple", "banana", "cherry"}

thisset.remove("kiwi")
#> Error in py_call_impl(callable, dots$args, dots$keywords): KeyError: 'kiwi'
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
```


```python
thisset = {"apple", "banana", "cherry"}

thisset.discard("banana")

print(thisset)
#> {'apple', 'cherry'}
```


```python
thisset = {"apple", "banana", "cherry"}

thisset.discard("kiwi")

print(thisset)
#> {'apple', 'banana', 'cherry'}
```

## [增] `.add()`與`.update()`  

### 增加一個item用`.add()`  


```python
thisset = {"apple", "banana", "cherry"}

thisset.add("orange")

print(thisset)
#> {'apple', 'banana', 'orange', 'cherry'}
```


### 增加多個item用`.update()`  


```python
thisset = {"apple", "banana", "cherry"}
tropical = {"pineapple", "mango", "papaya"}

thisset.update(tropical)

print(thisset)
#> {'apple', 'banana', 'pineapple', 'mango', 'papaya', 'cherry'}
```

* 如果update的東西，裡面有和原本重複的值，那就只會留一個，因為set就是unique  


```python
thisset = {"apple", "banana", "cherry"}
tropical = {"apple", "banana", "papaya"}

thisset.update(tropical)

print(thisset)
#> {'apple', 'banana', 'papaya', 'cherry'}
```

## [mutable]  請愛用`.copy()`  

* set也是mutable，所以以下慘劇會重現：    


```python
set1 = {"apple", "banana", "orange"}
set1_copy = set1  

set1_copy.remove("apple")

print(set1_copy)
#> {'banana', 'orange'}
print(set1)
#> {'banana', 'orange'}
```

* 記得用`.copy()`來解決問題  


```python
set1 = {"apple", "banana", "orange"}
set1_copy = set1.copy()  

set1_copy.remove("apple")

print(set1_copy)
#> {'banana', 'orange'}
print(set1)
#> {'apple', 'banana', 'orange'}
```

## [loop] for  

* 這邊就沒什麼，你只能loop他的item:  


```python
set1 = {"apple", "banana", "orange"}
for item in set1:
  print(item)
#> apple
#> banana
#> orange
```

## [loop] comprehension  

* set可以看成簡化版的dictionary，那既然可以做dictionary comprehension，就應該可以做set comprehension  


```python
set1 = {"apple", "banana", "orange"}
set2 = {item for item in set1}

print(set2)
#> {'apple', 'banana', 'orange'}
```



## [特殊技]  集合運算

* set可以做數學上的交集(&)、聯集(|)、差集(-)、補集(^)  


```python
s1 = {1,2,3,4}
s2 = {3,4,5,6}

print(s1 & s2)
#> {3, 4}
print(s1 | s2)
#> {1, 2, 3, 4, 5, 6}
print(s1 - s2) #是s1，但不是s2
#> {1, 2}
print(s1 ^ s2)
#> {1, 2, 5, 6}
```

## [特殊技] 對list取unique  

* 例如我有一個list，我想取出unique的值：  


```python
l = [1,2,3,2,4,5,2]
l_unique = list(set(l))
print(l_unique)
#> [1, 2, 3, 4, 5]
```

## [特殊技] 將字串中unique character轉成list  

* 這招蠻牛的，看一下例子就會了  


```python
my_string = "aabbcdefg"
string_to_set = set(my_string)
print(string_to_set)
#> {'d', 'a', 'g', 'e', 'c', 'b', 'f'}
```


