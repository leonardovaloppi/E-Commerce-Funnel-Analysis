-- Create a list of unique events with their earliest occurrence for each user.
WITH unique_events AS
(
SELECT event_name AS name,
       user_pseudo_id AS pseudo_id,
       MIN(DISTINCT event_timestamp) AS time_first_event      

FROM raw_events

GROUP BY event_name,
         user_pseudo_id
),

-- Filter raw events to include only the first occurrence of each unique event for each user.
detailed_unique_events AS
(
SELECT raw_events.*

FROM raw_events
JOIN unique_events
  ON unique_events.name = raw_events.event_name
 AND unique_events.pseudo_id = raw_events.user_pseudo_id
 AND unique_events.time_first_event = raw_events.event_timestamp

 WHERE event_name IN (
                      'add_to_cart',
                      'begin_checkout',
                      'add_shipping_info',
                      'select_promotion',
                      'add_payment_info',
                      'purchase'
                     )
),

-- Identify the top-ranking countries based on the total number of unique events, ranking them in descending order of event count.
top_countries AS
(
SELECT country,
       COUNT(*) AS count_events,
       RANK() OVER(ORDER BY COUNT(*) DESC) AS country_rank

FROM detailed_unique_events

GROUP BY country
),

-- Calculate the number of unique events for each top-ranked country and summarize their presence in the top three ranked countries.
events_per_countries AS
(
SELECT event_name,
       COUNTIF(top_countries.country_rank = 1 AND operating_system = '<Other>') AS country_1,
       COUNTIF(top_countries.country_rank = 2 AND operating_system = '<Other>') AS country_2,
       COUNTIF(top_countries.country_rank = 3 AND operating_system = '<Other>') AS country_3,
       COUNTIF(top_countries.country_rank IN (1, 2, 3) AND operating_system = '<Other>') AS country_podium,
       COUNTIF(operating_system = '<Other>') AS all_countries,

FROM detailed_unique_events
JOIN top_countries
  ON top_countries.country = detailed_unique_events.country

GROUP BY event_name
)

-- Enhance event metrics by calculating absolute and relative proportions of events across top-ranked countries and podium totals.
SELECT events_per_countries.*,
       ROUND(country_1 / FIRST_VALUE(country_1) OVER (ORDER BY country_1 DESC), 4) AS absolute_1,
       ROUND(country_2 / FIRST_VALUE(country_2) OVER (ORDER BY country_2 DESC), 4) AS absolute_2,
       ROUND(country_3 / FIRST_VALUE(country_3) OVER (ORDER BY country_3 DESC), 4) AS absolute_3,
       ROUND(country_podium / FIRST_VALUE(country_podium) OVER (ORDER BY country_podium DESC), 4) AS absolute_podium,
       ROUND(all_countries / FIRST_VALUE(all_countries) OVER (ORDER BY all_countries DESC), 4) AS absolute_all,
       COALESCE(ROUND(country_1 / LAG(country_1) OVER (ORDER BY country_1 DESC), 4), 1.0) AS relative_1,
       COALESCE(ROUND(country_2 / LAG(country_2) OVER (ORDER BY country_2 DESC), 4), 1.0) AS relative_2,
       COALESCE(ROUND(country_3 / LAG(country_3) OVER (ORDER BY country_3 DESC), 4), 1.0) AS relative_3,
       COALESCE(ROUND(country_podium / LAG(country_podium) OVER (ORDER BY country_podium DESC), 4), 1.0) AS relative_podium,
       COALESCE(ROUND(all_countries / LAG(all_countries) OVER (ORDER BY all_countries DESC), 4), 1.0) AS relative_all

FROM events_per_countries

ORDER BY absolute_podium DESC
