# list整理與實戰  

* list是python內建的一種collection  
* 既然是collection，我們就可以把它當資料庫看，所以會依序介紹作為資料庫最基礎的幾個part：  
  * 如何建立？  
  * 如何增、刪、查、改？  
* 這些基礎會了後，就確認一下是否為mutable物件，來決定如何做copy  
* 接著就開始介紹如何loop他(用for, comprehension)  
* 最後就是補齊這個object還沒介紹到的methods  
* 實戰的部分，就會以"How to..."的方式整理常見的需求  

## list定義    

* list用中括號來建立，裡面的每個元素我們叫item，item可以是不同的type，例如：  


```python
a_list = [12, 3, 67, 7, 82] #同一種type的list
another_list = ["happy", 3, True, 7] #不同type的list

print(type(a_list))
#> <class 'list'>
print(type(another_list))
#> <class 'list'>
```

* list的特性有三個，ordered, changeable, allow duplicate values：  
  * ordered: 他是有順序的，裡面的items就像排隊取號碼牌一樣，都有自己的序號(index)，此序號由0開始排起。所以如果有新成員要加入list，只能排到隊伍的最後面，用append的方式加入。要取用某個item時，也是用叫號碼牌的方式取用    
  * changeable: list裡面的item是可改變的，意思是，當我建立好一個list後，我可以改變號碼牌為x的那個item的值，我也可以新增或刪除item  
  * allow duplicates: item是可以重複的  

## [建] 建立list  

### 建立單維list  

* 剛剛講過了，就用個中括號包起來就好  

### 建立多維list  

* list裡面還有list，就叫多維list  


```python
a = [1,2,3,4,5] # 1*5 list  
multi_dim_a = [[1,2,3],
               [2,3,4],
               [3,4,5]]
print(multi_dim_a)
#> [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
```


## [查] 取用list裡面的item  

* list因為只有item，沒有name(簡單來講，就是只有value，沒有key)，所以subset時，都是用index來取  
* index就擬人化為座號，而python的編號由左至右是從0開始，由右至左是從-1開始    
* 所以我要取list中左邊數來第n個人，他的座號是n-1，那就要取n-1的index  
* 如果我要取list中右邊數來第n個人，他的座號是-n，那就要取-n的index  

### 用index = 0取第一個item  

* 單維list的例子：  


```python
my_list = ["my", "list", "is", "nice"]
my_list[3] # 取index=3, 那就是取element = 4
#> 'nice'
```

* 學會單維list的subset了，那多維list的subset邏輯一模一樣  


```python
multi_dim_a = [[1,2,3], [2,3,4],[3,4,5]] 
multi_dim_a[1] # 取index = 1，即左邊數來第2個
#> [2, 3, 4]
```


```python
multi_dim_a[1][0] # 先取左邊數來第2個element，再取裡面的第1個element
#> 2
```

### 用index = -2取由右數來第2個  


```python
my_list = ["my", "list", "is", "nice"]
my_list[-2] # 取index -2, 即又邊數來第二個
#> 'is'
```

### 3:8表示從index3取到index7  

* 剛剛是取"某一個"element，那如果我想取"某一串"element呢？那就是指slice  
* 語法是[start_index:stop_index]，所以[1:5]是指從index=1取到index=4，那就是取第2個element到第5個  
* 所以為了方便記憶，就把stop_index當作stop_element來看，然後start_index還是start_index  
* 簡單練習，[5:9]，就是指取element = 6 ~ 9  
* 然後，如果你跳過start_index不寫，就是從頭開始；跳過stop_index不寫，就是取到最後；兩個都不寫，就是全取  
* 例如： [:9]，那就是從第一個element一路取到第9個element  
* 例如: [3:]，那就是第4個element一路取到最後一個element  
* 例如: [:]，那就是整串全取(等於複製一個)  


```python
my_list = ["my", "list", "is", "nice"]
my_list[1:3] # 取 element = 2~3
#> ['list', 'is']
```


```python
my_list = ["my", "list", "is", "nice"]
my_list[:3] # 取element = 1~3
#> ['my', 'list', 'is']
```


```python
my_list = ["my", "list", "is", "nice"]
my_list[1:] # 取element = 2~最後
#> ['list', 'is', 'nice']
```

