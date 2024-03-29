# Attribute Protection   

* 這節要來講如何保護我們的attribute，更精確的說，是保護`instance-level attribute`  
* 要做到實例屬性的保護，由淺至深可分為以下四種：  
  * [放任型] 開發者啥都不做，user想做啥都可以。   
  * [信任型] 我希望initialize後，提醒你這些屬性小心使用，盡量不要修改  
  * [中庸型] 我希望initialize後，你要改屬性，要先經過我的審核機制才能改： 用decorator(@property, setter)  
  * [嚴父型] 我希望initialize後，你不准修改和查詢屬性：那就用私有屬性的做法，我也不給你set和get method。  

## Naming Convention  

* 在python中，instance-level attribute的命名是有慣例的(naming convention)：  
  * 一般的變數型態，表不保護，user想做啥都可以。這被我歸類在[放任型]    
  * 單底線開頭，表受保護屬性，用來**提醒**user，不要調用和修改。但只有提醒功能，user還是可用可改。這被我歸類在[信任型]  
  * 雙底線開頭，表私有屬性(private variable)，這種命名規則會**告訴**系統，這個attribute只給class在內部使用，不讓user從外部去**找到**和**使用**這個屬性。這被我歸類在[嚴父型]。那如果再搭配可用來修改的decorator(e.g. `@property`, `.setter`)，就被我歸類為[中庸型]  

## [放任型] 不保護  



## [信任型] 用單底線提醒  

* 以下我們舉個例子，此例我要在`__init__()`裡面，加上一個受保護的屬性，叫做`._protect_var`  


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
    # 受保護屬性，用單底線開頭，提醒user不要用不要改
    self._protect_var = 10
```

* 這樣的做法，用意只是**提醒**user，這個屬性你不要用，也不要改。但他只有提醒功能，如果user要用要改，都還是可以做到：  


```python
someone = People(name = "hank", age = "28")

# user還是可以調用這個屬性
print(someone._protect_var)
# user還是可以修改這個屬性
#> 10
someone._protect_var = 20
print(someone._protect_var)
#> 20
```


## [嚴父型] 用雙底線不給動  

* 接下來我們舉雙底線開頭的例子，下例中我們新增一個`.__private_var`的私有屬性：  


```python
class People:
  def __init__(self, name, age):
    self.name = name
    self.age = age
    self._protect_var = 10
    # 私有屬性用雙底線開頭，只能在class內部使用
    self.__private_var = 10
  
  def show_private(self):
    return(self.__private_var)
```

* 這樣做以後，如果user從外部要調用這個屬性，會得到error  
* 但如果我們寫個method來調用這個屬性就ok，因為private variable就是專for class內部使用的


```python
someone = People(name = "hank", age = "28")
print(someone.__private_var)
#> Error in py_call_impl(callable, dots$args, dots$keywords): AttributeError: 'People' object has no attribute '__private_var'
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
print(someone.show_private())
#> 10
```

* 那為什麼我們不能用`someone.__private_var`這個指令？我們可以用`dir()`來看一下有哪些attribute/method可以用：  


```python
print(dir(someone))
#> ['_People__private_var', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_protect_var', 'age', 'name', 'show_private']
```

* 從上面可以看到，我們可以用的屬性和method中，有看到我定義的保護屬性`_protect_var`，但根本沒出現我定義的私有屬性`__priate_var`，所以，當你用`someone.__private_var`，python才會跟你說，沒有這個attribute或method  
* 但，你可以看到第一個attribute的名稱叫：`_People__private_var`，表示，python是自動幫你把private variabe和class名稱給黏在一起，變成一個新的attribute供user調用，所以其實user還是可以藉由這個方法，取得和修改private variable  


```python
print(someone._People__private_var)
#> 10
someone._People__private_var = 30
print(someone._People__private_var)
#> 30
```

* 所以講白了，python的理念，還是給user很大的自由度。即使是最嚴格的類型，user還是可以找到方法去修改。  
* 最後，來釐清個觀念：user不能調用`someone.__private_var`，但卻可以藉由這種方式修改(`someone.__private_var = xxx`)!?  


```python
print(someone.__private_var) # 會報error
#> Error in py_call_impl(callable, dots$args, dots$keywords): AttributeError: 'People' object has no attribute '__private_var'
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
someone.__private_var = 40 # 不會報error
```

* 看起來好像做到修改了，但其實，這樣做是在"新增"一個attribute，而不是"修改"我們舊有的私有屬性，我們看系統內部在讀`self.__private`是讀到誰就知道了：  


```python
print(someone.show_private())
#> 30
```

* 我們發現，系統讀到的還是舊的`.__private_var`(40)，而不是剛剛assign的這筆(30)  
* 因為`someone.__private_var = 40`的意思，其實是create了一個新attribute給這個instance，只是他的名稱剛好也叫`.__private_var`而已。但系統在讀`self.__private_var`時，還是讀一開始設好的那個`.__private_var`    
* 也因為剛剛這種直接assign attribute的做法，讓我們現在可以直接調用這筆新增的`.__private_var`了  


```python
someone.__private_var
#> 40
```

## [中庸型] 雙底線 + `@property` + `.setter`  

* 有時候，我們設private variable，並不是不讓別人修改，而是希望別人修改的時候，能符合我們設定好的遊戲規則  
* 如果要做到這個，我們就會用以下的寫法來做  
* 首先介紹old-school的做法(加入get和set的method)，因為比較好理解到底在做什麼。但這種寫法沒人再寫了，所以我們還是要學標準版的寫法：加decorator的寫法  

### old-school 作法  

* 假設我們要寫一個People的class，在initialize的時候，會用到name和age兩個attribute，而我們希望user initialize後，就盡可能不要改他。那我們會寫成這樣：  


```python
class People:
  def __init__(self, name, age):
    self.__name = name
    self.__age = age

