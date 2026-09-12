SELECT
    year_no,
    month_no,
    tot_sales,
    ROW_NUMBER() OVER (ORDER BY tot_sales DESC) AS rank
FROM sales_fact;
