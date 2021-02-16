# isinstance, equality, 與 string representation  

## `type` 與 `isinstance` 

* 之前已經用過很多次`type()`，例如下例：  


```python
a = [1,2]
print(type(a))
#> <class 'list'>
```

* 可以看到，顯示出來的type是`list`  
* 而且，我們終於看懂前面的`class`是什麼意思了：在python中萬物都是object，所以你去問一個object的type，就是在問他的class是誰拉！！  
* 那現在多教一個指令，叫`isinstance()`，他的用法如下：  


```python
a = [1,2]
print(isinstance(a, list))
#> True
```

* 所以蠻好懂的，第一個argument就是放你要驗證的object(e.g. 此例的`a`)，第二個argument就是去看看他是不是這個class的instance  
* 再來個練習，我自己寫的class，用type會長怎樣： 


```python
class A:
  pass

a = A()
print(type(a))
#> <class '__main__.A'>
```

* cool，他的type就是A。那用用看`isinstance`  


```python
print(isinstance(a, A))
#> True
```

### 繼承與isinstance  

* 重點來了，如果今天有繼承的話，那子類的instance，也會是父類的instance  


```python
class A:
  pass

class B(A):
  pass

a = A()
b = B()

print(type(b))
#> <class '__main__.B'>
print(isinstance(b, B))
#> True
print(isinstance(b, A))
#> True
print(type(a))
#> <class '__main__.A'>
print(isinstance(a, A))
#> True
print(isinstance(a, B))
#> False
```

* 可以明顯看到，雖然b的type是B，但在判斷instance時，他仍是A的instance!!  
* 因為我們要判斷b是不是A的instance時，就是看A的instance該有的attribute和method他是不是都有。而因為B繼承A，所以A有的，B都有，B做出來的instance全都繼承過去了，所以他仍是A的instance  
* 但a就不會是B的instance了，道理很簡單，B的instance該有的attribute和method，a未必都有(因為B就是繼承A後，要加了他獨有的attribute和methods)



## `__eq__` (object equality)  

-   用我們現在學到的方法來寫class的話，會碰到以下問題：兩個instance的attribute完全相同，但比較結果卻說不同：


```python
class Customer:
  def __init__(self, name, id):
    self.name = name
    self.id = id

cust1 = Customer("Hank", 19002329)
cust2 = Customer("Hank", 19002329)

cust1 == cust2
#> False
```

-   為什麼會這樣？因為在比相不相同時，是比記憶體位置一不一樣：


```python
print(cust1)
#> <__main__.Customer object at 0x12c611e80>
print(cust2)
#> <__main__.Customer object at 0x12c611760>
```

-   很明顯的看到，兩個記憶體位置不同，所以才說不相等\
-   聽起來很合理，但很難用啊，兩個object的attribute相同，我就希望他們比較的結果是一樣啊。\
-   其實python內建的class，就有做這種處理了，比如說：


```python
import numpy as np
a = np.array([1])
b = np.array([1])
id(a)
#> 5039547936
id(b)
#> 5039548016
print(a == b)
#> [ True]
```

-   可以看到，兩個object的記憶體位置不同，但比較結果是True，這怎麼辦到的？\
-   這其實就是要多寫一個"equality constructor"。對比於"initial constructor"是`__init__(self, ...)`，這個equality constructor是寫成`__eq__(self, other)`，其中"self", "other"就是固定的參數，不要去換\
-   寫法如下：


```python
class Customer:
  def __init__(self, name, id):
    self.name = name
    self.id = id
  def __eq__(self, other):
    print("__eq__() is called")
    return (self.name == other.name) & (self.id == other.id)

cust1 = Customer("Hank", 19002329)
cust2 = Customer("Hank", 19002329)

cust1 == cust2
#> __eq__() is called
#> True
```

-   這邊就看到，我們得條件是，兩個比較的instance的name和id若完全相同，我就認定他是equal的。裡面的self和other就各指稱兩個instance，最後的return結果一定要是True/Fale。

