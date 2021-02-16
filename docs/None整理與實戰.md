# None  

## 定義  

* 沒有value的變數，我們叫他沒有值(None)，我們可以把它想成excel中的空白，或是R中的`NULL`  
* 與他對比的叫空值，空值還是有值，只是他的值是空白  
  * `a = None`，這個a是沒有值，因為他沒有value  
  * `a = ''`，這個a是空值，因為他還是有value，他的value是空的string  
  * `a = []`，這個a也是空值，他的值是空的list  
  * `a = 0`，這個a就不是空值了，因為他的值是0  

## `is None`  

* 要確認一個變數，是None還是空值，就用`is None`做確認(就像R得`is.null()`一樣)  


```python
a = None  
print(a is None)  
#> True
b = ''
print(b is None)
#> False
```

* 或是，你用`print()`也可以發現差別：  


```python
a = None
a # 他啥都不會顯示  

b = ''  
b # 會顯示 ''
#> ''
```

## 使用時機  

* 這邊我覺得還要再補充，目前先寫下udemy舉到的應用(但我覺得不是很滿意)

### 與資料庫互動  

* 假設我們今天在和資料庫互動時，想把query後的結果存在`result`這個變數，那有可能我query後的結果，是個空值(e.g. 我查過年期間，工廠有在生產的model名稱，可能查出空集合，所以回傳給我一個空值)，也有可能我query的時候，資料庫根本沒連線成功，所以回我error  
* 那為了讓程式繼續跑下去，不要因為error而停下，那我們就會在error的時候，把query的結果定為None，那我就知道： "result = 空值"表示沒資料，"result = None"表示連線失敗  
* 見以下的程式範例：  


```python
def test_connection():
  # 寫些條件判斷，來確認有沒有順利和DB連接上
  # 有的話，回傳True
  # 現在先假設判斷完的結果是True
  return True

def get():
  # 寫個statement，去DB中抓取我要的user名單
  # 例如這兩天有登入我們網站的人員名單
  # 那假設抓完的結果，就很不巧，沒有條件符合，所以是： []  
  return []

def get_user_list():
  # 完整的抓user名單的function
  # 會先判斷DB有沒有連線成功，有的話，才抓
  if not test_connection():
    return None
  else:
    return get()
```

* 接下來，開始使用這個function了，我們想回傳給user訊息：  
  * 如果連線成功，回傳query到的結果  
  * 如果連線失敗，回傳"connection error"  


```python
query_result = get_user_list()
if query_result is None:
  print("connection error")
else:
  print("user list: ", query_result)
#> user list:  []
```

