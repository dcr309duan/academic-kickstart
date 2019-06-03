---
title: 时间复杂度为 $O(nlogn)$ 的排序算法
linktitle: 时间复杂度为 $O(nlogn)$ 的排序算法
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
    weight: 2
weight: 102
---



## 归并排序 (Merge Sort)

归并排序算法思路: 将待排序数组分成两部分, 对每一部分进行排序, 然后再将两部分合并. 其中, 对于每一部分的排序, 又可以继续利用归并排序来完成.

![image-20190527170913971](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-27-090914.png)

### 归并排序的分析

我们可以看出, 在有三个元素的时候, 我们分成了三个层级后, 每一个子序列中就只有一个元素了 (8 个元素, 每次二分, $log_2(8) = 3$ 次后就完成划分).

### 归并的过程

![image-20190527171729722](https://markdown-1252040768.cos.ap-beijing.myqcloud.com/2019-05-27-091730.png)

归并的过程需要额外开辟一个同等大小的空间, 使用三个指针来完成归并.

下方表示待归并的数组, 上方用于存储最终归并的结果. 蓝色指针指向下一个待归位的位置, 两个橙色指针分别指向两个待归并数组中下一个带归位的元素, 每一次比较两个橙色指针所指向的元素大小, 选择较小的那个元素填入蓝色指针位置, 并将蓝色指针后移一位, 同时将该橙色指针也后移一位, 知道完成归并.

这一步归并的时间复杂度为 $O(n)$ 级别, 需要完成归并的次数为 $O(logn)$, 算法总体的时间复杂度为 $O(nlogn)$.

### 归并排序的递归实现

```c++
// arr 的 [l, mid] 和 [mid + 1, r] 合并
template<typename T>
void __merge(T arr[], int l, int mid, int r) {
    T aux[r - l + 1];
    for (int i = l; i <= r; ++i) {
        aux[i - l] = arr[i];
    }
    int i = l;
    int j = mid + 1;
    for (int k = l; k <= r; k++) {
        if (i > mid) {
            arr[k] = aux[j - l];
            j++;
        } else if (j > r) {
            arr[k] = aux[i - l];
            i++;
        } else if (aux[i - l] < aux[j - l]) {
            arr[k] = aux[i - l];
            i++;
        } else {
            arr[k] = aux[j - l];
            j++;
        }
    }
}

// 递归使用归并排序, 对 arr[l, ..., r] 的范围进行排序
template<typename T>
void __mergeSort(T arr[], int l, int r) {
    if (l >= r) {
        return;
    } else {
        int mid = (l + r) / 2;
        __mergeSort(arr, l, mid);
        __mergeSort(arr, mid + 1, r);
        __merge(arr, l, mid, r);
    }
}

template<typename T>
void mergeSort(T arr[], int n) {
    __mergeSort(arr, 0, n - 1);
}
```

### 改进1

增加了判断, 只在 `arr[mid] > arr[mid + 1]` 的情况下才进行 `merge`.

```c++
// 递归使用归并排序, 对 arr[l, ..., r] 的范围进行排序
template<typename T>
void __mergeSort(T arr[], int l, int r) {
    if (l >= r) {
        return;
    } else {
        int mid = (l + r) / 2;
        __mergeSort(arr, l, mid);
        __mergeSort(arr, mid + 1, r);
        if (arr[mid] > arr[mid + 1]) {
            __merge(arr, l, mid, r);
        }
    }
}
```

### 改进2

并不需要递归到底, 在只有 16 个元素的时候, 使用插入排序进行排序.

```c++
// 递归使用归并排序, 对 arr[l, ..., r] 的范围进行排序
template<typename T>
void __mergeSort(T arr[], int l, int r) {
//    if (l >= r) {
//        return;
//    }
    if (r - l <= 15) {
        insertionSort(arr, l, r);
        return;
    } else {
        int mid = (l + r) / 2;
        __mergeSort(arr, l, mid);
        __mergeSort(arr, mid + 1, r);
        if (arr[mid] > arr[mid + 1]) {
            __merge(arr, l, mid, r);
        }
    }
}
```

