![Funnel](https://d2h3pg8y17p5so.cloudfront.net/s3/topics/funnels/sales-funnel-analysis-article-headline.jpg)

# Funnel Analysis – Checkout Conversion by Country and Platform

*NOTE: This project was developed as part of **Sprint 2 of Module 3** at **Turing College**.*

---

## Project Overview 🔍

### Goal
This project analyzes user behavior across the **checkout funnel of an e-commerce website**, from the **first visit** to the **final purchase**.  
The objective is to identify where users drop off, understand differences across **countries** and **operating systems**, and deliver actionable recommendations to optimize conversion.

## Dataset Source
The dataset is stored in **Google BigQuery** and sourced from an internal `raw_events` table.  
It tracks millions of website events from various countries and devices, capturing interactions such as:
- `first_visit`
- `view_item`
- `add_to_cart`
- `begin_checkout`
- `add_shipping_info`
- `select_promotion`
- `add_payment_info`
- `purchase`

## Methodology
*(Step 1)* **Event deduplication** → filtered to include only the first unique event per user per event type.  
*(Step 2)* **Dynamic country ranking** → selected top 3 countries based on unique interaction volume using `RANK()`.  
*(Step 3)* **Funnel construction** → calculated conversion rates step-by-step.  
*(Step 4)* **Segmentation by OS** → analyzed conversion rates separately for Windows, macOS, iOS, Android, and others.

### Key definitions
- **Unique Interaction**: First recorded occurrence of an event per user.  
- **Absolute conversion**: Conversion rate relative to the initial step.  
- **Relative conversion**: Conversion rate from the previous step.

---

## Key Results 💡

- Only **~35%** of users who add an item to the cart complete the purchase.
- Conversion drop-offs are especially sharp at the **"Select Promotion"** and **"Add Payment Info"** stages.
- The **United States** consistently leads in total volume, but **conversion rates are similar across USA, India, and Canada**.
- OS analysis shows **Windows and iOS** users convert more efficiently than those on **Android and macOS**.

---

## Business Recommendations 🎯

- 🇮🇳 **India**: Improve localization (Hindi + other languages), enhance mobile experience (esp. Android), and streamline the payment phase.
- 🇨🇦 **Canada**: Ensure bilingual (EN/FR) support, use return-to-cart strategies (reminders, popups), and improve UX on macOS and Android.
- 📱 **All platforms**: Run A/B tests on the "Select Promotion" step, optimize performance on Android, and reduce technical friction in early funnel stages.

---

## Project files 🗂️

- `--` → SQL used to clean and structure the dataset.
- `--` → SQL for funnel extraction and ranking logic.
- `WFA_report.pdf` → Final report with results, graphs, and recommendations.

---

## Tools and technologies 🛠️

| Tool | Purpose |
|------|---------|
| **SQL (BigQuery)** | Data querying and aggregation |
| **Google Sheets** | Intermediate calculations |
| **Google Docs / PDF** | Final report and recommendations |

---

## More from Leonardo Valoppi 👨‍💻

[LinkedIn](https://linkedin.com/in/leonardo-valoppi)  
[GitHub Profile](https://github.com/leonardovaloppi)  
[Tableau Public](https://public.tableau.com/app/profile/leonardo.valoppi/vizzes)
