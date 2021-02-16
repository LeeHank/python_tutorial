# dictionary整理與實戰  

* dictionary是python內建的一種collection  
* 既然是collection，我們就可以把它當資料庫看，所以會依序介紹作為資料庫最基礎的幾個part：  
  * 如何建立？  
  * 如何增、刪、查、改？  
* 這些基礎會了後，就確認一下是否為mutable物件，來決定如何做copy  
* 接著就開始介紹如何loop他(用for, comprehension)  
* 最後就是補齊這個object還沒介紹到的methods  
* 實戰的部分，就會以"How to..."的方式整理常見的需求  

## dict的定義  

* dictionary就是JSON的key-value pair資料表示法(也可想成R的list)  
* dictionary裡面的每個element，我們仍然叫他"item"。所以一個item，就是一組key-value pair  


```python
my_dict = {
  "name": "Hank",
  "id": 19002329,
  "dept": "AW0010",
  "dog": True
}

print(my_dict)
#> {'name': 'Hank', 'id': 19002329, 'dept': 'AW0010', 'dog': True}
print(type(my_dict))
#> <class 'dict'>
```

* dictionary的特性:  
  * ordered: 在python 3.7以後，dictionary是ordered; 在python 3.6以前，dictionary是unordered。事實上，我還是傾向將dict看成無順序的，因為我們取用裡面的資料還是用key，不是用座號(index)  
  * changeable: 可以改裡面的內容，可以增加，可以刪除  
  * does not allow duplicates  

* dictionary和list的差別在於：  
  1. dictionary用 {}表示，list用[]表示  
  2. dictionary沒有順序性，list有  
  3. dictionary一定是key-value的pair，他是index by key(所以你要select他的element，是輸入key); list是index by number(所以你要select他的element，是輸入index number)    
  4. dictionary的key是immutable，value是mutable，而list全都是mutable   

## [建] dict的創建  

### 直接用{}  

* 創建dictionary時，key必須是immutable，所以key可以是int, string, tupple，但key不可以是list這種mutable  


```python
a = {
        1: 'a',
        2: 'b',
        '3': 'c',
        (2,3,4): 'haha'
}
a
#> {1: 'a', 2: 'b', '3': 'c', (2, 3, 4): 'haha'}
```


```python
b = {
        [2,3,4]: 'haha',
        'two': 2
}
#> Error in py_call_impl(callable, dots$args, dots$keywords): TypeError: unhashable type: 'list'
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
b
#> Error in py_call_impl(callable, dots$args, dots$keywords): NameError: name 'b' is not defined
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
```

### 用`dict(a=2, b="haha")`來建立  

* 此外，我們可以用`dict()`來創建空字典(初始化字典)  


```python
d = dict()
print(d)
#> {}
```


```python
d = dict(a=2, b=3, c="0")
d
#> {'a': 2, 'b': 3, 'c': '0'}
```

* 可以看到，這種寫法就和R的 `list(a=2, b=3, c="0")`一模一樣了  

### 用`dict(iterable_pair)`來創建  

* 我們可以給`dict()`一個iterable物件，然後這個物件裡都是一個一個pair  
* 舉例來說這樣：  


```python
x = [['a', 1],['b',2]] #x是list，為iterable，裡面的每個element，都是個pair
c2 = dict(x)
print(c2)
#> {'a': 1, 'b': 2}
```

* 那除了用list這種iterable，我們其實更喜歡用tuple，例如這樣： 


```python
y = (('a', 1),('b',2)) #x是tuple，為iterable，且裡面的每個element，都是個pair
c3 = dict(y)
print(c3)
#> {'a': 1, 'b': 2}
```

* 有了這兩個基礎後，就可以來學用zip來建立字典了  
* 先來看看zip是什麼


```python
x = [1, 2, 3, 4]
y = ['a', 'b', 'c', 'd']
for i in zip(y,x):
        print(i)
#> ('a', 1)
#> ('b', 2)
#> ('c', 3)
#> ('d', 4)
```

* 水喔，所以可以猜測，`zip(y,x)`的結果，應該就是[('a', 1), ('b', 2), ('c', 3), ('d', 4)]這種iterable object    
* 那所以，我如果想要建立dictionary，就可以： 


```python
dict(zip(y,x))
#> {'a': 1, 'b': 2, 'c': 3, 'd': 4}
```

