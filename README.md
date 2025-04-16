# Layoffs Data Cleaning Project

SQL project to clean and prepare layoffs data for analysis.

## 🔧 Key Cleaning Steps
1. **Removed duplicates** using `ROW_NUMBER()` window function  
2. **Standardized text data**:  
   - Trimmed whitespace from company names  
   - Consolidated "crypto%" variations to "crypto"  
3. **Fixed NULL values**:  
   - Populated missing industries by joining same-company records  
4. **Date formatting**:  
   - Converted text dates to DATE type using `str_to_date()`  

## 🚀 How to Use
1. Run `SQL(1).sql` in your MySQL environment  
2. View cleaned data samples in the `/output` folder:  
   - `cleaned_sample.csv` (data preview)  
   - `cleaning_stats.txt` (summary of changes)  

## 💡 Skills Demonstrated
- SQL data cleaning  
- Handling NULLs and duplicates  
- Data standardization  
