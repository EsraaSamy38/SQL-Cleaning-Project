# Layoffs Data Cleaning Project

SQL project to clean and prepare layoffs data for analysis.

## 🧹 Key Cleaning Steps
1. **Removed duplicates**:
   - using `ROW_NUMBER()` window function  
3. **Standardized text data**:  
   - Trimmed whitespace from company names  
   - Consolidated "crypto%" variations to "crypto"  
4. **Fixed NULL values**:  
   - Populated missing industries by joining same-company records  
5. **Date formatting**:  
   - Converted text dates to DATE type using `str_to_date()`

## 🚀 How to Use
1. Run `SQL(11).sql` in MySQL Workbench  
2. View results in [`output`]([outpu/cleaned_sample.csv](https://github.com/EsraaSamy38/SQL-Data-Cleaning-Project/tree/main/output))📄
folder:  
   - `cleaned_sample.csv` (5-row data preview)  
   - `cleaning_stats.txt` (cleaning summary)  

## 💡 Skills Demonstrated
- Advanced SQL data cleaning  
- Handling NULLs/duplicates  
- Data standardization  
- Date formatting  
