# Class-level vs Instance-level  

## Instance-level attribute vs Class-level attribute  

### 簡介`實例屬性`與`類屬性`  

* 首先我們看一下這個例子：  


```python
class Student:
  
  count = 0 # class-level attribute
  
  def __init__(self, name):
    self.name = name # instance-level attribute
```

* 在這個例子中，`self.name`叫做instance-level attribute(實例屬性)，因為他有一個instance的代名詞`self`放在前面，我們在調用這個attribute時，都是先寫instance name，才寫此屬性，例如：  


```python
hank = Student(name = "hank")
print(hank.name)
#> hank
```

* 而`count`叫做class-level attribute，他前面沒有擺`self`，所以他是屬於Class下面的屬性，而不是屬於self下面的屬性。在調用這個attribute時，要先寫class name，才寫此屬性，例如：  


```python
print(Student.count)
#> 0
```

### `實例屬性`可以繼承`類屬性`  

* 那由於階層上是class為第一層，instance為第二層，所以instance會繼承class的屬性，但class不會有instance的屬性：  


```python
# class下，沒有name這個屬性，要instance下才會有
print(Student.name)
# instance會繼承class的屬性，所以還是看得到count
#> Error in py_call_impl(callable, dots$args, dots$keywords): AttributeError: type object 'Student' has no attribute 'name'
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
print(hank.count)
#> 0
```

### `實例屬性`與`類屬性`的修改    

* 剛剛講到，instance會繼承class的attribute:  


```python
print(Student.count)
#> 0
print(hank.count)
#> 0
```

* `Student.count`是在講Student這個抽象的類別，他所屬的count。我們覺得，不管是哪個學生(hank or aaron or sunny...)，只要是學生，一開始的count應該都是0  
* 所以，我們realize一個instance叫做hank時，`hank.count`就繼承了這個student的class給他的count，現在`hank.count`已經是hank專屬的count了。  
* 那可以想像，如果我去修改instance中的count(e.g. 這邊的`hank.count`)，那就只是修改instance中的count，不會影響到class的count:  


```python
print(Student.count)
#> 0
print(hank.count)
#> 0
hank.count = 1

print(Student.count)
#> 0
print(hank.count)
#> 1
```

* 我也可以想像，如果我去改class中的count，並不會影響到instance中的count。因為改class中的count，等於只是改模板，他只會影響到"之後"我創建出來的instance而已：  


```python
print(Student.count)
#> 0
print(hank.count)
#> 1
Student.count = 100

print(Student.count)
#> 100
print(hank.count)
#> 1
sunny = Student(name = 'sunny')
print(sunny.count)
#> 100
```

### `類屬性`用在哪  

* 對於instance-level attribute(實例屬性)我們蠻熟了，他主要就是給method做使用。那class-level attribute是用在哪呢？這邊舉兩個實例：  

#### 統計這個class被用過幾次  

* 有時候我們會想統計一下，某個class被實體化過幾次，那就可以像下面這樣寫：  


```python
class Student:
  count = 0
  def __init__(self, name):
    Student.count = Student.count + 1
    self.name = name
```

* 從上面這段code，可以看到我們把`Student.count = Student.count + 1`放在`__init__`的下面。那每次在實體化一個instance時，count數就會增加：  


```python
s1 = Student("A")
s2 = Student("B")
s3 = Student("C")

print(Student.count)
#> 3
```

#### 跨instance都應該一樣的特徵  

* 舉例來說，今天我要做一個Employee的class，裡面有個attribute叫`MIN_SALARY`。那這個最低薪資，其實是法律規範的22k，只要你是員工，不管你叫阿貓還是阿狗，最低薪資都應該一樣。那這種attribute我們就會寫在class下面。  
* 這樣做的一個優點是省力，另一個優點是可以幫我們做卡控: 以下舉個例子，當我們實體化一個employee時，要輸入該員工的name與salary。但只要這個salary小於MIN_SALARY，我就要用MIN_SALARY做取代：  


```python
class Employee:
  MIN_SALARY = 22000
  def __init__(self, name, salary):
    self.name = name
    if salary < Employee.MIN_SALARY:
      print("Please respect people. The salary you give is lower than 22K !!")
      self.salary = Employee.MIN_SALARY
    else:
      self.salary = salary
```


* 來做個實驗吧：  


```python
sunny = Employee(name = "sunny", salary = 10000)
#> Please respect people. The salary you give is lower than 22K !!
print(sunny.salary)
#> 22000
hank = Employee(name = "sunny", salary = 60000)
print(hank.salary)
#> 60000
```

## Instance-level method vs Class-level method  



### 簡介`類方法`和`實例方法`  

* 首先我們複習一下實例方法(instance-level method)  


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
  
  def sayhi(self, v1):
    return(f"Hi, my name is {self.name}, and I'm {self.age} year's old. {v1} is here")
  
  def sayhi2(self, v1):
    res = self.sayhi(v1)
    return(res)
```

* 裡面的`sayhi(self, v1)`就是一實例方法，因為他需要傳入`self`這個參數，好讓他在method裡面可以呼叫`self.name`, `self.age`這兩個instance-level attribute  
* 而`sayhi2(self, v1)`同樣是個實例方法，這邊就顯示我們要呼叫實例方法時，也得用self，如同這邊用到`self.sayhi`這個method  
* 那舉一反三，class-level method，傳入的參數就該從`self`改成`class`? 答案很接近了，用的參數名稱叫`cls`而不是`class`。而且，還要在定義method的前面，加個decorator: `@classmethod`  
* 看例子：  


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
  
  def sayhi(self, v1):
    return(f"Hi, my name is {self.name}, and I'm {self.age} year's old. {v1} is here")
  
  def sayhi2(self, v1):
    res = self.sayhi(v1)
    return(res)
  
  @classmethod
  def test1(cls):
    return("這是一個類方法")
```

