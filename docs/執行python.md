# 執行Python的code  

## 在command line執行  

* 去command line，然後打`python3`，就會進入互動視窗，然後就可以互動的執行了  
* 要結束時，再按`quit()`，就會退出視窗  

```
python3
print("Hello, World")
quit()
```

## 寫成.py檔後執行  

* 我們可以開一個script，在裡面寫code，然後存成.py檔，例如`hello.py`  
* 然後，在command line，用`python3 /path/to/this/file/hello.py`，就可以執行這個.py檔了  

## 在VS code中執行  

* 在VS code中，較常用的方法，就是寫成script，然後在下面的console，用`python3 /path/to/this/file/hello.py`這種方法執行寫好的東西  
* 逐行執行的部分，要再查一下，目前就只會在jupyter中逐行執行，但很笨  

## 在 RStudio 中執行  

* 應該要用Reticulate的架構來整理，等有空再說吧  

### 新增檔案/python script   

* 只要新增一個.py的檔案，就可以像寫R一樣逐行執行  

### 用RMarkdown  

* 開RMarkdown檔案，然後用`command + option + p`，開啟python的chunk，就可以執行了   
