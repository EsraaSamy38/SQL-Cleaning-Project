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


## 📷 Visual Examples (Before & After)         


<!-- Row 1: Before Cleaning -->
<p><strong>🔹Before Cleaning</strong></p>
<p align="center">
  <img src="images/null1.png" width="440"/>
  <img src="images/duplicate1.png" width="455"/>
  
</p>

<!-- Row 2: After Cleaning -->
<p><strong>🔹After Cleaning</strong></p>
<p align="center">
  <img src="images/after1.png" width="200"/>
  <img src="images/after2.png" width="200"/>
  <img src="images/after3.png" width="200"/>
</p>



## 🚀 How to Use
1. Run `SQL(11).sql` in MySQL Workbench  
2. View results in `output`📄 folder:  
   - [cleaned_sample.csv](output/cleaned_sample.csv)   (5-row data preview)  
   - [cleaning_stats.txt](output/cleaning_stats.txt) (cleaning summary)  

## 💡 Skills Demonstrated
- Advanced SQL data cleaning  
- Handling NULLs/duplicates  
- Data standardization  
- Date formatting

## 📁 Data Source

- [Download Layoffs_Dataset (Excel)](Layoffs_Dataset.xlsx)📄 
This dataset includes information about Layoffing of employees in companies over 3 years (2020-2023)