* 那定義好這個`類方法`後，我們從外部就不需要先realize一個instance，就可以用這個方法了:  


```python
print(People.test1())
#> 這是一個類方法
```

* 而且，如同實例屬性會繼承類屬性一樣，實例方法也會繼承類方法，所以當我realize一個instance後，我還是可以調用這個method:  


```python
p1 = People(name = "hank", age = 28)
print(p1.test1())
#> 這是一個類方法
```

* 那最後講一下，instance-level method時，你傳入`self`參數，是為了用`self.name`, `self.age`這些instance-level attribute，或是用`self.sayhi()`這種instance-level method。那class-level method時，你傳入`cls`參數，是為了調用`cls.XXX`的class-level attribute嗎？  
* 顯然不是，因為class-level attribute的調用，是用`{class名稱}.{attribute名稱}`。所以，`cls`參數要調用的，是其他class method!!  
* 例如下例： 


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
  
  def sayhi(self, v1):
    return(f"Hi, my name is {self.name}, and I'm {self.age} year's old. {v1} is here")
  
  def sayhi2(self, v1):
    res = self.sayhi(v1)
    return(res)
  
  @classmethod
  def test1(cls):
    return("這是一個類方法")
  
  @classmethod
  def test2(cls):
    res = cls.test1()
    return(res)
  
```

* 從這個例子可以看到，我的`test2`，調用了`cls.test1`這個class-level method。來看看結果對不對：  


```python
print(People.test2())
#> 這是一個類方法
```

* 最後，我們無法在類方法中，去調用實例方法。例如我現在寫個test3，裡面想要調用self.sayhi  


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
  
  def sayhi(self, v1):
    return(f"Hi, my name is {self.name}, and I'm {self.age} year's old. {v1} is here")
  
  def sayhi2(self, v1):
    res = self.sayhi(v1)
    return(res)
  
  @classmethod
  def test1(cls):
    return("這是一個類方法")
  
  @classmethod
  def test2(cls):
    res = cls.test1()
    return(res)
  
  @classmethod
  def test3(cls, v1):
    res = self.sayhi(v1)
    return(res)
```

* 實驗一下：  


```python
print(People.test3(v1 = "hahaha"))
#> Error in py_call_impl(callable, dots$args, dots$keywords): NameError: name 'self' is not defined
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
#>   File "<string>", line 24, in test3
```

* 如同預期，報error了，而且error message也很合理：沒找到self拉！啊廢話，你這是class-level method，給的參數是`cls`又不是`self`，當然無法去吃`self.sayhi()`這個instance-level method  
* 而且，就算你實體化這個class，還是不能調用`self.sayhi()`，因為你的`self`從頭到尾都沒被當作參數丟入`test3`裡面：  


```python
p2 = People(name = "hank", age = 28)
p2.test3(v1 = "hahaha")
#> Error in py_call_impl(callable, dots$args, dots$keywords): NameError: name 'self' is not defined
#> 
#> Detailed traceback: 
#>   File "<string>", line 1, in <module>
#>   File "<string>", line 24, in test3
```

### 實例屬性的使用時機  

-   那到底class method可以拿來幹麻？其實最常是拿來作為initialize instance的另一種方式，例如，我的class如果本來要initialize一個instance時，要輸入year, month, day這三個參數，但我現在希望提供另一種initialize的方式，是直接給字串(e.g. "2020-10-20")就好，我該怎麼做？只有一個`__init__`可以用，又不能寫兩個，這時候，就會用class method\
-   直接看例子。今天我想寫一個class叫`BetterDate`，有year, month, day三個attribute。那我現在想寫一個class method，只要給字串，我一樣initialize instance給你：


```python
class BetterDate:    
    # Constructor
    def __init__(self, year, month, day):
      # Recall that Python allows multiple variable assignments in one line
      self.year, self.month, self.day = year, month, day
    
    # Define a class method from_str
    @classmethod
    def from_str(cls, datestr):
        # Split the string at "-" and convert each part to integer
        parts = datestr.split("-")
        year, month, day = int(parts[0]), int(parts[1]), int(parts[2])
        # Return the class instance
        return cls(year, month, day)
```

-   注意到最後的`cls(year, month, day)`，他的意思就是會把這三個參數傳回`__init__`來initialize instance的意思。所以，現在試試看結果：


```python
bd = BetterDate.from_str('2020-04-30')   
print(bd.year)
#> 2020
print(bd.month)
#> 4
print(bd.day)
#> 30
```

## 小結  

* 剛剛講了類屬性和實例屬性，我們學到類屬性在實體化之前就可以調用，調用的方式是`{class名稱}.{attribute名稱}`
* 類屬性當然也可以在class的內部去調用它，一樣是用`{class名稱}.{attribute名稱}`  
* 實例屬性，在內部的調用是用`self.{attribute名稱}`，因為在內部時還不知道實體化後的名稱，所以都用`self`來當代名詞  
* 實例屬性，在外部的調用是用`{instance名稱}.{attribute名稱}`  
* 類方法和實例方法概念也都一樣：  
  * 實例方法：內部的調用是用`self.{method名稱}(參數)`，外部的調用是`{instance名稱}.{method名稱}(參數)`  
  * 類方法：內部的調用適用`cls.{method名稱}(參數)`，外部調用是`{class名稱}.{method名稱}(參數)`

