# string整理與實戰  

## 字串的定義  

* 可以用單引號、雙引號做定義  


```python
a = 'hank'
print(a)
#> hank
print(type(a))
#> <class 'str'>
```


```python
b = "tom"
print(b)
#> tom
print(type(b))
#> <class 'str'>
```

* 如果字串中含有單引號，那就用雙引號定義，反之亦然  


```python
a = 'tom is "good"'
print(a)
#> tom is "good"
```


```python
b = "hank is 'bad'"
print(b)
#> hank is 'bad'
```

* 如果字串中又有單引號，雙引號，那就用三個單引號做定義  


```python
c = '''
tom is "good", and hank is 'bad'
'''
print(c)
#> 
#> tom is "good", and hank is 'bad'
```

## 字串的基本操作  

### 利用`\`來定義逃脫字元  

* 例如換行是`\n`


```python
a = "abc\nabc"
a
#> 'abc\nabc'
```

* 直接打a時，他給你看原始樣貌  
* 但用print時，就會給你看顯示時的樣子  


```python
print(a)
#> abc
#> abc
```

### 把字串看成list，index時從0開始  


```python
a = "hank"
a[2]
#> 'n'
```

### 字串常用功能：去空白、改小寫、取代  

* 假設現在我有一個字串  


```python
s = ' Last Checkpoint: a few seconds ago (unsaved change) '
s
#> ' Last Checkpoint: a few seconds ago (unsaved change) '
```

* 可以發現，這個字串的最前面和最後面都有空白，蠻討厭的，可以用`.strip()`來去掉  


```python
a = s.strip()
a
#> 'Last Checkpoint: a few seconds ago (unsaved change)'
```

* 然後大小寫交錯，在NLP中也很擾人，所以全改成小寫  


```python
a = a.lower()
a
#> 'last checkpoint: a few seconds ago (unsaved change)'
```

* 最後，如果我想把"("和")"都取代成"#"，就用replace  


```python
a = a.replace("(", "#")
a
#> 'last checkpoint: a few seconds ago #unsaved change)'
```


```python
a = a.replace(")", "#")
a
#> 'last checkpoint: a few seconds ago #unsaved change#'
```

* 大功告成  
* 而實務上在做時，喜歡一條龍做下去，比較好讀：  


```python
s2 = a.strip().lower().replace("(", "#").replace("(", "#")
s2
#> 'last checkpoint: a few seconds ago #unsaved change#'
```

## 字串的format (i.e. R的paste()功能)  

* 假設我現在有兩個字串  


```python
name = 'python'
age = 27
```

* 那如果我想format出一個句子是： "我是python, 我今年27歲了"，那我可以怎麼做？  
* 在R裡面就是用paste，那現在在python裡面，就有特定的format方法  

### 直接一路加號到底  


```python
new_str = "我是" + name + "，我今年" + str(age) + "歲了"
print(new_str)
#> 我是python，我今年27歲了
```

* 恩，可以work，但這樣寫別人會把你當北七  

### 用%s, %d 來做  

* 直接看例子：  


```python
new_str_1 = "我是%s, 我今年%d歲了" % (name, age)
print(new_str_1)
#> 我是python, 我今年27歲了
```

* 裡面的`%s`的s是指string，`%d`的d是指double，所以他會宣告對應的type，然後最後再丟對應的object  
* 介紹這個只是為了知道有這種寫法而已，這是python 2時代的寫法，現在python3也沒人這樣寫了  

### 用{}和.format  

* 第一種寫法，照著位子順序定義  


```python
new_str_2 = "我是{}, 我今年{}歲了".format(name, age)
print(new_str_2)
#> 我是python, 我今年27歲了
```

* 第二種寫法，括號內定義variable再對應  


```python
new_str_3 = "我是{var1}, 我今年{var2}歲了".format(
        var1 = name,
        var2 = age
)
print(new_str_3)
#> 我是python, 我今年27歲了
```

* 這兩種寫法，是python2 ~ python 3.6的時代的寫法，的確比python2的寫法清楚多了  
* 但一樣的，也漸漸沒人這樣寫了，因為python 3.6以後，大家就都改用以下更直覺的寫法了  

### 用f吧!  


```python
new_str_4 = f"我是{name}, 我今年{age}歲了"
print(new_str_4)
#> 我是python, 我今年27歲了
```

* 太舒服了，f放在字串外面，就等於宣告他要做format，然後中括號內直接放variable，直覺阿!!!  

## 字串的join (i.e. R的collapse)  

* 剛剛介紹的format，其實就是對應到R中的paste，但R的paste還有一個很好用的功能是collapse，可以把多個字串給join在一起，例如：  


```r
a = c("I", "am", "hank")
paste(a, collapse = " ")
#> [1] "I am hank"
paste(a, collapse = "_")
#> [1] "I_am_hank"
```

* 那用python可以怎麼做呢？先示範最笨的，用for迴圈做  


```python
a = ["I", "am", "hank"]

new = ""
sep = " "
for i in a:
        new = new + i + sep
new
#> 'I am hank '
```

* 那實際在做時，是用 `.join`這個method  


```python
print(" ".join(a))
#> I am hank
print("_".join(a))
#> I_am_hank
```





