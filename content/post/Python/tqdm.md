---
title: "Tqdm"
date: 2019-05-31T09:24:53+08:00
draft: false
math: false
markup: mmark
# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags: []
categories: []
# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  # Caption (optional)
  caption: ''

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point: ''
---

## tqdm

tqdm 是 python 中一个非常方便的显示进度条的工具, 可以用于循环迭代的进度显示.

```python
from tqdm import tqdm
items = range(1000)
for i in tqdm(items):
  # do something
```

![image-20190531093310204](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-31-013311.png)

在 jupyter notebook 中, 还可以使用 `tqdm_notebook` 来更美观的显示.

![image-20190531093355411](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-31-013356.png)

