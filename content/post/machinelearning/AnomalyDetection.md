---
title: "Anomaly Detection"
date: 2019-05-26T20:59:20+08:00
draft: false
math: true
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

## Gaussian (Normal) Distribution

Say $x\in R$. If $x$ is a distributed Gaussian with mean $\mu$, variance $\sigma^2$.

$$
x \sim N(\mu, \sigma^2)
$$

$$
p(x;\mu, \sigma^2) = \frac{1}{\sqrt{2\pi}\sigma}\exp(-\frac{(x - \mu)^2}{2\sigma^2})
$$

### Parameter estimation

We have a dataset: $\{x^{(1)}, x^{(2)}, \dots, x^{(m)}\}, x^{(i)}\in R$

We can say that $x \sim N(\mu, \sigma^2)$. We here need to estimate what the value of $\mu$ and $\sigma^2$.

$$
\mu = \frac{1}{m}\sum_{i=1}^m x^{(i)}
$$

$$
\sigma^2 = \frac{1}{m}\sum_{i=1}^m(x^{(i)} - \mu)^2
$$

* Maximum likelihood estimates.

## Anomaly detection algorithm

1. Choose features $x_i$ that you think might be indicative of anomalous examples.

2. Fit parameters $\mu_1, \dots, \mu_n, \sigma_1^2, \dots, \sigma_n^2$.

   $$
   \mu_j = \frac{1}{m}\sum_{i=1}^m x_j^{(i)}
   $$
   
   $$
   \sigma_j^2 = \frac{1}{m}\sum_{i=1}^m(x_j^{(i)} - \mu_j)^2
   $$
   
3. Given new example $x$, compute $p(x)$:

   $$
   p(x) = \prod_{j=1}^n p(x_j; \mu_j, \sigma_j^2) = \prod_{j=1}^n \frac{1}{\sqrt{2\pi}\sigma_j}\exp(-\frac{(x_j - \mu_j)^2}{2\sigma_j^2})
   $$

Anomaly if $p(x) < \varepsilon$.

### Anomaly Detection System

#### Training set, test set and cross valication set

For example:

* 10000 normal examples
* 20 anomal examples

We can split the set to

* Training set: 6000 normal examples
* Cross validation set: 2000 normal examples and 10 anomal examples.
* Test set: 2000 normal examples and 10 anomal examples.

#### Algorithm evaluation

* Fit model $p(x)$ on training set ${x^{(1)}, x^{(2)}, \dots, x^{(m)}}$.

* On a cross validation/test example $x$, poredict
  
  $$
  y = \left\{
  \begin{aligned}
  1, &if\ p(x)<\varepsilon\ (anomaly)\\
  0, &if\ p(x)\ge\varepsilon\ (normal)
  \end{aligned}
  \right.
  $$
  

* Possible evaluation metrics:
  * True positive, false positive, false negative, true negative
  * Precision/Recall
  * $F_1$-score

* Can also use cross validation set to choose parameter $\varepsilon$.

## Recommender System

### Collaborative Filtering

![image-20190527225028548](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-27-145029.png)

![image-20190527225703645](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-27-145704.png)

