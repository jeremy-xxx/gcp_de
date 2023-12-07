## 1. Connect to BigQuery
-   On the Home ribbon in Power BI Desktop, click  **Get Data**  and then  **More…**.
-  In the open window, type “_bigquery_” into the search bar or select the  **Database** category on the left, then find and select  **Google BigQuery**. Click  **Connect**.

![enter image description here](https://blog.coupler.io/wp-content/uploads/2021/08/2-select-google-bigquery.png)
- Now you need to connect BigQuery to Power BI. Click the **Sign in** button and follow the usual flow.![enter image description here](https://blog.coupler.io/wp-content/uploads/2021/08/3-sign-in-google-bigquery.png)
-  A Navigator window will appear in which you need to choose a BigQuery Project, a dataset, and a table to load data from.
- The last step of the Power BI BigQuery connector setup is to click **Load** and choose **DirectQuery** to set up a live connection to our dataset.

## 2. Create Report

### **Map**
In order to create the map for location tracking, a **Map** is created by dragging the columns `latitude` and `longitude` into the corresponding fields. Then add the column `vehicle_id` into the **Filters on this visual** section, which allows for filtering to monitor specific vehicles.

### **HDOP vs VDOP by Vehicle**
For the HDOP vs VDOP scatter plot, assign the HDOP values to the X-axis and VDOP values to the Y-axis, differentiating data points by `vehicle_id`.

### **Average Speed per Second by Vehicle**
Plot the average speed per second by assigning `vehicle_id` to the category axis and average speed values to the value axis.

### **Total Distance per Vehicle**
To visualize the total distance, use a bar chart with `vehicle_id` on the category axis and total distance values on the value axis.

## 3. Create a Dashboard

After finishing the design of the report, simply choose **Pin to the dashboard** on the upper right of the toolbar to create a new or save to an existing dashboard. 
![enter image description here](https://learn.microsoft.com/en-us/power-bi/create-reports/media/service-dashboard-pin-live-tile-from-report/power-bi-pin.png)



![enter image description here](https://learn.microsoft.com/en-us/power-bi/create-reports/media/service-dashboard-pin-live-tile-from-report/pbi-pin-live-page-dialog.png)
