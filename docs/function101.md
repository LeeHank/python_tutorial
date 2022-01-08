# function101

## function的結構  

* function的 3+1 個part
  * function header: 這個function的名稱  
  * Docstrings: 開頭註解，用三引號夾起來，並照PEP8格式，寫下Purpose, Args, Returns, Raises這四個component (其中的Raises是指，什麼狀況下要給error)
  * function body: 這個function的內容  
  * output出什麼: 這是optional，你可以只做side-effect(e.g. 寫入資料庫)，但不output出東西。若要output出東西，可以output一個int, float, string, 或一個collection(e.g. list, tuple, dictionary, set), 或一個新的function(i.e. clousure，見`nested function`那章)  

* 以下是一個簡單但完整的function  


```python
def square(value): # <- Function header
  # <- Docstrings are below
  """
  Purpose: 
    Return the square of a value
  Args:
    value (int/float): the number to be squared
  Returns:
    int/float
  Raises:
    ValueError: If `value` is not int/float
  """
  
  # Function body
  if (not type(value) is int) and (not type(value) is float):
    raise TypeError("`value` must be the type of int/float")
  
  new_value = value**2 
  
  # output
  return new_value
```

## function的內容  

### Docstring的標準格式  

* 從上例可以看到docstring的標準格式  
* 對開發者來說，他看到你的source code，就可以很清楚的知道function的目的, 參數, output, 以及什麼時候會給error  
* 對user來說，他雖然看不到你寫的註解，但他只要下help，就可以輕易看到這些內容：  


```python
help(square)
#> Help on function square in module __main__:
#> 
#> square(value)
#>     Purpose: 
#>       Return the square of a value
#>     Args:
#>       value (int/float): the number to be squared
#>     Returns:
#>       int/float
#>     Raises:
#>       ValueError: If `value` is not int/float
```

* 或是，用這個function的`.__doc__`屬性，也可以看到：  


```python
print(square.__doc__)
#> 
#>   Purpose: 
#>     Return the square of a value
#>   Args:
#>     value (int/float): the number to be squared
#>   Returns:
#>     int/float
#>   Raises:
#>     ValueError: If `value` is not int/float
#> 
```


### 先檢驗argument的合法性    

* 此外，也可以看到比較professional的function寫法，會在一開始就檢驗你丟進來的arguments是否符合要求，不符合就報錯，來避免不必要的bug  
* 所以，我們測試一下就知道了：  


```python
print(square(3))
#> 9
print(square(1.4))
#> 1.9599999999999997
print(square('haha'))
#> Error in py_call_impl(callable, dots$args, dots$keywords): TypeError: `value` must be the type of int/float
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
#>   File "<string>", line 16, in square
```

* 詳細的error handling寫法，會在下一個章節介紹  

### 記得寫`return`  

* 特別注意，如果要return value出來，最後一定要加`return`，不能像R偷懶，以為最後一行就會自己return出來  

### default argument  

* 這很easy拉，就簡單給個例子就好


```python
def power(number, pow = 1):
  """Raise number to the power of pow."""
  new_value = number ** pow
  return new_value

print(power(9, 2))
#> 81
print(power(9))
#> 9
```

* 要特別注意的是，default argument一定要放到最後面，不可以放到前面

## function就是一個object  

* 剛剛定義好`square`這個function，他其實就是個object，直接key函數名稱，可以看到他的記憶體位置：  


```python
square
#> <function square at 0x139a72ee0>
```

* 但如果你打`square(3)`，那他會call這個函數：  


```python
square(3)
#> 9
```

* 所以，記得這兩個重點：  
  * `square`是一個函數物件  
  * `square()`是call這個函數後的運算結果  
* 也因為`square`他現在就是個function物件，所以你要把他assign到別的variable也沒問題：  


```python
new = square
new(3)
#> 9
```

* 有關把function當一個物件來使用的詳細介紹，請見`Function就是另一種type的object`的章節。  

## 高階函數  

* 定義： 如果一個函數，他滿足以下其中一個條件，我們就稱此函數為高階函數  
  (1) input argument也是函數  
  (2) output的東西是一個函數  

* 例如以下的函數`high_level_hello`，他的input argument也是一個函數(`hello`)：  


```python
def hello():
  print("hello!!")

def high_level_hello(func):
  func()

high_level_hello(hello)
#> hello!!
```

* 或是以下的函數`high_level_goodbye`，他的output會是一個函數(`goodbye`):  


```python
def high_level_goodbye(msg):
  def goodbye():
    print(f"goodbye!! {msg}")
  return goodbye
    
f = high_level_goodbye("hank!!")
f()
#> goodbye!! hank!!
g = high_level_goodbye("sunny!!")
g()
#> goodbye!! sunny!!
```

* 有關高階函數中，把input argument也放function的部分，請看`Function就是另一種type的object`章節    
* 有關高階函數中，把output放function的部分，請看`closure`章節  