* 其實，最重要的重點倒不是zip，而是要學會將pair資料轉成dictionary(用`dict()`)  
* 例如，以後看到下面這種資料結構就不要怕，一秒轉成dictionary  


```python
tup = (
        ("li", 90),
        ("wang", 100),
        ("cheng", 73),
        ("chen", 44)
)
dict(tup)
#> {'li': 90, 'wang': 100, 'cheng': 73, 'chen': 44}
```


## [查] 用`d.keys()`, `d.values()`, `d.items()`查詢  

### `.keys()`可以得到最外層的所有key值  

* 只有一層的dictionary，不易外的就是給我他的key值


```python
d = dict(a=2, b=3, c="0")
print(d.keys())
#> dict_keys(['a', 'b', 'c'])
```

* 但像這種nested dictionary，他只會給我最外層的key值  


```python
tt = {
        1: {
                2: {},
                3: {}
        },
        4: {
            5:{
                    6:{},
                    7:{}
            }    
        }
}
tt
#> {1: {2: {}, 3: {}}, 4: {5: {6: {}, 7: {}}}}
```


```python
print(tt.keys())
#> dict_keys([1, 4])
```

### `.values()`可以得到所有value  

* 對於一層的dictionary，不意外的得到所有values


```python
d = dict(a=2, b=3, c="0")
print(d.values())
#> dict_values([2, 3, '0'])
```

* 對於nested dictionary，他就是print出第二層的東西而已(因為第二層就是第一層的value)


```python
print(tt.values())
#> dict_values([{2: {}, 3: {}}, {5: {6: {}, 7: {}}}])
```

### `.items()`可以得到(key,value)的tupple  

* dictionary裡面的每個element，我們叫他item。一個item，就是一個key-value pair  
* 所以，不意外的，用`.items()`可以得到這組pair


```python
d = dict(a=2, b=3, c="0")
print(d.items())
#> dict_items([('a', 2), ('b', 3), ('c', '0')])
```


## [查] 用`d.get("key")`來取用dict裡面的item  

* 通常我們在取用dictionary裡面的item時，我們都是給key，求value  (因為key是唯一值)，不太會，給value，求key(因為value不唯一)  
* 那通常都是先學到用`d['key']`來獲取value，用 `d['new_key'] = new_value`來修改值  
* 但這邊衍伸兩個重點  
  * 實務上，不會用`d['key']`來獲取value，而是用`d.get('key')`來獲取value，理由等下說明  
  * 既然可用`d['new_key'] = new_value`來更改dictionary，表示dictionary也是mutable，所以他不能當另一個字典的key。例如，你不可寫`e = {d: 'haha'}`，因為d現在是mutable object了  

* 現在先來講第一個重點，`.get`的運用  
* 假設我們現在創建一個dictionary  


```python
d = {
        "name": "Hank",
        "ok": "no problem"
}
d
#> {'name': 'Hank', 'ok': 'no problem'}
```

* 那我想獲取name所對應的value，傳統上就會這樣寫  


```python
d['name']
#> 'Hank'
```

* 看起來沒問題。但如果今天我手殘，打成'Name"，那就會報error  


```python
d['Name']
#> Error in py_call_impl(callable, dots$args, dots$keywords): KeyError: 'Name'
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
```

* 這在運行程式時，是一個困擾，因為有時候我們不確定有哪些key，但我就都想try try看，那一error程式就停了  
* 所以，用`.get('key')`時，有抓到的，他會回傳value，沒抓到的，他會回傳None(注意，None是python一個特殊的type，可以想成R的NA這種特殊type)  


```python
print(d.get('name'))
#> Hank
print(d.get('Name'))
#> None
```

## [改] 修改dict裡面的item  

* 要改dictionary裡面的值，可以指定key來改：  


```python
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict["year"] = 2018

print(thisdict)
#> {'brand': 'Ford', 'model': 'Mustang', 'year': 2018}
```

* 也可以用`.update()`的方法，覆蓋過去  


```python
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict.update({"year": 2020})

print(thisdict)
#> {'brand': 'Ford', 'model': 'Mustang', 'year': 2020}
```

## [增] 增加dict的item  

### `d["new_key"] = new_value`  

