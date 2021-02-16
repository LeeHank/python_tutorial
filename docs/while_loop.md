# while loop    

## while 寫法  


```python
a = 10
while a > 5:
  print(f"'a' is {a} currently")
  a -= 1
#> 'a' is 10 currently
#> 'a' is 9 currently
#> 'a' is 8 currently
#> 'a' is 7 currently
#> 'a' is 6 currently
print('end')
#> end
```

## 確認每次都有更新內容  

* while最怕的就是無限迴圈，所以寫while時，條件中的內容，在每次的循環中，通常都會更新，例如以下：  


```python
a = 10
while a > 5:
  print(a)
  a = a - 1 # 若沒做這個更新，那就會陷入無限迴圈  
#> 10
#> 9
#> 8
#> 7
#> 6
print('end')
#> end
```

## 善用`break`  

* 為了避免進入無限迴圈，while裡面也常常加入`break`，來強制停止它  
* 例如做參數更新時，可能可以寫成以下這樣：  


```python
i = 0
est_value = 10
true_value = 10000
while true_value - est_value > 0.01:
  est_value +=1
  i +=1
  if i == 100:
    break

print(est_value)
#> 110
print(i)
#> 100
```