-   除了equality operator外，其實還有其他的comparison，比如：

    | Operator | Method                                |
    |----------|---------------------------------------|
    | ==       | \`\_\_eq\_\_\`: equal                 |
    | !=       | \`\_\_ne\_\_\`: not equal             |
    | \>=      | \`\_\_ge\_\_\`: greater or equal than |
    | \<=      | \`\_\_le\_\_\`: less or equal than    |
    | \>       | \`\_\_gt\_\_\`: greater than          |
    | \<       | \`\_\_lt\_\_\`: less than             |

-   接下來講兩個細節：

    -   不同class的instance，能不能比啊？會錯亂嗎？\
    -   Parent class的instance和Child class的instance在比時，用誰的equality constructor？

-   先講答案，第一點是，只要equality constructor一樣，就可以比，所以會造錯亂。解決方式是，再多比一個`type(self)==type(other)`就好\

-   第二點的答案是，always用child class的equality constructor

-   先來看第一點的範例吧


```python
class Buyer:
  def __init__(self, number):
    self.number = number
    
  def __eq__(self, other):
    return self.number == other.number

class Phone:
  def __init__(self, number):
    self.number = number
    
  def __eq__(self, other):
    return self.number == other.number
    
buyer1 = Buyer(19002329)
phone_number = Phone(19002329)

buyer1 == phone_number
#> True
```

-   我建了兩個class，第一個是客戶的class，他的attribute是number，指的是他的編號；第二個是電話號碼的class，他的attribute也是number，但指的是電話號碼。結果這兩個不一樣的東西，就剛好都有number，就被比成一樣了。\
-   所以實務上在比較時，equality constructor，都會再加上type的條件：


```python
type(buyer1)
#> <class '__main__.Buyer'>
type(phone_number)
#> <class '__main__.Phone'>
```


```python
class Buyer:
  def __init__(self, number):
    self.number = number
    
  def __eq__(self, other):
    return (self.number == other.number) & (type(self)==type(other))

class Phone:
  def __init__(self, number):
    self.number = number
    
  def __eq__(self, other):
    return (self.number == other.number) & (type(self)==type(other))
    
buyer1 = Buyer(19002329)
phone_number = Phone(19002329)

buyer1 == phone_number
#> False
```

-   接著就講到parent class和child class的比較。always用child class的equality constructor：


```python
class Parent:
    def __eq__(self, other):
        print("Parent's __eq__() called")
        return True

class Child(Parent):
    def __eq__(self, other):
        print("Child's __eq__() called")
        return True

p = Parent()
c = Child()

p == c 
#> Child's __eq__() called
#> True
```

## `__str__`與`__repr__`  

-   接下來的議題，是有關object的printing\
-   我們目前對class的寫法，會讓我們每次去print一個instance的時候，他都只給我們記憶體位置，例如：


```python
class salary:
  def __init__(self, number):
    self.number = number

my_salary = salary(22000)
print(my_salary)
#> <__main__.salary object at 0x12c618df0>
```

-   damn...這麼簡單的class，我當然希望他直接print 22K給我看啊\
-   Python其他內建的class，都有做這種處理，不信你看numpy的instance:


```python
import numpy as np
a = np.array([1,2,3])
print(a)
#> [1 2 3]
```

-   為什麼勒？因為python有兩種constructor，一個叫`__str__`，一個叫`__repr__`

    -   定義在`__str__`內的東西，是要給end user看的，是informal的資訊，可以藉由`print()`和`str()`看到這些較親民的訊息\
    -   定義在`__repr__`內的東西，是要給developer看的，是formal的資訊，他會告訴你type, 記憶體位置等資訊，可以藉由直接key object name，或是`repr()`來取得。不信你直接call numpy的object看看，他就會送你array訊息


```python
a
#> array([1, 2, 3])
```

-   那現在回頭寫我剛剛的salary class:


```python
class salary:
  def __init__(self, number):
    self.number = number
  
  def __str__(self):
    return str(self.number)
  
  def __repr__(self):
    return f"Salary({self.number})"

my_salary = salary(22000)
print(my_salary)
#> 22000
my_salary
#> Salary(22000)
```

