# compareTo 比较大小

> 字符串比较大小，按字典顺序比较  
> 对象比较大小，需实现Comparable接口  
> 可理解为数字减法，字符串是从第一个字符开始比较  
> 前者 减 后者  
> 相等 -> 0  
> 大于0 -> 1  
> 小于0 -> -1  

#### Date类型比较

```java
// 此处例举两个Date类型时间
Date dateA
Date dateB

// 比较
dateA.compareTo(dateB)

// 结果
// Date dateA = <2020-03-17 09:33:08>
// Date dateB = <2020-03-17 09:33:08>
// 输出 0 -> dateA 与 dateB 为同一时间，两者相等

// Date dateA = <2020-03-17 09:33:08>
// Date dateB = <2020-03-16 09:33:08>
// 输出 1 -> dateA 晚于 dateB，前者大

// Date dateA = <2020-03-17 09:33:08>
// Date dateB = <2020-03-18 09:33:08>
// 输出-1 -> dateA 早于 dateB，后者大
```