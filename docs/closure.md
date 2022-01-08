# closure  

## 把function當成output  

* 之前講nested function，是在強調他可以簡化原function內部的計算(我把原function內一直重複出現的pattern，寫成一個inner function，讓他在裡面可以重複使用)。  
* 但有時候我們寫nested function的目的，是為了要output出這個nested function  
* 例如這樣：


```python
def raise_val(n):
    """Return the inner function."""
    
    def inner(x):
        """Raise x to the power of n."""
        raised = x ** n
        return raised
      
    return inner


square = raise_val(2)
cube = raise_val(3)
print(square(2), cube(4))
#> 4 64
```

* 酷...我input東西後，可以製作出各式各樣的function\
* 那，為啥要這麼做呢？ 其實很簡單啊，還是在偷懶啊。想想看，如果今天你要寫個2次方的function，3次方的function，4次方的function...，你要一直重複定義這些一樣pattern的寫法(def function(x) x\*\*2)，你不累嗎？所以我就寫個general function，然後你只要輸入n，我就給你n次方的function\

## closure  

* 剛剛講了nested function，以及把nested function給output出來  
* 那現在要講的是，這個output的nested function，可以攜帶他外層的資訊(nonlocal variables)一起出來，這種行為我們叫closure  
* 看以下這個簡單的例子：  


```python
def foo():
  a = 5
  def bar():
    print(a)
  return bar

f = foo()
f()
#> 5
```
* 可以看到，當我們call `f`的時候，其實是在call`bar`這個函數，那bar這個函數會需要用到a，那a從哪裡來？我又沒定義，他怎麼知道？  
* 答案是，你如果只看`bar`這個函數，你當然沒有a的資訊，但如果你是用`foo()`所造出的`bar`函數，那他就帶有enclosing scope的`a = 5`這個資訊了。這個a就是nonlocal variable。  
* 驗證一下，`f`這個函數是用`foo()`所output出的function，所以他應該會帶有closure性質，那我就可以用以下語法檢驗：  


```python
f.__closure__
#> (<cell at 0x1378c3f10: int object at 0x10c64a960>,)
```

* 發現，f果然存有`.__closure__`這個attribute  
* 如果你只是一般的function物件，是不會有`.__closure__`這個attribute的  


```python
def bar():
    print(a)

dir(bar)
#> ['__annotations__', '__call__', '__class__', '__closure__', '__code__', '__defaults__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__get__', '__getattribute__', '__globals__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__kwdefaults__', '__le__', '__lt__', '__module__', '__name__', '__ne__', '__new__', '__qualname__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__']
```

* 那回到`f.__closure__`，我現在看不到他的長相，但可以看他的type:  


```python
type(f.__closure__)
#> <class 'tuple'>
```

* 發現是一個tuple，他裡面其實就存有所有要用到的一對一對的(nonlocal variable, value) pair  
* 比如剛剛這個例子，就是(a, 5)這個pair  
* 所以我們可以驗證一下，`f.__closure__`這個tuple是不是只有一個pair:  


```python
len(f.__closure__)
#> 1
```

* 如果要抓出來看，用以下語法：  
  

```python
f.__closure__[0].cell_contents
#> 5
```



```python
f.__closure__[0].cell_contents
#> 5
```

* 打鐵趁熱，看以下的例子：  


```python
def parent(arg1, arg2):
  value = 22
  my_dict = {"chocolate": "yummy"}
  
  def child():
    print(2*value) # 這邊就用到nonlocal variable: value
    print(my_dict['chocolate']) # 這邊就用到nonlocal variable: my_dict
    print(arg1+arg2) # 這邊用到nonlocal variable: arg1, arg2
  
  return child
```

* 從這邊可以看到，我們要output出來的`child` function，他會攜帶`arg1`, `arg2`, `my_dict`, `value`這四個nonlocal variable(照字母順序排列)  
* 驗證一下：  


```python
new_function = parent(3, 4)
len(new_function.__closure__)
#> 4
```

* 果然帶有4個nonlocal variables，我們一一把它們叫出來看：  


```python
for element in new_function.__closure__:
  print(element.cell_contents)
#> 3
#> 4
#> {'chocolate': 'yummy'}
#> 22
```
