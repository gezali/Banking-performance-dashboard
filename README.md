# 🏦 Banking Performance Dashboard

An interactive **Power BI** dashboard that analyzes bank transactions, accounts, and customers. Data from three related tables is combined in **SQL Server** and visualized in a 2-page report with custom **DAX** measures.

---

## 📌 Project Overview

This project turns raw banking data into clear, decision-ready insights. It helps answer questions such as:

- How many transactions are happening, and how do they trend over time?
- Which transaction types and account types drive the most activity?
- Who are the top customers by transaction amount and current balance?
- What does the customer base look like by gender and age group?
- How many accounts are inactive over time?

---

## 🗂️ Dataset

Three source tables were joined in SQL Server into a single **CombinedBankingDataset**:

| Table | Description |
|---|---|
| **Transactions** | Transaction date, type, and amount |
| **Accounts** | Account type and current balance |
| **Customers** | Customer name, gender, age group, contact details |

In Power BI, the model contains the main table `Bank_Account` and a separate `Measures Table` that holds all DAX measures.

**Data cleaning (SQL Server):** phone numbers were standardized to the `+91-XXXXXXXXXX` format.

---

## 📊 Dashboard Pages

### Page 1: Transactions & Accounts
- **Top customers by amount** (bar chart)
- **Total transactions over time** (area chart)
- **Inactive accounts over time** (line chart)
- **Total amount by account type** (column chart)
- **Transactions by transaction type** (pie chart)

### Page 2: Customers & Balances
- **Customer count by gender** (donut chart)
- **Top customers by current balance** (bar chart)
- **Total balance over time** (area chart)
- **Customers by age group** (column chart)
- **Account count by type** (treemap)

---

## 📐 Key DAX Measures

Measures used in the report (stored in `Measures Table`):

- Total Transactions
- Total Amount
- Total Balance
- Inactive Accounts
- Customer Count by Gender
- Account Count by Type
- Age Group Name (calculated grouping)

---

## 🛠️ Tools & Technologies

- **Power BI Desktop**: data modeling, DAX, visualization
- **SQL Server**: data joining and cleaning
- **DAX**: custom measures

---

## 🚀 How to Use

1. Clone or download this repository:
   ```bash
   git clone https://github.com/gezali/Banking-performance-dashboard.git
   ```
2. Open `Bank_Account.pbix` in **Power BI Desktop**.
3. Use the slicers and visuals on each page to explore the data.

> Requires Power BI Desktop (free download from Microsoft).

---

## 🖼️ Screenshots


>
> ![Page 1](Screenshot%202026-11-11%20154440.png)
> ![Page 2](Screenshot%202026-11-11%20154537.png)

---

## 📁 Repository Structure

```
Banking-performance-dashboard/
├── Bank_Account.pbix
├── images/
│   ├── page1.png
│   └── page2.png
└── README.md
```

---

## 👤 Author

**Zakariya Gezali**
Data Analyst | Power BI · SQL · Excel · Python · Tableau
GitHub: [@gezali](https://github.com/gezali)
