# Nested Function

* 把一個function，定義在另一個function內，那這個內部的function，我們就叫nested function，或是叫inner function，或是叫helper function，或叫child function  
* 就像我們在main script上，同一種pattern的code，複製貼上三次，就會想寫一個function一樣，如果我今天在自己定義的function中，同一種pattern的code，也複製貼上三次，那我就會想寫一個inner function  
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
