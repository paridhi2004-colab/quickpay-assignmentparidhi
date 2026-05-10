spreadsheet_answers.md


# Spreadsheet Answers

## Cleaning Steps
- Imported raw transaction, merchant master, and exchange rate datasets into Excel.
- Standardized merchant names using TRIM and PROPER functions.
- Standardized transaction statuses into captured, failed, and chargeback categories.
- Cleaned risk score values by removing text patterns such as score: and risk-.
- Filled missing gateway regions using XLOOKUP from merchant_master data.
- Converted all transaction amounts into USD using exchange rates.
- Created high_value_flag and high_risk_flag business logic columns.
- Created merchant level summary using Pivot Table.

## Standardization Rules
- Merchant names converted into proper case format.
- Status values standardized into lowercase categories.
- Gateway regions standardized into APAC, EU, and US.
- Risk scores converted into numeric values.
- Extra spaces and inconsistent formatting removed using TRIM.

## Lookup and Enrichment Logic
- Used XLOOKUP to enrich transactions using merchant_master data.
- Filled missing gateway regions using default_region values.
- Used exchange_rates data to calculate amount_usd values.

## Final Answers
- Total raw rows: [30]
- Total cleaned rows: [30]
- Invalid or missing rows handled: [Missing gateway regions, inconsistent risk score formats, and inconsistent status values were cleaned and standardized.]
- Top region by GMV: [APAC]
- Number of high value transactions: [7]
- Number of high risk transactions: [10]
- Top merchant by captured GMV: [Beta Stores]

## Formula Samples
- =PROPER(TRIM(C2))
- =LOWER(TRIM(F2))
- =IF(ISNUMBER(SEARCH("capture",L2)),"captured",
- =IF(G2="","",VALUE(SUBSTITUTE(SUBSTITUTE(G2,"score:",""),"risk-","")))
- =UPPER(TRIM(IF(H2<>"",H2,XLOOKUP(K2,merchant_master!B:B,merchant_master!E:E))))
- =D2*XLOOKUP(E2,exchange_rates!B:B,exchange_rates!C:C)