* slice一律只能由左至右取，但編號系統可以用正的編號(由左至右的編號系統)或負的編號(由右至左的編號系統)  
* [1:3]是指由左至右，取element= 2~3  
* [-2:-3]是指由右至左，取element = 右邊數來第2個 ~ 第3個? 
* NO! 他只能由左至右取，所以應該寫成[-3:-2]?  
* NO! 這樣他指會取右邊數來的第3個element，到右邊數來的第2個element的"前1個"!  
* 所以如果要取右邊數來第3個element到右邊數來第2個element，那要寫成[-3:-1]  

```python
my_list = ["my", "list", "is", "nice"]
my_list[-3:-1]
#> ['list', 'is']
```

### 用`.index('a')`找出'a'所屬的index    

* 在R中，我們用 `which(list1 == 'a')`來找index，那在python就是用`list1.index("a")`  
* 看例子：  


```python
a_list = ["apple", "orange", "banana"]
my_index = a_list.index("banana")
print(my_index)
#> 2
```


### 用`in`來確認item在不在list裡  

* 這邊的`in`，就是R的`%in%`  


```python
thislist = ["apple", "banana", "cherry"]
if "apple" in thislist:
  print("Yes, 'apple' is in the fruits list")
#> Yes, 'apple' is in the fruits list
```

## [改] 修改list裡面的item  

* 剛剛已經學會如何取出list中的特定一個element，或是一串element，那我們就可以利用這個技巧，把新值assign到指定位置：  


```python
my_list = ["my", "list", "is", "nice"]
my_list[3] = "bad"
my_list
#> ['my', 'list', 'is', 'bad']
```

* 同樣的，可以一次改動多個位子的值  


```python
my_list[1:] = ["lists", "are", "awsome"]
my_list
#> ['my', 'lists', 'are', 'awsome']
```

## [增] 增加list裡面的item  

### 加到最後面，用`.append()`  

* 例如下例：  


```python
thislist = ["apple", "banana", "cherry"]
thislist.append("orange")
print(thislist)
#> ['apple', 'banana', 'cherry', 'orange']
```

* 不要傻傻的，用`[old_list, "new_item"]`，這樣會變多維list  


```python
old_list = ["apple", "banana", "cherry"]
new_list = [old_list, "orange"]
print(new_list)
#> [['apple', 'banana', 'cherry'], 'orange']
```

### 加到指定的位置，用`.insert()`  


```python
thislist = ["apple", "banana", "cherry"]
thislist.insert(1, "orange")
print(thislist)
#> ['apple', 'orange', 'banana', 'cherry']
```

## [增] join兩個list  

* 拜託，不要用`[list1, list2]`，這不是R(用c(vec1, vec2))，這樣寫會造出多維list  


```python
list1 = ["a", "b", "c"]
list2 = [1, 2, 3]
[list1, list2]
#> [['a', 'b', 'c'], [1, 2, 3]]
```
 
* 用`+`是最簡單的做法：  


```python
list1 = ["a", "b", "c"]
list2 = [1, 2, 3]

list3 = list1 + list2
print(list3)
#> ['a', 'b', 'c', 1, 2, 3]
```


* 用`.extend`也ok  


```python
list1 = ["a", "b", "c"]
list2 = [1, 2, 3]
list1.extend(list2)
print(list1)
#> ['a', 'b', 'c', 1, 2, 3]
```

* 而`.extend`其實是去loop後面的iterable，依序將後面的每個element加入到前面的list中，所以後面只要放iterable即可，不一定要放list。舉例來說，我放tuple也ok:  


```python
thislist = ["apple", "banana", "cherry"]
thistuple = ("kiwi", "orange")
thislist.extend(thistuple)
print(thislist)
#> ['apple', 'banana', 'cherry', 'kiwi', 'orange']
```

* 如果你要用`.append`，那就得自己寫回圈：  


```python
list1 = ["a", "b" , "c"]
list2 = [1, 2, 3]

for x in list2:
  list1.append(x)

print(list1)
#> ['a', 'b', 'c', 1, 2, 3]
```

## [刪] 刪除list裡面的item  

### `.remove(item)` 刪除該item  


```python
thislist = ["apple", "banana", "cherry"]
thislist.remove("banana")
print(thislist)
#> ['apple', 'cherry']
```
### `.pop()` 刪除最後一筆  


```python
thislist = ["apple", "banana", "cherry"]
thislist.pop()
#> 'cherry'
print(thislist)
#> ['apple', 'banana']
```

### `.pop(index)` 刪除該index  


```python
thislist = ["apple", "banana", "cherry"]
thislist.pop(1)
#> 'banana'
print(thislist)
#> ['apple', 'cherry']
```

