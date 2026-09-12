SELECT
    year_no,
    month_no,
    tot_sales,
    LAG(tot_sales, 1) OVER (ORDER BY month_no) AS prev_tot
FROM sales_fact
WHERE year_no = 2020;
