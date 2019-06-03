---
title: 时间复杂度为 $O(n^2)$ 的排序算法
linktitle: 时间复杂度为 $O(n^2)$ 的排序算法
date: 2019-05-18T11:39:15.000Z
draft: false
type: docs
toc: true
math: true
tags: ["sort", "algorithm"]
categories: ["algorithm"]
menu:
  algorithm:
    parent: 排序算法
    weight: 1
weight: 101
---

## 为什么要学习 $O(n^2)$ 的排序算法

1. 这是一种简单的算法, 但是不因为其简单而不重要, 相反, 其是一种基础的算法, 是很多复杂问题的基础.
2. 编码简单, 易于实现, 是一些简单场景的首选.
3. 在一些特殊的情况下, 简单的排序算法会更加有效.
4. 简单的排序算法基础能够衍生出更复杂的排序算法.

## 选择排序

选择排序的算法非常简单:

- 假设我们有一个数组, 大小为 $n$.
- 需要进行 $n$ 次循环, 第 $i$ 次循环, 归位第 $i$ 个元素.
  - 找到 $[i, n)$ 中的最小值
  - 交换 i 和最小值位置的值.

![image-20190517174754990](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-17-094755.png)

```c++
void selectionSort(int arr[], int n) {
    for (int i = 0; i < n; ++i) {
        // 第 i 个元素归位
        int minIndex = i;
        // 找到 [i, n) 元素中的最小值的位置
        for (int j = i; j < n; ++j) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        // 交换 i 和 minIndex 的值
        // swap 是 c++11 std 命名空间中的标准函数
        // 在之前的标准中, 需要 #include <algorithm>
        swap(arr[i], arr[minIndex]);
    }
}
```

## 插入排序

插入排序类似于我们打扑克的时候, 抓牌的过程, 每次抓一张牌, 插入到手中已有牌的正确位置.

![image-20190519112446179](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-19-032447.png)

- 假设我们有一个数组, 大小为 $n$.
- 需要进行 $n$ 次循环, 第 $i$ 次循环
  - 归为第 $i$ 个元素
  - 与前一个元素进行比较, 如果小于前一个元素, 交换位置.
  - 直到大于等于前一个元素, 结束第 $i$ 次循环

代码实现:

```c++
template<typename T>
void insertionSort(T arr[], int n) {
    for (int i = 1; i < n; ++i) {
        // 寻找元素 arr[i] 的合适插入位置
        for (int j = i; j > 0 && arr[j] < arr[j - 1]; --j) {
            swap(arr[j], arr[j - 1]);
        }
    }
}
```

我们和之前的选择排序进行比较, 结果如下:

```c++
int main() {
    int n = 10000;
    int *arr = SortTestHelper::generateRandomArray(n, 0, n);
    int *arr2 = SortTestHelper::copyArray(arr, n);

    SortTestHelper::testSort("Insertion Sort", insertionSort, arr, n);
    SortTestHelper::testSort("Selection Sort", selectionSort, arr, n);
    
    delete[] arr;
    delete[] arr2;
    return 0;
}
```

![image-20190519115113825](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-19-035114.png)

### 插入排序的改进

相较于选择排序, 插入排序在循环过程中, 有提前结束的机制, 理论上效率应当比选择排序要高, 但是在上面的结果中, 为什么插入排序要比选择排序差呢? 主要原因在于交换, 我们上面的代码实现中, 每一次循环, 都要进行一次交换, 因此我们的一个优化思路是, 能不能减少交换的次数.

我们优化的思路是, 将交换操作使用数组的移动操作来代替, 能够大大减少数组中赋值操作的消耗 (一次交换是三次赋值), 具体来说, 就是待排序的元素与前一个元素比较, 如果小于前一个元素, 则将该元素复制一份, 将前一个元素后移一位; 然后再将待排序元素与前一个元素进行比较, 直到不小于前一个元素为止.

