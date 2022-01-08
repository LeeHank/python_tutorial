# functional programming  

## lambda function  

* 假設我們現在有一個function如下：  


```python
def test(x, y):
  return x + 2*y
```

* 那定義完成後，就建立了一個`test`物件，此物件佔有記憶體空間  


```python
test
#> <function test at 0x130c39ee0>
```

* 我們可以call此function做事  


```python
test(1,2)
#> 5
```

* 那lambda function，是一種簡便的寫法，他可以把上面這個function，改成用以下方式定義：  


```python
f = lambda x, y: x + 2*y
```

* 可以看到寫法就是 `lambda {arg1},{arg2},...,{arg_n}`: ...`  
* 那這邊把函數定義的結果，assign到`f`這個變數上，我們就可以使用它了：  


```python
f(1,2)
#> 5
```

-   那實務上，lambda function不會這樣用，而是會和`map`, `reduce`, `filter`這類的高階函數搭配使用
-   還記得高階函數的定義，就是input argument有function，或output有function。那map, reduce, filter都是input argument有function，啥function？lambda function!!  
-   接下來就分別介紹這些高階函數與lambda的搭配使用  

## map with lambda

* map要吃兩個參數:  
  * lambda function: 準備要工作的function  
  * iterable object: 某個iterable object，例如一個list  
* 那map就會逐一取出iterable裡面的每個element，然後對他做lambda function  
* 舉例來說，我有一個list，裡面每個element都是一個單詞，然後我想用map function去對此list的每個element做以下的運算：算單詞字長+2。  
-   那我就可以這樣寫：


```python
voc_list = ["Hank", "statistics", "basketball", "nice guy"]
result_map = map(lambda x: len(x)+2, voc_list)
print(result_map)
#> <map object at 0x130c88160>
print(list(result_map))
#> [6, 12, 12, 10]
```

-   從這個例子可以看到以下用法：

    -   `map`在python中，是先定義函數，再放iterable object進去。但在R裡面是倒過來，先給iterable object，才放自定義函數\
    -   自定義函數這邊，我們其實只想放個用完即丟的函數，不想先在外面定義好，才拿進來用。這時候，就會用到lambda function\
    -   這個lambda function的寫法，就是先宣告他是lambda function & 提供input parameter，加上冒號後，寫下function body就完成。所以他不用在一開始寫def，也不用在結束後寫return，省去很多麻煩。更重要的是，沒有額外在main script定義函數，所以減少了記憶體空間(因為不需要開個記憶體空間來存這個定義的函數)\
    -   map後的結果，是一個map object，要用`list()`把他轉成list，才看得到最後的結果

## reduce with lambda

* reduce要吃兩個參數:  
  * lambda function: 準備要工作的function  
  * iterable object: 某個iterable object，例如一個list  
* reduce的作用直接舉例比較快 
* 我有一個iterable object，是`x = [1,2,3,4,5]`，然後我有一個lambda function，是相加，`lambda x, y: x+y`，那做reduce時，會寫成`reduce(lambda x, y: x+y, list)`，他就是在做：  
  * 1 + 2 = 3 (前兩個element相加，得到3)  
  * 3 + 3 = 6 (把剛剛計算的結果，和下一個element相加)  
  * 6 + 4 = 10 (把剛剛計算的結果，和下一個element相加)  
  * 10 + 5 = 15 (把剛剛計算的結果，和下一個element相加)  
-   小提醒是，reduce這個function住在functools這個package裡，所以要先import他：


```python
from functools import reduce
import numpy as np
num_list = [1,2,3,4,5]
result_reduce = reduce(lambda x, y: x+y, num_list)
print(result_reduce)
#> 15
print(sum(num_list))
#> 15
```

## filter with lambda

-   `filter`的寫法是這樣：`filter(lambda function, iterable)`，其中，這個lambda function的回傳值要是True/False，而filter的回傳值，就是把iterable所對應到的True給回傳出來\
-   所以很符合R的filter的用法：符合的，篩選出來\
-   看個例子：我想篩選出iterable中，字長+2後\>9的：


```python
print(voc_list)
#> ['Hank', 'statistics', 'basketball', 'nice guy']
result_filter = filter(lambda x: len(x)+2 > 9, voc_list)
print(list(result_filter))
#> ['statistics', 'basketball', 'nice guy']
```

-   那舉一反三，我如果有一個字串list，我想抓出"ha"開頭的字，我也可以用filter  


```python
str_list = ["hahaha", "hank", "hamonica", "balabala", "nonononono"]
result = filter(lambda x: x[0:2]=="ha", str_list)
print(list(result))
#> ['hahaha', 'hank', 'hamonica']
```


