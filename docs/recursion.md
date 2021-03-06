# recursion  

* recursion(遞迴)在programming中的意思是：`在函數中，呼叫函數自己`，比如這樣：  


```python
def my_func(num):
  3 + my_func(num)
```

* 寫recursion時要很小心，因為他是個雙面刃：  
  * 寫的好：code很簡潔，執行效率又高  
  * 寫不好：無限迴圈無法停止(如上例)，耗費所有電腦資源  
  
* recursion有兩個經典例子，一個是`n!的計算`，另一個是`費氏數列`，我們來看看：  

## n! 計算  

* 如果今天想做個n!的function，我們可以用for來做  


```python
def test(n):
  result = 1
  for item in range(1, n+1):
    result = result * item
  return result

test(3)
#> 6
```

* 但如果你用recursion，就會很簡單  


```python
def test2(n):
  if n == 1:
    return n
  else:
    return n * test2(n-1)


print(test2(3))
#> 6
```

* 我們先看recursion的第一個重點，也就是`n * test2(n-1)`這一行  
* 所以當我輸入n=3時，他會做`3 * test2(2)` = `3 * 2 * test2(1)` = `3*2*1*test2(0)` = `3*2*1*0*test2(-1)` = ...  
* 看起來，前面都做對了，但等到`test2(0)`時就錯了  
* 所以，recursion會需要加上`何時跳出`這個條件。所以前面加了`if n == 1: return n`，那上面的遞迴式，就變成: `3 * test2(2)` = `3 * 2 * test2(1)` = `3*2*1` ，沒辦法再遞迴了，結束在這  

## 費氏數列  

* 費氏數列的定義是:  
  * $a_1 = 0, \ a_2 = 1$
  * $a_n = a_{n-1} + a_{n-2}$，for n >3
  * 也就是前兩項是0,1，之後各項的值，是前兩項的和。  
  * 比如說： 0, 1, 1, 2, 3, 5, 8, ...  
* 那我想寫一個function，告訴我第k項的值是多少：  


```python
def fibo(k):
  if k == 1:
    return 0
  elif k == 2:
    return 1
  else:
    return fibo(k-1) + fibo(k-2)

print(fibo(5))
#> 3
```

