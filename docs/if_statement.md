# If statement  

* if在python中有三種寫法  
  * if...
  * if...else...
  * if...elif...else...  
  * 一行的if  
  * 一行的if...else...

## if...  


```python
a = 88
if a > 8:
  print('yeah')
#> yeah
```

## if...else...  


```python
a = 7
if a > 8:
  print('yeah')
else:
  print('no')
#> no
```

## if...elif...else...


```python
a = 200
b = 33
if b > a:
  print("b is greater than a")
elif a == b:
  print("a and b are equal")
else:
  print("a is greater than b")
#> a is greater than b
```

## 一行的if  


```python
a = 200
b = 33
if a > b: print("a is greater than b") # 就是不要換行就好，其他不變
#> a is greater than b
```

## 一行的if...else...  

* 這招在list comprehension時又會用到，訣竅就是要倒裝： 做這個 if這樣，不然(else)就做那個...


```python
a = 2
b = 330
print("A") if a > b else print("B")
#> B
```

## 善用pass  

* 這個技巧也可以學一下，`if`裡面不可以是空的，但如果因為some reason，你就是需要寫if，那你就塞一個`pass`在裡面，就不會報error了  


```python
a = 33
b = 200

if b > a:
  pass
```

## if 條件太多時，怎麼優化  

* 我覺得這邊可以補充"地表最簡單Python"那門課的練習，有講到寫多個if時比較好的做法  







