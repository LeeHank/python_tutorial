# Nested Function and closure  

* nested function蠻簡單的，就是一個function中，又定義了另一個function  
* closure的意思則是，一個function要return的東西，不是一個值，而是另一個function  

## Nested function

* 就像我們在main script上，同一種pattern的code，複製貼上三次，就會想寫一個function一樣，如果我今天在自己定義的function中，同一種pattern的code，也複製貼上三次，那我就會想寫一個inner function\
* 這個inner function，就叫nested function
* 先來看醜醜的例子：  


```python
def mult2plus5(x1, x2, x3):
    """multiply 2 thenplus 5 for input three values."""
    new_x1 = x1 * 2 + 5
    new_x2 = x2 * 2 + 5
    new_x3 = x3 * 2 + 5
    return (new_x1, new_x2, new_x3)

print(mult2plus5(2,3,4))
#> (9, 11, 13)
```

* 改寫成nested function的例子  


```python
def mult2plus5_nested(x1, x2, x3):
    
    def inner(x):
      value = x*2 + 5
      return value
    
    return (inner(x1), inner(x2), inner(x3))

print(mult2plus5_nested(2,3,4))    
#> (9, 11, 13)
```

* 所以nested function的主要用途，就是節省力氣拉，沒什麼特別的  

## Closure

* 剛剛示範了nested function，他被用來簡化原function內部的計算。但原function所output的東西，還是一般的value(在上例中，是tuple)\
* 但很酷的是，你也可以output出這個nested function。\
* 這種output也是function的function，在CS中，被稱為closure\
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
* 此外，Closure的更重要的好處是，一般的funciton，你定義完，執行後，他在local scope的資訊都無法調用了; 但是，如果今天是closure，他還可以"記得"enclosing function scope中的定義過的東西。