* 就像剛剛的修改一樣，我們可以指定"新的key"，來做到新增  


```python
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
thisdict["color"] = "red"

print(thisdict)
#> {'brand': 'Ford', 'model': 'Mustang', 'year': 1964, 'color': 'red'}
```


### `.update()`可以合併2個字典  

* 或是，用`.update()`，直接合併新的資料進來  


```python
a = {
        1: 1,
        2: 2
}
b = {
        3: 3,
        4: 4
}
a.update(b)
print(a)
#> {1: 1, 2: 2, 3: 3, 4: 4}
```

* 如果update中的字典，和之前的字典有重複的key，那會直接覆蓋過去(所以，就是做到修改)  


```python
a = {
        1: 1,
        2: 2
}
b = {
        1: 3,
        4: 4
}
a.update(b)
print(a)
#> {1: 3, 2: 2, 4: 4}
```

### `{**d1, **d2, **d3}`合併多個字典  

* 當我們有多個字典時，當然還是可用`.update()`來兩倆合併，但有點笨：  


```python
d1 = {'name': 'Python', 'age': 27}
d2 = {'version': 3.6, 'platform': 'Mac'}
d3 = {'size': '59MB'}

d1.update(d2)
d1.update(d3)
print(d1)
#> {'name': 'Python', 'age': 27, 'version': 3.6, 'platform': 'Mac', 'size': '59MB'}
```

* 比較好的作法是這樣：  


```python
d1 = {'name': 'Python', 'age': 27}
d2 = {'version': 3.6, 'platform': 'Mac'}
d3 = {'size': '59MB'}
{**d1, **d2, **d3}
#> {'name': 'Python', 'age': 27, 'version': 3.6, 'platform': 'Mac', 'size': '59MB'}
```

## [刪] 刪除dict的item  

### `.pop('key')`會把選定的key整個砍掉，並把對應的value丟出來  


```python
b = {
        1: 1,
        2: 2,
        3: 3
}
c = b.pop(3)
print(c)
#> 3
print(b)
#> {1: 1, 2: 2}
```

### `del d['key']`會刪到這組item  


```python
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}

del thisdict["model"]

print(thisdict)
#> {'brand': 'Ford', 'year': 1964}
```

## [mutable] copy  

* 字典也是mutable，所以不能用`dict_copy = dict`這種方式做複製，因為這樣又會出現改一邊，另一邊跟著改的窘境  
* 所以，作法一樣，用`dict_copy = dict.copy()`這種方法來做  


```python
thisdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
mydict = thisdict.copy()
print(mydict)
#> {'brand': 'Ford', 'model': 'Mustang', 'year': 1964}
```

## [loop] for迴圈  

* 剛剛已經學過，如果一個字典的object叫d，那  
  * d.keys(): 可以得到所有的key  
  * d.values(): 可以得到所有的value  
  * d.items(): 可以得到所有的(key, value)所成的tuple  
* 那迴圈時，就可以善用這三招  


```python
d = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3'
}
print(d)
#> {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'}
```

### loop over keys  


```python
for key in d.keys():
  print(key)
#> key1
#> key2
#> key3
```

### loop over values  


```python
for value in d.values():
  print(value)
#> value1
#> value2
#> value3
```

### loop over (key, value)


```python
for key, value in d.items():
  print(key + " -- " + str(value))
#> key1 -- value1
#> key2 -- value2
#> key3 -- value3
```

## [loop] dictionary comprehension  

* 假設，我今天想用for迴圈來做出一個字典，做法如下


```python
a = [1, 2, 3, 4, 5]
b = {}
for item in a:
        b[str(item)] = item
print(b)
#> {'1': 1, '2': 2, '3': 3, '4': 4, '5': 5}
```

* 那dictionary comprehension，就是較簡潔的寫法：  


```python
c = {str(item): item for item in a}
print(c)
#> {'1': 1, '2': 2, '3': 3, '4': 4, '5': 5}
```

* 事實上，除了寫法簡潔，performance也快很多  


## 如何安全的訪問字典  

* 這邊文長，重點也不多(就是推廣用`.get()`而已)，所以要不要讀都沒差  
* 在python中，如果我們想獲取某個key的value，但key又不小心key錯，或此key不在這個dictionary裡面時，會報error:  


