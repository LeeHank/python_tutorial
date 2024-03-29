# Variable Scope  

## Intro    

* 在我們寫python script時，每個variable都有自己所屬的scope(i.e. 我是在哪個scope中被定義的)。那我們在呼叫這個變數時，系統就會先看你是在哪個scope做呼叫的，然後去找這個scope中有沒有你要的這個變數。  
* 例如下例：  


```python
num = 4 # 在global scope中被定義
print(num) # 在global scope中呼叫num
#> 4
def func1():
    num = 3 # 在local scope中被定義
    return num # 在local scope中呼叫num

print(func1()) # 在global scope中呼叫func1
#> 3
print(num) # 在global scope中呼叫num
#> 4
```

* `num = 4`是在global scope中被定義的; `num = 3`是在local scope被定義的。  
* 所以在function中，你要他`retun num`，他就會先看他目前在哪個scope? -> local scope。所以他先去local scope中找找看有沒有num，結果找到`num = 3`，那他就會用`num = 3`  
* 但你在外面call `print(num)` 時，因為你是在global scope去call的，所以他會在global scope中有沒有num，結果找到`num = 4`，所以他會print 4出來  

## LEGB scope  

* 那接下來講更細一點，variable這個詞，可以把它一般化成object。而python的scope其實有四種，由低至高分別為`LEGB`。搜尋object時，先從呼叫的scope開始做搜尋，如果搜尋不到，就往上一個階層做搜尋。所以如果你從local scope呼叫一個變數的話，他就會這樣搜：    
  * 先搜*L*ocal scope: 就是你define一個function時，他的body就是個local scope
  * 再搜*E*nclosing function scope: 晚點再定義  
  * 再搜*G*lobal scope: 就是寫main script的地方  
  * 最後*B*uilt-in scope: 一些pre-define好的functions，例如`sum`。  

* 所以，如果更改一下剛剛的例子：  


```python
num = 4 # 在global scope中被定義
print(num) # 在global scope中呼叫num
#> 4
def func1():
    return num # 在local scope中呼叫num

print(func1()) # 在global scope中呼叫func1
#> 4
print(num) # 在global scope中呼叫num
#> 4
```

* 會發現在local scope中呼叫num時，因為local scope裡沒有num，所以他往上一層找(global scope)，找到num = 4，所以就用了這個4  

* 那再看個例子：  


```python
def func1():
    val = 3 # 在local scope中被定義
    return val # 在local scope中呼叫num

print(func1()) # 在global scope中呼叫func1
#> 3
print(val) # 在global scope中呼叫num
#> Error in py_call_impl(callable, dots$args, dots$keywords): NameError: name 'val' is not defined
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
```

* 看到出現error了，因為我們在global scope中呼叫val時，他會先從global scope中找有沒有val，沒有的話，他會往built-in scope找val，當然也是沒找到val，所以最後就給你error  


## 用`global`這個keyword，把local scope的object給推到global scope


```python
def func1():
    global num
    num = 3
    print(num)
    
print(func1())
#> 3
#> None
print(num)
#> 3
```


## Enclosing function scope的例子  

* 剛剛講到python的scope分為LEGB四種，現在來講E這個Enclosing function scope  
* 首先，我們來看看以下的nested function。他的目的是，給我一串數字，我幫你把每個數字都乘上2再加5，然後吐出來。以下是demo:  


```python
def mult2plus5_nested(x1, x2, x3):
    
    def inner(x):
      value = x*2 + 5
      return value

    return (inner(x1), inner(x2), inner(x3))

print(mult2plus5_nested(2,3,4))    
#> (9, 11, 13)
```

* 那剛剛講過，function內的scope，我們叫local，那現在function內還有function，該怎麼叫？  
* 答案是，最內層的function的scope，我們叫local，他外面的scope，我們叫enclosing function scope  
* 所以，標上註解後如下：  


```python
def mult2plus5_nested(x1, x2, x3):
    # 這邊是enclosing function scope
    def inner(x):
      # 這邊是local
      value = x*2 + 5 
      return value
    # 這邊又回到enclosing function scope
    return (inner(x1), inner(x2), inner(x3))
```

* 那所以，維持剛剛搜尋時依照LEGB的順序，應該猜得出以下範例的答案：  


```python
def outer1():
    n = 1
    def inner():
        n = 2
        print(n)
    inner()
    print(n)

outer1()
#> 2
#> 1
```

* 可以看到，先print出的`inner()`，用的n是local scope的n，所以是n=2  
* 後print出的n，用的n是enclosing function的n，所以是n=1  

## 用`nonlocal`這個keyword...  


* 如同我們想把local的variable，推到global時，會用`global`，那現在，要把local的variable，推到enclosing function scope，會加入`nonlocal`：


```python
def outer2():
    n = 1
    def inner():
        nonlocal n
        n = 2
        print(n)
    inner()
    print(n)

outer2()
#> 2
#> 2
```

* cool\~ 最後要print出的n，他在enclosing function scope中找，他不是找到一開始定義的n=1，而是找到在local端定義好，然後被推到enclosing function scope的n=2  
