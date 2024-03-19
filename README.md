# Gett Data Science Assignment

## Project Overview

This data project was undertaken as part of the recruitment process for data science positions at Gett, a technology platform focused on Corporate Ground Transportation Management (GTM). The objective was to analyze insights from failed orders in their application, examining reasons for failure, distribution by hours, average time to cancellation, and average Estimated Time of Arrival (ETA). Two datasets, `data_orders` and `data_offers`, were provided in CSV format.

## Project Structure

The project is structured into multiple tasks:

1. **Task 1: Distribution of Failed Orders:**
   - Analyze the distribution of orders based on reasons for failure (cancellations before and after driver assignment, and reasons for order rejection).
   - Identify the category with the highest number of orders.

2. **Task 2: Distribution of Failed Orders by Hours:**
   - Plot the distribution of failed orders by hours.
   - Examine trends and identify hours with abnormally high proportions of specific failure categories.

3. **Task 3: Average Time to Cancellation:**
   - Plot the average time to cancellation with and without a driver, by the hour.
   - Remove outliers and draw conclusions from the plot.

4. **Task 4: Distribution of Average ETA by Hours:**
   - Plot the distribution of average ETA by hours.
   - Explain the findings from the plot.

5. **BONUS - Hexagons:**
   - Utilize the h3 and folium packages to calculate and visualize hexagons containing 80% of all orders.
   - Color hexes by the number of failures.

## Data Description

### `data_orders` Dataset:
- **order_datetime:** Time of the order
- **origin_longitude:** Longitude of the order
- **origin_latitude:** Latitude of the order
- **m_order_eta:** Time before order arrival
- **order_gk:** Order number
- **order_status_key:** Enumeration representing order status (4 - cancelled by client, 9 - cancelled by system)
- **is_driver_assigned_key:** Whether a driver has been assigned
- **cancellation_time_in_seconds:** Seconds passed before cancellation

### `data_offers` Dataset:
- **order_gk:** Order number associated with the `data_orders` dataset
- **offer_id:** ID of an offer

## Code Files
- `analyze_failed_orders.sql`: SQL script for data cleaning and preparation.
- `failed_orders_visualization.pbix`: Visualization for the failed orders.
- `README.md`: This file.

# Task 1: Distribution of Failed Orders

## Analysis Overview

In this task, I investigated the distribution of failed orders based on various reasons for failure, including cancellations before and after driver assignment, as well as reasons for order rejection.

## Results

The analysis resulted in a comprehensive plot illustrating the distribution of failed orders across different categories. The key findings are as follows:

- **Cancellations Before Driver Assignment (Status 4 - cancelled by client):**
   - 8.2k orders, representing the highest count among failure categories.

- **Cancellations After Driver Assignment (Status 9 - cancelled by system):**
   - 2.9k orders, indicating a significant but lower count compared to cancellations before driver assignment.

- **Reasons for Order Rejection:**
   - Client cancellation (7.5k orders) comprises 68% of all rejections, while system cancellation (3.5k orders) accounts for the remaining 32%.

- **Count by Failure Categories and Reason for Rejection:**
   - *Driver Not Assigned:*
      - 4.7k orders (client cancelled)
      - 3.5k orders (system cancelled)
   - *Driver Already Assigned:*
      - 2.9k orders (client cancelled)
      - 0 orders (system cancelled)

## Observations

The analysis highlights that the majority of failed orders are attributed to clients canceling before a driver is assigned. Further investigation is needed to understand the underlying reasons for this high occurrence.

## Next Steps

To gain more insights into failed orders, subsequent tasks in the analysis will explore the distribution of failed orders by hours, average time to cancellation and distribution of average ETA by hours.

