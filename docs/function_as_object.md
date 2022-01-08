# Function就是另一種type的object  

* 之前我們看到`x = [1,2,3]`，我們會說x是`list`; 看到`y = {'foo': 42}`，我們會說y是dictionary  
* 那，看到function時：  


```python
def my_func():
  print("hello")
```

* `my_func`是什麼？my_func就是另一種type的object，我們會說my_func是function這種type  


```python
type(my_func)
#> <class 'function'>
```
* 特別注意，`my_func`是function物件，但`my_func()`是去call這個function，得到return value  


```python
my_func
#> <function my_func at 0x13052bee0>
my_func()
#> hello
```

## 把function assing給一個變數  

* 那既然`my_func`是一個物件，我就可以把這個物件assign到一個variable:  


```python
f = my_func
f()
#> hello
```

## 把function丟到list/dictionary裡面  

* 既然可以把function給assign到一個variable，那我們當然也可以把function加到各種collections裡面  
* 例如，把funciton加到list裡面：  


```python
list_of_functions = [my_func, print, sum]
```

* 然後取出對應的位子後，call這個function的功能：  


```python
list_of_functions[0]()
#> hello
```

* 或是把function加到dictionary裡面：  


```python
dict_of_funcs = {
  'func1': my_func,
  'func2': print,
  'func3': sum
}
```

* 然後，一樣取出對應的element後，再用他的功能：  


```python
dict_of_funcs.get('func2')("this is print function")
#> this is print function
```

## 把function當成argument  

* 假設我們現在已經寫好兩個function如下：  


```python
def no_docstring_func():
  return(43)

def yes_docstring_func():
  """
  Docstring here hahaha
  """
  return(42)
```

* 那我們可以再寫一個function，來判斷某個定義的function是否含有docstring:  


```python
def has_docstring(func):
  """
  purpose: 
    check whether `func` has docstring or not
  Args:
    func (callable): A function
  Returns:
    bool
  """
  return func.__doc__ is not None
```

* 這個function的argument就是一個function了，來試試看：  


```python
print(has_docstring(no_docstring_func))
#> False
print(has_docstring(yes_docstring_func))
#> True
```