对于几乎为顺序的数组来说, 插入排序的效率会非常高, 使用如下代码进行测试:

```c++
int main() {
    int n = 10000;
    int *arr = SortTestHelper::generateNearlyOrderedArray(n, 100);
    int *arr2 = SortTestHelper::copyArray(arr, n);

    SortTestHelper::testSort("Insertion Sort", insertionSort, arr, n);
    SortTestHelper::testSort("Selection Sort", selectionSort, arr2, n);

    delete[] arr;
    delete[] arr2;
    return 0;
}
```

插入排序在极端情况下, 即对于完全有序的数组, 其是一个时间复杂度为 $O(n)$ 的算法. 因此插入排序算法也不是一无是处.

## 冒泡排序 (Bubble Sort)

冒泡排序过程中, 每一次循环中, 如果相邻的两个元素之间顺序错误, 则交换这两个元素, 我们可以想象, 最大的那个元素会像冒泡一样一直到最后一个位置, 这就是冒泡排序名字的由来, 那么下一次循环就可以少进行一次比较, 因为最后一个元素已经归位. 那么基于此我们有如下实现:

```c++
template<typename T>
void bubbleSort(T *arr, int n) {
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}
```

### 冒泡排序的优化

对于上述代码, 我们循环次数是固定的, 然而, 冒泡排序可以使用提前结束的条件判定, 如果在一次循环过程中, 没有发生交换, 那么就可以结束算法.

```c++
template<typename T>
void bubbleSort2(T *arr, int n) {
    bool isSwaped;
    do {
        isSwaped = false;
        for (int j = 0; j < n - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                isSwaped = true;
            }
        }
        n--;
    } while (isSwaped);
}
```

### 进一步优化

其实, 我们还可以对冒泡排序进行进一步优化, 之前的算法中, 我们每一轮迭代只归位最后一个元素, 其实, 在最后一个发生交换的元素之后的元素, 都可以认为已经完成了归位, 因此, 我们的算法还可以进一步优化.

```c++
template<typename T>
void bubbleSort3(T *arr, int n) {
    int swapPosition;
    do {
        // 为零表示没有进行交换
        swapPosition = 0;
        for (int j = 0; j < n - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                swapPosition = j + 1;
            }
        }
        n = swapPosition;
    } while (swapPosition > 0);
}
```

## 希尔排序 (Shell Sort)

希尔排序利用的是插入排序对近似有序数组的排序效率非常高, 希尔排序采用的是分而治之, 逐渐合并的思想.

第一步, 分. 将原数组以相等的间隔进行划分.

第二步, 对每一个分数组进行插入排序.

第三步, 逐渐缩小划分的间隔, 直到间隔为 1, 那么即完成了整个数组的排序.

通过对每一个子序列先进性排序, 使得数组整体上呈现近似顺序的状态, 因此使用插入排序会非常高效.

为了高效, 具体操作过程中, 第一轮排序, 每一个子数组中包含 3 个元素, 然后以三倍的形式扩大, 为了使最终间距能够到达 1, 我们可以从 1 开始生成一个 increment sequence, 然后对每个子序列进行插入排序.

```c++
template <typename T>
void shellSort(T arr[], int n) {
	// 生成 increment sequence
  int h = 1;
  while (h < n) {
  	h = h * 3 + 1;
  }
  
  // 等于 1 的时候进行最后一轮排序
  while (h >= 1) {
  	
    // 对每个子序列进行排序
    // 例如: 对于 1 2 3 4 5 6 7 8 9 10
    // 首先, 子序列分别为:
   	// 1, 5
    // 2, 6
    // 3, 7
    // 4, 8
    // 1, 5, 9
    // 2, 6, 10
    int j;
    T e = arr[j];
    for (j = i; j > 0 && arr[j - h] > e; j -= h) {
    	arr[j] = arr[j - h];
    }
    arr[j] = e;
    h /= 3;
  }
}
```

