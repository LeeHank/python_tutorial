# decorator  

## 先備知識  

* 在講decorator前，我們先複習decorator會用到的4個先備知識  
  * functions as objects  
  * nested functions  
  * nonlocal scope  
  * closure  

### function as object  

* 定義好的function，他本身就是一個object，例如：  


```python
def my_func():
  print("hello")

type(my_func)
#> <class 'function'>
```

* `my_func`是一個object，但`my_func()`是call這個函數  


```python
my_func
#> <function my_func at 0x10d0d3ee0>
my_func()
#> hello
```

* 我們可以把函數object拿去assign成一個variable、放在list/dictionary裡面、或當成其他函數的一個argument  


```python
def my_func():
  print("hello")

# assign成一個variable
f = my_func
f()

# 放在list, dictionary裡面
#> hello
my_list = [my_func, print]
my_list[0]()

# 當其他函數的argument
#> hello
def second_function(func):
  func()

second_function(my_func)
#> hello
```

### nested function  

* 定義： 在一個function底下，又定義一個function，這個內層的function，我們叫inner function/ nested function/ helper function/ child function 都可以  
* 此外，我們可以把這個nested function給output出來  


```python
# outer function/ parent function
def parent():
  # nested/inner/child/helper function
  def child():
    pass
  return child
```

### nonlocal variable  

* 定義： local variable是指最內層的scope所定義的variable，而nonlocal scope，就是最內層的外面一層(仍在函數的scope內)所定義的variable  
* nonlocal scope就是LEGB中的E(Enclosing scope)  


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

* 上例中，child內的scope，叫local scope; child外但是是parent內的scope，叫nonlocal scope/ enclosing scope  
* 所以，`arg1`, `arg2`, `my_dict`, `value`為四個nonlocal variable(照字母順序排列)  

### closure  

* output的nested function，所攜帶的nonlocal variables，我們叫closure  
* 例如下例：  


```python
new_function = parent(3, 4)
# new_function會帶有closure屬性，且type是tuple，裡面的每個element，都是(nonlocal_var, value)的pair
type(new_function.__closure__)
# 長度會是4，因為有四組pair
#> <class 'tuple'>
len(new_function.__closure__)
# 看closure的內容
#> 4
for element in new_function.__closure__:
  print(element.cell_contents)
#> 3
#> 4
#> {'chocolate': 'yummy'}
#> 22
```

## Intro to decorator  


```python
def double_args(func):
  def wrapper(a, b):
    return func(2*a, 2*b)
  return(wrapper)
```

* decorator就字面上的意思就是`裝飾子`，裝飾什麼東西呢？裝飾一個已經存在的funciton  
* 例如下例：  


```python
@double_args
def multiply(a, b):
  return a * b

multiply(1, 5)
#> 20
```

* 在此例中，`@double_args`就是一個decorator，他裝飾的東西，就是下面的function: `multiply`  
* 他如何裝飾的呢？他會把`multiply`的arguments，都先乘以2，再丟到`multiply`這個function裡面  
* 這也是為什麼`multiply(1, 5)`會變成 2x10 = 20 的原因  
* 那`@double_args`的背後到底是什麼？為什麼可以有這種效果呢？  
* 其實 `@double_args`的寫法，等同於在做下面這件事：  


```python
# 定義一個function，讓他的input argument是要裝飾的function
def double_args(func):
  # 定義一個nested function，來改變`func`的行為
  def wrapper(a, b):
    return func(2*a, 2*b) # 把func的arguments都先乘上2，再evaluate
  
  # 回傳這個修改好的function
  return(wrapper)

# 準備要被裝飾的function如下
def multiply(a, b):
  return a * b

multiply = double_args(multiply)
multiply(1,5)
#> 20
```

* 所以可以發現，`@dobule_args`的作用，其實是在做這件事：  


```python
multiply = double_args(multiply)
```

* 他把被裝飾的function(i.e. multiply)，丟到`裝飾function`(i.e. double_args)，然後assign成和被裝飾的function一樣的名字，那之後用這個function，就都會是被裝飾後的版本了  
* 所以重點在於`@double_args`的寫法，是`func = double_args(func)`的簡潔寫法，而func可以放任何要被裝飾的函數  

* 打鐵趁熱，練習一下。我想寫一個decorator，讓每個被他裝飾的function，都會自動print出"hahaha"：  

