# for loop    

## 寫法  


```python
for i in range(10):
  print(i)
#> 0
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
```

## 善用break終止迴圈  

* 直接看例子：  


```python
for i in range(10):
  if i < 5:
    print(i)
  else:
    print(f"i = {i}, value >=5, stop!!")
    break
#> 0
#> 1
#> 2
#> 3
#> 4
#> i = 5, value >=5, stop!!
```

## 善用continue跳入下一個迴圈  

* 有時候我們不希望直接跳出迴圈，而是ignore這一圈，直接進入下一圈，例如下例：  


```python
for i in range(10):
  if i % 2 == 0: # 除以2的餘數==0
    continue
  print(i)
#> 1
#> 3
#> 5
#> 7
#> 9
```