### `del list[index]` 刪除該list中的此index  


```python
thislist = ["apple", "banana", "cherry"]
del thislist[0]
print(thislist)
#> ['banana', 'cherry']
```

### `.clear()` 清空此list內所有item


```python
thislist = ["apple", "banana", "cherry"]
thislist.clear()
print(thislist)
#> []
```
## [mutable] copy list  

* 在討論mutable或inmuatable的問題時，都是在討論當你把原物件copy一次後，對新copy的物件做事，會不會影響到舊物件(i.e. `list1_copy = list1`，那對list1_copy做修改時，list1會不會跟著動？)    
* 而對list來說，就是會，因為variable name只是一個reference，指到記憶體位置，所以原物件和copy後的物件，其實都指到同一個位置，那你一改他，兩個variable就都會跟著動  


```python
old_list = [1, 2, 3]
bad_new_list = old_list
old_list.pop()
#> 3
print(old_list)
#> [1, 2]
print(bad_new_list)
#> [1, 2]
```

* 所以對mutable object，請愛用`list1_copy = list1.copy()`，或是用`list1_copy = list(list1)`來做copy，不要用`list1_copy = list1`來做copy：  


```python
old_list = [1, 2, 3]
new_list = old_list.copy()

new_list.pop()
#> 3
print(new_list)
#> [1, 2]
print(old_list)
#> [1, 2, 3]
```

## [loop] for   

### loop index  

* R的觀點來做迭代，習慣取index，那就會寫成下面這樣：  


```python
a_list = ["apple", "banana", "cherry"]
for index in range(len(a_list)): 
    print(index)

```

* len(a_list)得到他的長度=3，而range(3)表示由0開始stop在3，所以就得到0,1,2這3個index  

### loop items  

* 但python的觀點，都是直接取裡面的items做迭代，那就會寫成這樣：  


```python
for item in a_list:
    print(item)

```

### `enumerate()`  

* 最後，python才有的，又取index，又取item，語法是： enumerate  


```python
for index, item in enumerate(a_list):
    print("index = ", index, ", number in list = ", item)

```

## [loop] list comprehension  

### simple example  

* 簡單講，就是把for loop簡化成一行的版本    
* 例如以下的例子，我已有一個字串list，然後我想取出每個item的第一個字母，變成新的list，那用for回圈寫會長這樣：  


```python
doctor = ['house', 'cuddy', 'chase', 'thirteen', 'wilson']

# 目標：抓出每個element中的第一個字  
first = []
for doc in doctor:
    first.append(doc[0])
print(first)
#> ['h', 'c', 'c', 't', 'w']
```

* 那如果用list comprehension，就寫成以下這樣：  


```python
list_comp = [doc[0] for doc in doctor]
print(list_comp)
#> ['h', 'c', 'c', 't', 'w']
```

* 帥...還真的一行幹掉，我們首先來教要怎麼閱讀這種code。  
* 在閱讀上，我們要先辨認出三個結構：  
  * 要output出來的data structure，寫在最外面，也就是我們看到的中括號，告訴我們他要output成一個list  
  * for loop要iterate的part，也就是在最後面看到的`for doc in doctor`。其中doctor叫做iterable，doc叫iterator variable(代表iterable中的member)   
  * 每iterate完一個，要output出什麼，也就是最前面看到的`doc[0]`，這部分我們叫"output expression"  
* 了解一個list comprehension是由這三個組成後，閱讀的順序就會變成：  
  * 先讀要for loop的地方，所以知道他要做的是`for doc in doctor`  
  * 再讀每iterate完一次，要output什麼東西出來，所以從`doc[0]`可知，要丟第一個字母出來  
  * 最後，看到最外面是中括號，就知道要把這些結果，搜集成list  
* 所以，總結起來，list comprehension是由以下的pattern組合而成：`["output expression"  for "iterator variable" in "iterable" ]`  
* 有了這個概念後，就可以開始練習把傳統的for loop轉成list comprehension了  

### nested for loop  


```python
pairs_1 = []
for num1 in range(0, 2):
    for num2 in range(6, 8):
        pairs_1.append((num1, num2))
print(pairs_1)
#> [(0, 6), (0, 7), (1, 6), (1, 7)]
```

* 像這種兩個for回圈，寫成list comprehension時，可以這樣寫：  