```python
def haha(func):
  def wrapper(*args, **kwargs):
    print("hahaha")
    return func(*args, **kwargs)
  return wrapper

@haha
def func1():
  print("this is function 1")

func1()
#> hahaha
#> this is function 1
@haha
def func2():
  print("this is function 2")

func2()
#> hahaha
#> this is function 2
```

* 從這個例子中，我們已經可以很快看到decorator的一個使用時機：
  * 當我們想新增一個功能到已經寫好的多個函數中時(e.g. 這邊的`func1`, `func2`)，我不用再一一去改這些已經定義過的函數，我只要寫個decorator，然後把他加上在這些函數上就好。
  * 而且，如果之後決定拿掉這些功能，那也只要拔掉decorator的標籤即可，我都不用動到我之前定義好的`func1`, `func2`, ...

## Decorators and metadata  

* decorator有一個問題是，他會讓我們原始function的metadata(e.g. docstring)消失：  
* 例如，我的原始function叫`sleep_n_seconds`，如下：   


```python
def sleep_n_seconds(n=10):
  """
  Purpose:
    Pause processing for n seconds.
  Args:
    n (int): The number of seconds to pause for.
  """
  time.sleep(n)
```

* 那我是看得到他的docstring的：  


```python
print(sleep_n_seconds.__doc__)
#> 
#>   Purpose:
#>     Pause processing for n seconds.
#>   Args:
#>     n (int): The number of seconds to pause for.
#> 
```

* 但如果我把`timer`這個decoratro加上去，就會變成看不到


```python
import time

def timer(func):
  def wrapper(*args, **kwargs):
    t_start = time.time()
    result = func(*args, **kwargs)
    t_total = time.time() - t_start
    print(f"{func.__name__} took {t_total} seconds to run")
    return result
  
  return wrapper

@timer
def sleep_n_seconds(n=10):
  """
  Purpose:
    Pause processing for n seconds.
  Args:
    n (int): The number of seconds to pause for.
  """
  time.sleep(n)


print(sleep_n_seconds.__doc__)
#> None
```

* 為什麼會這樣？這是因為，我們現在以為的`sleep_n_seconds`，其實是decorator中，被吐出來的`wrapper`  


```python
print(sleep_n_seconds.__name__)
#> wrapper
```


```python
def wrapper(*args, **kwargs):
    t_start = time.time()
    result = func(*args, **kwargs)
    t_total = time.time() - t_start
    print(f"{func.__name__} took {t_total} seconds to run")
    return result
```

* 而這個`wrapper`，很明顯的沒寫docstring，所以才會讓你看不到原本`sleep_n_seconds`的docstring  
* 如果要讓`wrapper`也呈現原本`sleep_n_seconds`的docstring，我們可以再加一個decorator`@wraps(func)`在前面：  


```python
import time
from functools import wraps # 加入這行，引用wraps

def timer(func):
  @wraps(func) # 加入這行，有參數的decorator，參數的func就是一開始丟入timer的func
               # 所以他會把func的docstring加進來
  def wrapper(*args, **kwargs):
    t_start = time.time()
    result = func(*args, **kwargs)
    t_total = time.time() - t_start
    print(f"{func.__name__} took {t_total} seconds to run")
    return result
  
  return wrapper

@timer
def sleep_n_seconds(n=10):
  """
  Purpose:
    Pause processing for n seconds.
  Args:
    n (int): The number of seconds to pause for.
  """
  time.sleep(n)

print(sleep_n_seconds.__name__)
#> sleep_n_seconds
print(sleep_n_seconds.__doc__)
#> 
#>   Purpose:
#>     Pause processing for n seconds.
#>   Args:
#>     n (int): The number of seconds to pause for.
#> 
```

* 上面的code中，注意：  
  * 一開始先引用了： `from functools import wraps`
  * `wrapper`的前面，加上了有參數的decorator，`@wraps(func)`，參數的func就是一開始丟入timer的func，所以他會把func的docstring加進來  
* 事實上，他加進來的是所有的meta-data，不只docstring，還包括：  
  * default argument的值是多少  
  * wrap進來的原始function長怎樣(i.e. 還沒被裝飾前的`sleep_n_seconds`)  


```python
# default argument的值
print(sleep_n_seconds.__defaults__)

# original function，可以直接使用這個裝飾前的function
#> None
sleep_n_seconds.__wrapped__
#> <function sleep_n_seconds at 0x10d11cc10>
```

