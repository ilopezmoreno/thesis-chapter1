/* 
This master do-file includes three main instructions to Stata
1. Establishing the main global working directories. 
2. Creating the folder structure
3. Running the rest of the do-files
*/

clear

// GLOBAL WORKING DIRECTORES
global root "C:/Users/d57917il/Documents/GitHub/thesis-chapter1" // Always use forward slashes in working directories
*global enoe_datasets ""

// FOLDER CREATION

capture mkdir 1_do-files
capture mkdir 2_data-storage
capture mkdir 3_documentation
capture mkdir 4_outputs

cd "$root/4_outputs"
capture mkdir descriptive_statitistics
capture mkdir tables
capture mkdir figures
capture mkdir regression_results
capture mkdir margins_results
capture mkdir marginsplots


// Run do-files
cd "$root"
do "2_dofile_folder-creation.do"	



* folder_creation

* data_download

* data_cleaning

* merge

* data_transformation
* rename
* recode
* relabel

* data_analysis

* descriptive_statistics

* regressions

* tables

* graphs

*  






** Es importante empezar mencionando que este codigo se creo utilizando la version de Stata 17. 
** Es posible que si cuentas con una version menor a stata 17, algunos de los codigos no funciones. 
** Debido a esto, se utiliza el siguiente codigo para especificar que el codigo requiere de stata 17 o mas para funcionar correctamente. 
