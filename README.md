![Funnel](https://d2h3pg8y17p5so.cloudfront.net/s3/topics/funnels/sales-funnel-analysis-article-headline.jpg)

# Funnel Analysis – Checkout Conversion by Country and Platform

*NOTE: This project was developed as part of **Sprint 2 of Module 3** at **Turing College**.*

### Table of Contents

- [Project Overview](#project-overview-)  
- [Methodology](#methodology)  
- [Key Results](#key-results-)
- [Project Files](#project-files-%EF%B8%8F)
- [Accessing the Files](#accessing-the-files)
- [Tools & Technologies](#tools--technologies-%EF%B8%8F)  
- [More from Leonardo Valoppi](#more-from-leonardo-valoppi-)

---

## Project Overview 🔍

### Goal
This project analyzes user behavior across the **checkout funnel of an e-commerce website**, from the **first visit** to the **final purchase**.  
The objective is to identify where users drop off, understand differences across **countries** and **operating systems**, and deliver actionable recommendations to optimize conversion.

## Dataset Source
The dataset is stored in **Google BigQuery** and sourced from an internal `raw_events` table.  
It tracks millions of website events from various countries and devices, capturing a wide range of user interactions.
For the checkout funnel analysis, the following sequence of events was selected:

`add_to_cart` → `begin_checkout` → `add_shipping_info` → `select_promotion` → `add_payment_info` → `purchase`

To better understand the broader picture of the funnel (including earlier stages that provide a wider perspective on user behavior), the following events were chosen:

`first_visit` → `view_item` → `add_to_cart` → `purchase`

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

### Business Recommendations 🎯

- 🇮🇳 **India**: Improve localization (Hindi + other languages), enhance mobile experience (esp. Android), and streamline the payment phase.
- 🇨🇦 **Canada**: Ensure bilingual (EN/FR) support, use return-to-cart strategies (reminders, popups), and improve UX on macOS and Android.
- 📱 **All platforms**: Run A/B tests on the "Select Promotion" step, optimize performance on Android, and reduce technical friction in early funnel stages.

---

## Project files 🗂️

- `SQL` → Folder containing all the queries used to generate the funnels.
  
  - `OS-Filter` → Sub-folder of `SQL` containing the queries used to filter by operating system.
    
    - `WFA_checkout-other.sql` → Checkout funnel including only `<Other>` OS.
    - `WFA_checkout-windows.sql` → Checkout funnel including only `Windows`.
    - `WFA_checkout-android.sql` → Checkout funnel including only `Android`.
    - `WFA_checkout-ios.sql` → Checkout funnel including only `iOS`.
    - `WFA_checkout-macintosh.sql` → Checkout funnel including only `Macintosh`.
    - `WFA_checkout-web.sql` → Checkout funnel including only `Web`.

  - `WFA_checkout.sql` → Generates the checkout funnel without OS filters.
  - `WFA_checkout_extended.sql` → Generates an extended funnel including `first_visit`, `view_item`, `add_to_cart`, and `purchase` events.
      
- `WFA_report.pdf` → Final report with results, graphs, and recommendations.

---

## Accessing the files

To download and access the report, and to use the queries for your own funnel project, clone the repository to your local machine using Git:

```bash
git clone https://github.com/leonardovaloppi/spotify-top-50.git
```
Alternatively, if you don’t have Git installed, you can download the ZIP file:

- 1 → Click the green `Code` button at the top of the repository.
- 2 → Select `Download ZIP` and extract the folder.


## Tools & technologies 🛠️

| Tool | Purpose |
|------|---------|
| **SQL (BigQuery)** | Data querying and aggregation |
| **PDF Document** | Final report and recommendations |

---

## More from Leonardo Valoppi 👨‍💻

[LinkedIn](https://linkedin.com/in/leonardo-valoppi) 

[GitHub Profile](https://github.com/leonardovaloppi)  

[Tableau Public](https://public.tableau.com/app/profile/leonardo.valoppi/vizzes)

---

[Table of Contents](#table-of-contents)
