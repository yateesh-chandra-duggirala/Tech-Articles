# 4 Examples to take PySpark Skills to next level
- PySpark is the Python API for Spark, which is an analytics engine used for large-scale data processing.
- Spark has become the predominant tool in the data science ecosystem especially when we deal with large datasets that are difficult to handle with tools like Pandas and SQL.
- Let us understand some challenging data cleaning and processing tasks. For that initially download the dataset above.
- Create a Dataframe and load this dataset into that dataframe

## Example - 1: Select Expression
- The `selectExpr` function makes it very simple to preprocess data like changing column names and data types.
- Consider we need some columns from the dataset and also while creating the sub dataframe, we also want to change the names of the store_code, product_code and sales_data columns.
- The data types of product_code and sales_data are string. So, let us change them too.

## Example - 2 : Moving Average
- Moving average is calculated by creating a window of a predefined size and applying mean function over it.
- Moving averages can be used in predictive analytics especially when we work with time series data.
- Let us create the moving average of a 3-day window.
- We will define a window partitioned by store_id and product_id columns since the sales quantities of different products at different stores are unrelated and should not be mixed.

## Example - 3 : Moving average using SQL
- Just like we need SQL for selecting, renaming, and casting columns, we can use it for calculating moving averages.
- This is a highly convenient feature of Spark for those who have very good SQL skills but need to adapt to spark.
- We simply write what we want to do as SQL code and pass it to the expr function.

## Example - 4 : Conditional Moving Average
- Let us first create a column named "is_promo".
- We use the when function to create conditional columns.
- The condition is specified within this function along with values to be used for the rows that fix the condition.
- The otherwise function is used for assignig value to rows that do not fit any of the given conditions.
- What we want to do now is to calculate the moving average of a 3-day window but excluding the promo days.
- If one of the previous days within the 3-day window range is a promotion day, It will be skipped and will not be included in the calculation of moving average.
- Let us remove the promo days from the Dataframe and then calculate the moving average, then will join the new calculation to the original DataFrame.
- The days with promotion will be null (i.e, missing values).