* 在實務上，這個original function蠻有用的。  
* 比如說，你原本寫了一堆function，也都運作得好好的，但你老闆突然神來一筆，寫了一個decorator，強迫你要加到你目前的所有function上  
* 但你一加上這個decorator後，發現運算速度慢好多...  
* 那為了說服老闆，你就可以做這個實驗：  
  * 計算加入decorator"前"的計算時間  
  * 計算加入decorator"後"的計算時間  
  * 看一下差多少就知道了  
* 如果加入decorator以後，計算速度變慢超多，那表示這個decorator太肥，要評估看看是不是真的有需要用這個decorator  

## 有arguments的decorators  

* 剛剛介紹的decorator，在定義的時候，都只有`func`一個參數，表示他即將要裝飾的function。但有的時候，我會希望還能再加上其他參數。  
* 例如，我想寫一個decorator，叫`run_n_times`，他會將要裝飾的那個function，重複run n次，那這時候就需要n這個argument了  
* 那寫法的邏輯其實是這樣：  
  * 寫個function，他的input argument只有`n`，然後他的output是一個decorator!!
  * 我們再用這個output出來的decorator，去裝飾我要裝飾的function  
  

```python
def run_n_times(n):
  """
  Define and return a decorator
  """
  # 之前寫好的decorator放這邊，然後讓他吃我的參數n，讓他變成新的decorator
  def decorator(func):
    def wrapper(*args, **kwargs):
      for i in range(n): # 重複進行n次
        func(*args, **kwargs)
    return wrapper
  # 把這個定義好的，新的decorator，給丟出來
  return decorator
```

* 所以，現在我如果用`run_n_times(3)`，那就可以做出一個讓被修飾的function run 3次的decorator：  


```python
run_three_time = run_n_times(3)
@run_three_time
def say_hello():
  print("hello")

say_hello()
#> hello
#> hello
#> hello
```

* cool，但實務在用時，`@run_three_time`，可以直接簡化成`@run_n_times(3)`就好！！  
* 我們以run 5次來當範例試試：  


```python
@run_n_times(5)
def say_hello():
  print("hello")

say_hello()
#> hello
#> hello
#> hello
#> hello
#> hello
```

* 打鐵趁熱，來寫個html的generator，讓我輸入的文字，自動加上指定的tag:  


```python
def html(open_tag, close_tag):
  def decorator(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
      msg = func(*args, **kwargs)
      return f'{open_tag}{msg}{close_tag}'
    return wrapper
  return decorator
```

* 加上粗體的tag:  


```python
@html("<b>", "</b>")
def hello(name):
  return f'Hello {name}!'
  
print(hello('Alice'))
#> <b>Hello Alice!</b>
```

* 加上斜體的tag


```python
@html("<i>", "</i>")
def goodbye(name):
  return f'Goodbye {name}.'
  
print(goodbye('Alice'))
#> <i>Goodbye Alice.</i>
```

* 加上div的tag  


```python
# Wrap the result of hello_goodbye() in <div> and </div>
@html("<div>", "</div>")
def hello_goodbye(name):
  return f'\n{hello(name)}\n{goodbye(name)}\n'
  
print(hello_goodbye('Alice'))
#> <div>
#> <b>Hello Alice!</b>
#> <i>Goodbye Alice.</i>
#> </div>
```

## Real-world examples  

* decorator的使用時機: add common behavior to multiple functions  

### time a function  

* 我想寫一個`timer`的decorator，來print出該function要花多少時間run  


```python
import time

def timer(func):
  """
  Purpose:
    A decorator that prints how long a function took to run
  Args:
    func (callable): The function being decorated  
  Returns:
    callable: the decorated function
  """
  def wrapper(*args, **kwargs):
    t_start = time.time()
    result = func(*args, **kwargs)
    t_total = time.time() - t_start
    print(f"{func.__name__} took {t_total} seconds to run")
    return result
  
  return wrapper
```

* 那我現在寫一個`sleep_n_seconds`的function，就可以測測是不是可以work  


```python
@timer
def sleep_n_seconds(n):
  time.sleep(n)

sleep_n_seconds(2)
#> sleep_n_seconds took 2.0073468685150146 seconds to run
sleep_n_seconds(5)
#> sleep_n_seconds took 5.008097887039185 seconds to run
```

### counter  