```python
pairs_2 = [(num1,num2) for num1 in range(0,2) for num2 in range(6,8)]
print(pairs_2)
#> [(0, 6), (0, 7), (1, 6), (1, 7)]
```

### conditional for loop  

* 如果for回圈裡面，有if, if-else, if-elif-else的話，可以寫成list comprehension嗎？  
* 答案是，if和if-else可以，但if-elif-else不行。而且if和if-else的寫法有特定pattern，兩者寫法不同，吞下去就對了  

#### if  


```python
fellowship = ['frodo', 'samwise', 'merry', 'aragorn', 'legolas', 'boromir', 'gimli']

#我現在想重新建立一個list，裡面的element，都要是字數>=7的我才收進來，那就用for loop 加上 if吧！  

fellowship_for_if = []
for member in fellowship:
    if len(member) >= 7:
        fellowship_for_if.append(member)

print(fellowship_for_if)
#> ['samwise', 'aragorn', 'legolas', 'boromir']
```

* 那同樣的結構，當然可以用list comprehension來寫了，就是先for，再if


```python
fellowship_list_comprehension = [member for member in fellowship if len(member)>=7]
#                          2. output expression為member      1.iteration part        

# Print the new list
print(fellowship_list_comprehension)
#> ['samwise', 'aragorn', 'legolas', 'boromir']
```

* 之前有說過第一塊要放output expression，所以，比較正確的做法，應該是寫`member if len(member)>=7 for member in fellowship`才對，但...就不能這樣寫。反而，在if-else時，一定要這樣寫。  

#### if-else  


```python
new_fellowship = [member if len(member) >= 7 else '' for member in fellowship]
#               |----expression part想呈現成這樣----| |---iteration part-------|

# Print the new list
print(new_fellowship)
#> ['', 'samwise', '', 'aragorn', 'legolas', 'boromir', '']
```

## 排序(`.sort()`)    

### `.sort()`  

* 字串型的list，就是照字母順序由小到大  


```python
thislist = ["orange", "mango", "kiwi", "pineapple", "banana"]
thislist.sort()
print(thislist)
#> ['banana', 'kiwi', 'mango', 'orange', 'pineapple']
```

* 數值型就照大小，由小到大  


```python
thislist = [100, 50, 65, 82, 23]
thislist.sort()
print(thislist)
#> [23, 50, 65, 82, 100]
```
### `.sort(reverse = True)`  

* 倒過來牌，用`reverse = True`  (不是descending = TRUE)  


```python
thislist = [100, 50, 65, 82, 23]
thislist.sort(reverse = True)
print(thislist)
#> [100, 82, 65, 50, 23]
```

### `.sort(key = my_func)`  

* 我們可以自己定義一個function，讓list裡面的每個item，都先做完這個運算後，再排序  
* 例如，我想讓我的list items，依照距離50這個數值的遠近排列：  


```python
def myfunc(n):
  return abs(n - 50)

thislist = [100, 50, 65, 82, 23]
thislist.sort(key = myfunc)
print(thislist)
#> [50, 65, 23, 82, 100]
```

## 順序倒過來(`.reverse()`)  

* 如果我想把一個list，左右顛倒，就可以用.reverse  


```python
my_list = [1, 2, 3, 4, 5]
my_list.reverse()
print(my_list)
#> [5, 4, 3, 2, 1]
```

## list.count('a') = 計算'a'在list中出現幾次  


```python
a_list = ["apple", "orange", "banana", "banana"]
new = a_list.count("banana")
print(new)
#> 2
```



## Practice  

* 現在來做個簡單的練習，在`tweets.csv`中，有一個欄位是created_at，是說這個訊息在幾點幾分建立的，我們看一下：  


```python
import pandas as pd
df = pd.read_csv("./data/tweets.csv")
tweet_time = df["created_at"]
```




* 現在，假如我想抓出"時間"的資訊就好，也就是第12~19個element，我可以怎麼做呢？  
* 先建一個空list，然後用for回圈，對每個element都抓12~19的字元，append回這個空list？  
* sure，當然可以，但好遜，我們用list comprehension不就好了？  


```python
result = [entry[11:19] for entry in tweet_time]
print(result[0:10])
#> ['23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:18', '23:40:17', '23:40:18', '23:40:18']
```

* nice，那如果我現在龜毛一點，我想抓hh:mm:ss中的ss=17的就好，怎麼做？  


```python
result2 = [entry[11:19] for entry in tweet_time if entry[17:19]=='17']
print(result2)
#> ['23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17', '23:40:17']
```


