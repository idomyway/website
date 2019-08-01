# Java 8 Stream

> 部分 Stream 常用操作整理

#### 测试对象

```java
public class Obj {
    private String code;
    private Integer value;
    public Obj() { }
    public Obj(String code, Integer value) {
        this.code = code;
        this.value = value;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public Integer getValue() {
        return value;
    }
    public void setValue(Integer value) {
        this.value = value;
    }
    @Override
    public String toString() {
        return "Obj{code='" + code + '\'' + ", value=" + value + "}";
    }
}
```

#### 测试list

```java
List<String> strList = new ArrayList<String>();
strList.add("B");
strList.add("C");
strList.add("E");
strList.add("A");

List<Obj> objList = new ArrayList<Obj>();
objList.add(new Obj("B", 2));
objList.add(new Obj("C", 3));
objList.add(new Obj("E", 4));
objList.add(new Obj("A", 1));
```

#### 类型转换

```java
// List<Obj> -> Map<String, String>
Map<String, String> map = objList.stream().collect(Collectors.toMap(Obj::getCode, Obj::getValue));
// {A=A1, B=B1, C=C1, E=E1}

// List<Obj> -> Map<String, Obj>
Map<String, Obj> objMap = objList.stream().collect(Collectors.toMap(Obj::getCode, obj -> obj));
// {A=Obj{code='A', value=1}, B=Obj{code='B', value=2}, C=Obj{code='C', value=3}, E=Obj{code='E', value=4}}

// List<Obj> -> List<String>
List<String> list = objList.stream().map(obj -> obj.getCode()).collect(Collectors.toList());
// B C E A

// List<Obj> -> Set<Obj>
Set<Obj> set = objList.stream().collect(Collectors.toSet());
// [Obj{code='B', value=2}, Obj{code='E', value=4}, Obj{code='C', value=3}, Obj{code='A', value=1}]

// List<Obj> -> String[]
String[] array = objList.stream().map(obj -> obj.getCode()).toArray(String[]::new);
// B C E A

// List<Obj> -> int[]
int[] array = objList.stream().mapToInt(obj -> obj.getValue()).toArray();
// 2 3 4 1

// List<String> -> String
String join = strList.stream().collect(Collectors.joining());
// BCEA
String joining = strList.stream().collect(Collectors.joining(","));
// B,C,E,A
```

#### 排序

> 自然序排序，常用于基本数据类型

```java
List<String> list = strList.stream().sorted().collect(Collectors.toList());
// A B C E

// 逆序
List<String> list = strList.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
// E C B A

// 不使用stream
strList.sort(Comparator.comparing(String::toString));
// 逆序
strList.sort(Comparator.comparing(String::toString).reversed());
```

> 使用Comparator排序，常用于对象类型

```java
List<Obj> list = objList.stream().sorted(Comparator.comparing(Obj::getCode)).collect(Collectors.toList());
// Obj{code='A', value=1}  Obj{code='B', value=2}  Obj{code='C', value=3}  Obj{code='E', value=4}

// 逆序
List<Obj> list = objList.stream().sorted(Comparator.comparing(Obj::getCode).reversed()).collect(Collectors.toList());
// Obj{code='E', value=4}  Obj{code='C', value=3}  Obj{code='B', value=2}  Obj{code='A', value=1}

// 不使用stream
objList.sort(Comparator.comparing(Obj::getCode));
// 逆序
objList.sort(Comparator.comparing(Obj::getCode).reversed());
```

#### 存在（anyMatch）、全部匹配（allMatch）、无匹配（noneMatch）、过滤（filter）、获取过滤后第一个（findFirst）、获取过滤后任意一个（findAny）

```java
// 存在（anyMatch）
boolean anyMatch = objList.stream().anyMatch(obj -> "E".equals(obj.getCode()));
// true

// 全部匹配（allMatch）
boolean allMatch = objList.stream().allMatch(obj -> obj.getValue() > 0);
// true

// 无匹配（noneMatch）
boolean noneMatch = objList.stream().noneMatch(obj -> obj.getValue() > 4);
// true

// 过滤（filter）
List<Obj> collect = objList.stream().filter(obj -> obj.getValue() > 2).collect(Collectors.toList());
// [Obj{code='C', value=3}, Obj{code='E', value=4}]

// 获取过滤后第一个（findFirst）
Obj obj = objList.stream().filter(obj -> obj.getValue() > 2).findFirst().get();
// Obj{code='C', value=3}

// 获取过滤后任意一个（findAny），对数据没有顺序上的要求，findAny的效率比findFirst要快
Obj obj = objList.stream().filter(obj -> obj.getValue() > 2).findAny().get();
// Obj{code='C', value=3}
```

#### 聚合求值（reduce、Collectors.reducing）

```java
int totalVal = objList.stream().map(obj -> obj.getValue()).reduce(0, (sum, val) -> sum + val);
// 10

int totalVal = objList.stream().collect(Collectors.reducing(0, Obj::getValue, (sum, val) -> sum + val));
// 10
```

#### 统计（IntSummaryStatistics、LongSummaryStatistics、DoubleSummaryStatistics）

```java
IntSummaryStatistics summaryStatistics = objList.stream().collect(Collectors.summarizingInt(Obj::getValue));

double average = summaryStatistics.getAverage(); // 平均值 2.5
long count = summaryStatistics.getCount();       // 个数 4
int min = summaryStatistics.getMin();            // 最小值 1
int max = summaryStatistics.getMax();            // 最大值 4
long sum = summaryStatistics.getSum();           // 求和 10
```

> 求和

```java
// int
int totalVal = objList.stream().mapToInt(obj -> obj.getValue()).sum();
// 10

// double
double totalVal = objList.stream().mapToDouble(obj -> obj.getValue().doubleValue()).sum();
// 10.0
```