```python
d = {
  'name': 'python',
  'age': 27,
  'version': 3.7
}
print(d['name'])
#> python
print(d['nam'])
#> Error in py_call_impl(callable, dots$args, dots$keywords): KeyError: 'nam'
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
```

* 那處理這種問題的方法，有三種：  

### 自己寫條件判斷  

* 這是最hardcore的寫法，很常出現在非python族群的人會寫的內容：  


```python
def safe_get(my_key, my_dic):
  if my_key in my_dic:
    return(my_dic[my_key])
  else:
    return('error for key')

print(safe_get('name', d))
#> python
print(safe_get('nam', d))
#> error for key
```

### 愛用`.get()`  

* 其實你用`.get()`，就是幫你做到上面這件事  
* 當key值不在原本的dictionary裡面，預設是return `None`，那你也可以改  


```python
res = d.get("nam")
print(res is None)
#> True
res = d.get("nam", "error for key")
print(res)
#> error for key
```

### 改用`defaultdict`這種type  

* 我們可以改用這種type並事先定義好，找不到key的處理方式:  


```python
from collections import defaultdict  
d_new = defaultdict(lambda: "error for key", d)
d_new['nam']
#> 'error for key'
```

* `defaultdict`的第一個argument，就是告訴他，key不在此dictionary時，要return什麼出來  


## How to...  

### 如何將字典按照key/value大小排序  

* 假設現在有一個字典如下：  


```python
d = {
        'zhao': 68,
        'qian': 80,
        'sun': 72,
        'li': 90,
        'zhou': 83
}
```

* 可以把這個字典，想成人名和考試成績的對應  
* 然後，我想照value(考試成績)由高到低排序  
* 那做法上，會先用`.items()`來做出(key,value) pair，然後再做排序  
* 先看一下d.items()長怎樣：


```python
print(d.items())
#> dict_items([('zhao', 68), ('qian', 80), ('sun', 72), ('li', 90), ('zhou', 83)])
print(type(d.items()))
#> <class 'dict_items'>
```

* 可以得知，這是一個iterable object，外觀看起來像list，裡面每個element是key-value pair tuple  
* 但他真實的type不是list，是dict_items  
* 我們可以選擇用`sorted(iterable, key)`這種方式做排序，或把它轉成list後，用`.sort(key)`來做排序  

#### 用通用版的function: `sorted()`  


```python
sorted(
        d.items(), # 我要將此iterable做排序
        key = lambda x: x[1] # 怎麼排？令這個iterable的一個element叫x，
                             # 我要對他的第二個元素: x[1]做排序
)
#> [('zhao', 68), ('sun', 72), ('qian', 80), ('zhou', 83), ('li', 90)]
```

* 從結果來看，可知道已順利依照value由小排到大  
* 如果要由大到小，就加上`reverse = True`這個argument就好  


```python
sorted(d.items(), key = lambda x: x[1], reverse = True)
#> [('li', 90), ('zhou', 83), ('qian', 80), ('sun', 72), ('zhao', 68)]
```

* 舉一反三，如果要對key的大小做排序(依姓氏排序)，那就是：  


```python
sorted(d.items(), key = lambda x: x[0])
#> [('li', 90), ('qian', 80), ('sun', 72), ('zhao', 68), ('zhou', 83)]
```

* ok，那回到原來的目的，依照value由大到小排序，且轉回dictionary  


```python
dict(sorted(d.items(), key = lambda x: x[1], reverse = True))
#> {'li': 90, 'zhou': 83, 'qian': 80, 'sun': 72, 'zhao': 68}
```

#### 用list專用的method: `.sort(key)`  

* 剛剛知道，`d.items()`的結果很像list，但不是list，所以我先轉成list後，再排序  


```python
item_list = list(d.items())
print(item_list)
#> [('zhao', 68), ('qian', 80), ('sun', 72), ('li', 90), ('zhou', 83)]
print(type(item_list))
#> <class 'list'>
```

* 接著就很簡單了，用學過的`.sort(key = ..., reverse = True)`來處理  


```python
item_list.sort(
  key = lambda x: x[1], #key就是function的意思，我先用這function算出結果，才用結果做排序
  reverse = True
)

print(item_list)
#> [('li', 90), ('zhou', 83), ('qian', 80), ('sun', 72), ('zhao', 68)]
```
