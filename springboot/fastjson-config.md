# FastJson处理响应数据

> SpringBoot中使用FastJson将响应的数据转成json相关配置

```java
@Configuration
public class WebMvcConfig extends WebMvcConfigurationSupport {
    /**
     * FastJson对响应数据处理的相关配置
     */
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        FastJsonHttpMessageConverter fastConverter = new FastJsonHttpMessageConverter();
        FastJsonConfig fastJsonConfig = new FastJsonConfig();
        // 序列化
        fastJsonConfig.setSerializerFeatures(SerializerFeature.PrettyFormat);
        // 时间戳格式
        fastJsonConfig.setDateFormat("yyyy-MM-dd HH:mm:ss");
        // 处理中文乱码问题
        List<MediaType> fastMediaTypes = new ArrayList<MediaType>();
        fastMediaTypes.add(MediaType.APPLICATION_JSON_UTF8);
        fastConverter.setSupportedMediaTypes(fastMediaTypes);
        // 为空返回值转换
        ValueFilter valueFilter = new ValueFilter() {
            /**
             * Object cls 是class
             * String key 是key值
             * Object val 是value值
             */
            public Object process(Object cls, String key, Object val) {
                if (null == val)
                    val = "";
                return val;
            }
        };
        fastJsonConfig.setSerializeFilters(valueFilter);

        fastConverter.setFastJsonConfig(fastJsonConfig);
        converters.add(fastConverter);
    }
}
```



