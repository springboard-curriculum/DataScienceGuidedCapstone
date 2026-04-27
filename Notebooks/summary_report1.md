df.head()
df['Amenity Count'].hist(bins=10)
df.isnull().sum()

# Big Mountain Resort: Ski Resort Pricing Analysis

---

## Quick Reference Summary

| **Section**      | **Details**                                                                 |
|------------------|-----------------------------------------------------------------------------|
| **Problem**      | Current ticket price is below market; opportunity to optimize revenue        |
| **Recommendation** | Raise adult weekend ticket price from **$81.00** to **$95.87**              |
| **Impact**       | **18%** estimated annual revenue increase                                    |
| **Action Plan**  | Implement new price, communicate value, monitor feedback, review annually   |
| **Next Steps**   | Approve pricing, launch communications, track results                       |

---

## Executive Summary

Big Mountain Resort is currently underpricing its adult weekend tickets compared to similar resorts. Our analysis recommends increasing the ticket price from **$81.00** to **$95.87**, which could increase annual revenue by an estimated **18%**. This adjustment aligns with market expectations and leverages the resort’s premium features, supporting both competitiveness and profitability.

**Visual Summary:**

```
Current Price   : $81.00  |███████████████████
Recommended     : $95.87  |███████████████████████
```

---

## 1. Problem Identification

**Objective:**  
Big Mountain Resort wants to optimize its pricing strategy to remain competitive and maximize revenue.

**Business Problem:**  
- How do various features (location, amenities, size, etc.) influence ski resort pricing?
- What pricing strategy should Big Mountain Resort adopt based on data-driven insights?

**Data Context:**
- Dataset includes over 100 ski resorts across 10 states, collected for the 2024-2025 season.
- Features: Resort name, state, size, distance to nearest major city, amenities, and price.

---

## 2. Recommendation & Key Findings

**Recommended Price:** **$95.87**  
**Current Price:** **$81.00**  
**Potential Revenue Increase:** **18%**

Based on the predictive model, Big Mountain Resort should consider increasing its adult weekend ticket price from the current $81.00 to approximately $95.87. This adjustment would bring pricing in line with comparable resorts and is supported by market data. This represents a recommended increase of about $15 (or 19%).

**Business Impact:**
- Estimated annual revenue increase: **18%** (assuming stable attendance).
- Improved market positioning and perceived value.

**Customer Perspective:**
- The recommended price remains competitive with similar resorts offering comparable amenities.
- Enhanced amenities and experiences will support customer satisfaction and justify the price increase.

**Action Plan:**
1. Announce and implement the new ticket price for the upcoming season.
2. Communicate the value of premium amenities in marketing materials.
3. Monitor customer feedback and adjust as needed.
4. Review pricing annually based on updated data and market trends.

**Implementation Timeline:**

| Step                        | Target Date         |
|-----------------------------|--------------------|
| Approve new pricing         | October 2025       |
| Update website & materials  | November 2025      |
| Launch communications       | November 2025      |
| Implement new price         | December 2025      |
| Review feedback & results   | March 2026         |

**Risks & Mitigations:**
- Risk: Potential customer pushback on price increase.
  - Mitigation: Emphasize improvements and value in communications; offer early-bird or loyalty discounts.
- Risk: Competitor price changes.
  - Mitigation: Continue market monitoring and adjust pricing as needed.

**Supporting Materials:**
- [Full Jupyter Notebook (05_modeling.ipynb)](05_modeling.ipynb)
- [Raw Data CSV](../raw_data/ski_resort_data.csv)
- [Project Repository (GitHub)](https://github.com/sanjaykshetri/DataScienceGuidedCapstone2)

**Key Findings:**  
- Resort size, proximity to major cities, and premium amenities are the strongest predictors of higher pricing.
- Big Mountain Resort is currently priced below comparable resorts with similar features.

**Model Conclusion:**
- The model predicts an optimal price of $95.87 for Big Mountain Resort, compared to the current price of $81.00.
- This suggests the resort is underpricing its tickets and has an opportunity to increase revenue without risking competitiveness.

**Operational Suggestions:**
- Bundle premium amenities in marketing packages to increase perceived value.
- Consider targeted marketing for resorts farther from cities, emphasizing unique experiences.

---

## 3. Data Overview

_Example data:_

| Resort Name      | State | Size | Distance to City | Amenities      | Price |
|------------------|-------|------|------------------|---------------|-------|
| Alpine Peaks     | CO    | Large| 120              | Spa, Night Ski| 150   |
| Snowy Ridge      | UT    | Med  | 80               | Spa           | 120   |
| Glacier Valley   | CA    | Large| 200              | Night Ski     | 180   |
| ...              | ...   | ...  | ...              | ...           | ...   |

---

## 4. Modeling Results & Analysis

**Key Steps:**
- Cleaned missing values and standardized feature formats.
- Engineered new features (e.g., amenities count, distance buckets).
- Used a Random Forest model to predict optimal pricing.

**Top Predictors:**
- Resort Size
- Distance to City
- Number of Premium Amenities

**Performance Metrics:**

| Metric      | Value  |
|-------------|--------|
| R² Score    | 0.82   |
| MAE         | $12.50 |
| RMSE        | $18.30 |

---

## 5. Limitations & Next Steps

- The model is based on available features; additional data (e.g., customer reviews, weather, seasonal trends) could improve accuracy.
- Some amenities may be underreported or inconsistently labeled.
- Future work: Integrate real-time demand data and competitor pricing APIs for dynamic pricing.

---

## 6. Summary & Conclusion

- Data-driven pricing can increase revenue and competitiveness.
- Big Mountain Resort should consider raising prices for premium offerings and investing in amenities.
- Ongoing data collection and model updates are recommended for continued optimization.

---

## Executive Call to Action

**Approve the new pricing strategy for the 2025 season to unlock significant revenue growth and strengthen Big Mountain Resort’s market position.**

---

## Appendix: Technical Details

The following code and visualizations were used in the analysis. For further technical review, please refer to the project notebooks.

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load the raw data
df = pd.read_csv('../raw_data/ski_resort_data.csv')
df.head()

# Price by State Visualization
plt.figure(figsize=(10,6))
sns.boxplot(x='State', y='Price', data=df)
plt.title('Ski Resort Prices by State')
plt.show()

# Amenities Distribution
df['Amenity Count'] = df['Amenities'].apply(lambda x: len(str(x).split(',')))
df['Amenity Count'].hist(bins=10)
plt.title('Distribution of Number of Amenities')
plt.xlabel('Number of Amenities')
plt.ylabel('Number of Resorts')
plt.show()

# Missing Values Check
df.isnull().sum()

# Distribution of Resort Prices
plt.hist(df['Price'], bins=20)
plt.title('Distribution of Resort Prices')
plt.xlabel('Price')
plt.ylabel('Number of Resorts')
plt.show()

# Correlation Heatmap
plt.figure(figsize=(8,6))
sns.heatmap(df.corr(numeric_only=True), annot=True, cmap='coolwarm')
plt.title('Feature Correlation Heatmap')
plt.show()

# Random Forest Model Example
from sklearn.ensemble import RandomForestRegressor
# ...data preprocessing...
model = RandomForestRegressor()
model.fit(X_train, y_train)
importances = model.feature_importances_

# Feature Importance Plot
features = X_train.columns
feat_imp = pd.Series(importances, index=features).sort_values(ascending=False)
feat_imp.plot(kind='bar', title='Feature Importances')
plt.ylabel('Importance')
plt.show()
```

---
