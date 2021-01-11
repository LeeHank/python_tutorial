import numpy as np

def my_max(*args):
  print("最大值是" + str(np.max(np.array(args))))

def my_min(*args):
  print("最小值是" + str(np.min(np.array(args))))
  
class People:
  def __index__(self, name, age):
    self.name = name
    self.age = age

MAX_NUM = 100