hank = People(name = "hank", age = 28)
print(hank.name)
#> Error in py_call_impl(callable, dots$args, dots$keywords): AttributeError: 'People' object has no attribute 'name'
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
print(hank.age)
#> Error in py_call_impl(callable, dots$args, dots$keywords): AttributeError: 'People' object has no attribute 'age'
#> 
#> Detailed traceback:
#>   File "<string>", line 1, in <module>
```

* 可以看到，name和age現在都無法調用了  
* 那如果，我可以允許user做修改，但必須符合我的遊戲規則，那我可以寫個get和set method來卡空：    


```python
class People:
  def __init__(self, name, age):
    self.__name = name
    self.__age = age
  
  def get_name(self):
    return self.__name  
  def set_name(self, new_name):
    if type(new_name) is str:
      self.__name = new_name
    else:
      print("new_name should be the type of string.")
  
  def get_age(self):
    return self.__age  
  def set_age(self, new_age):
    if type(new_age) is int:
      self.__age = new_age
    else:
      print("new_age should be the type of integer.")
```

* 有了set這道防線後，user就不能亂設attribute了：  


```python
hank = People(name = "hank", age = "28")

print(hank.get_name())
#> hank
hank.set_name(12345)
#> new_name should be the type of string.
print(hank.get_name())
#> hank
hank.set_name("hank lee")
print(hank.get_name())
#> hank lee
```

* 由此例可以發現，我們新增兩個方法讓user去調用(i.e. get_name)和修改(i.e. set_name)  
* 藉由這種不便利性，來減少user去使用和修改這些private variable的頻率，也藉由寫method，加入一些卡空機制進去    

### 正規作法  

* 那正規作法，其實是把`get_name()`和`get_age()`這兩個method，換成`@property`的寫法，見下例：  


```python
class People:
  def __init__(self, name, age):
    self.__name = name
    self.__age = age
  
  # def get_name(self):
  #   return self.__name
  @property
  def name(self):
    return self.__name
  
  # def get_age(self):
  #   return self.__age  
  @property
  def age(self):
    return self.__age
```

* 由這種寫法可以發現，我們加`@property`這個decorator在method的上面，用來宣告說我要使用property的功能。然後底下用來取代`get_name` method的東西，要直接用private variable的名稱，所以會是`name`或`age`  
* 那這種寫法的好處是，user現在可以用熟悉的`{instance名稱}.{attribute名稱}`來調用這些private variable，不用再寫`get_name()`或`get_age()`    


```python
hank = People(name = "hank", age = 28)
print(hank.name)
#> hank
print(hank.age)
#> 28
```

* 從此例也可看出，我們剛剛寫的`name`和`age`兩個method，再加上`@property`後，他就不再是method了(你看我是用`hank.name`來取得name，而不是用`hank.name()`來取得name，但我在class中，`name()`明明是以method的方式存在的，我還有return勒！)  

* 再來，我們要改造`set_name()`這個method，也是用decorator(`xx.setter`)，見下例:


```python
class People:
  def __init__(self, name, age):
    self.__name = name
    self.__age = age
  
  @property
  def name(self):
    return self.__name
  
  # def set_name(self, new_name):
  #   if type(new_name) is str:
  #     self.__name = new_name
  #   else:
  #     print("new_name should be the type of string.")
  @name.setter
  def name(self, new_name):
    if type(new_name) is str:
      self.__name = new_name
    else:
      print("new_name should be the type of string.")
  
  
  @property
  def age(self):
    return self.__age
  
  # def set_age(self, new_age):
  #   if type(new_age) is int:
  #     self.__age = new_age
  #   else:
  #     print("new_age should be the type of integer.")
  @age.setter
  def age(self, new_age):
    if type(new_age) is int:
      self.__age = new_age
    else:
      print("new_age should be the type of integer.")
  
  
```

* 可以看到，差別就是加上`name.setter`和`age.setter`，然後method name維持原來的private variable name  
* 來試試看能不能work   


```python
hank = People(name = "hank", age = "28")

print(hank.name)
#> hank
hank.name = 12345
#> new_name should be the type of string.
print(hank.name)
#> hank
hank.name = "hank lee"
print(hank.name)
#> hank lee
```

* 可以發現，可以work  
* 而且，藉由decorator，我們又把method變成attribute了。注意到現在是寫`hank.name = 12345`，就會跑我定義的method並檢查合法性，而不是寫`hank.name(12345)`。  
* 所以，這樣做，可以讓user用起來更直覺的同時，又兼顧到資料的正確性  