* 假設我們今天寫了一個新的web app，然後想看看各支function被call了幾次  
* 那過了一陣子後，我們就可以看一下是不是有些function可以被remove，反正user根本都沒在用  
* 那我就可以寫個decorator，加在我所有想觀察的function的上面，就可以做到這件事：  


```python
def counter(func):
  def wrapper(*args, **kwargs):
    wrapper.count += 1
    # Call the function being decorated and return the result
    return func(*args, **kwargs)
  wrapper.count = 0
  # Return the new decorated function
  return wrapper

# Decorate foo() with the counter() decorator
@counter
def foo():
  print('calling foo()')
  
foo()
#> calling foo()
foo()
#> calling foo()
print(f'foo() was called {foo.count} times.')
#> foo() was called 2 times.
```

### print the return type  

* 在debug的時候，常常會懷疑，原本寫好的function，吐出來的value的資料類型，到底是不是我心中想的那樣  
* 例如，我以為我寫的這個function，會吐tuple出來，但結果他是吐list  
* 那常見的作法，就是進到這個function去debug，或是在這個function中，叫他多print一下return的type  
* 但只要有這個需求的function一多，你就又會覺得很煩了，所以這時候，就又可以用decorator了： 我只要寫個decorator，那我想裝飾哪些function就看哪些function：  


```python
def print_return_type(func):
  # Define wrapper(), the decorated function
  def wrapper(*args, **kwargs):
    # Call the function being decorated
    result = func(*args, *kwargs)
    print(f'{func.__name__}() returned type {type(result)}')
    return result
  # Return the decorated function
  return wrapper
```

* 現在來試試效果：  


```python
@print_return_type
def foo(value):
  return value
  
print(foo(42))
#> foo() returned type <class 'int'>
#> 42
print(foo([1, 2, 3]))
#> foo() returned type <class 'list'>
#> [1, 2, 3]
print(foo({'a': 42}))
#> foo() returned type <class 'dict'>
#> {'a': 42}
```

### memorize results  


* 有時候我們寫了一個function，他每做一次運算，都要花很久的時間。
* 那我就希望，把input, output給記下來，例如我如果call過n次這個function，我就累積了n筆input和output，可記成這樣：  


```python
cache = {
  (arg1_1, arg2_1): result_1,
  (arg1_2, arg2_2): result_2,
  ...,
  (arg1_n, arg2_n): result_n
}
```

* 那之後call這個function時，我就先去查之前有沒有做過這組input，如果有，我就直接給你output的結果，根本不用再跑一次這個function  
* 那要達成這個目的，我就可以寫個decorator:  


```python
def memorize(func):
  """
  Purpose:
    store the results of the decorated function for fast lookup
  """
  
  cache = {}
  def wrapper(*args, **kwargs):
    if (args, kwargs) not in cache:
      cache[(args, kwargs)] = func(*args, **kwargs)
    return cache.get(args, kwargs)
  
  return wrapper
```


* 來試試看他的效果(報error，之後再debug吧)  


```python
@memorize
def slow_function(a, b):
  print("sleeping...")
  time.sleep(5)
  return a + b

slow_function(a = 3, b = 4)
slow_function(a = 3, b = 4)
```

### timeout  

* 這邊要寫一個decorator，他會去監控我的function的運行時間，如果超過我的忍耐，我就直接停到這個function  
* 這會是一個有argument的decorator，參數是`n_seconds`，也就是我可以容忍的運行秒數  



```python
import time
import signal

def timeout(n_seconds):
  def decorator(func):
    def wrapper(*args, **kwargs):
      # set an alarm for n seconds
      signal.alarm(n_seconds)
      try:
        return func(*args, **kwargs)
      finally:
        # cancel alarm
        signal.alarm(0)
    return wrapper
  return decorator
```

* 這邊注意到，使用到了沒學過的`signal` module，那它的作用是，你用`signal.alarm(3)`，，來開起計時器，如果3秒後還沒結束，他就會跳timeout error出來  
* 那我們試試看以下例子：  


```python
@timeout(3)
def foo():
  time.sleep(2)
  print("foo!")

foo()
#> foo!
```

* 運行時間，小於3秒，所以ok  
* 那如果運行時間大於3秒，會show timeout error (這邊就不執行了，因為session會斷掉)  


```python
@timeout(3)
def foo():
  time.sleep(5)
  print("foo!")

foo()
```

