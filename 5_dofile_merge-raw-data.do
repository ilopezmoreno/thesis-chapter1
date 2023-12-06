/* 	This do-file includes three sections
	1. Brief explanation of the datasets 
	2. Data cleaning 
	3. Merge */

/* 	Brief explanation of the datasets

	The National Occupation and Employment Survey (ENOE) is the main source of information on the Mexican labor market.
	- It provides monthly and quarterly data about labor force, employment, labor informality, underemployment and unemployment. 
	- It is the largest continuous statistical project in the country. 
	- It provides national figures for four locality sizes, for each of the 32 mexican states and for a total of 39 cities.
	- The first trimester of each year it is an AMPLIFIED survey 
	- The 2nd, 3rd and 4th trimester of each year it is a BASIC survey

	INEGI separates ENOE surveys in five different categories:
	1) coe1 - This database stores the FIRST part of the questions of the ENOE survey (Basic or amplified).
	2) coe2 - This database stores the SECOND part of the questions of the ENOE survey (Basic or amplified).
	3) hog - This database stores questions about household characteristics.
	4) sdem - This database stores the sociodemographic characteristics of all household members.
	5) viv - This database stores the data from the front side of the sociodemographic questionnaire  */

/* 	INEGI recommends to always uses the SDEM dataset as the reference dataset 
	and then merge it with the datasets that includes the questions that you are interested in. 
	But before doing that, it is necessary to execute a data cleaning process. 
	Moreover, it is worth noting that for this research project I will be using 
	the datasets for the 1st quarters of 2005, 2010, 2015 & 2019.
	Therefore, I have to create a loop to perform the data cleaning and merge the datasets. */

// Creating the loop  	
local year_quarter ///
105 /// 1st quarter of 2005
110 /// 1st quarter of 2010
115 /// 1st quarter of 2015
119 //	1st quarter of 2019

foreach year_q of local year_quarter {

// DATA CLEANING 

	/* INEGI explains that it is necessary to execute a data cleaning process in the demographic dataset (SDEM) 
	in case you want to combine it with the employment datasets (COE1 and COE2)
	All the specifications are explained in page 13 of the following document: */

	/* First, INEGI recommends to drop all the kids below 12 years old from the sample because 
	those kids where not interviewed in the employment survey. Therefore, it is not necesary to keep them. 
	More specifically, they explain that all the values between 00 and 11 as well as those equal to 99 in "eda" variable should be dropped. 
	Remember that variable "eda" is equal to "age".*/
	
	drop if eda<=11
	drop if eda==99

	/* Second, INEGI recommends to drop all the individual that didn't complete the interview. 
	More specifically, the explain that I should eliminate those interviews where the variable "r_def" is 
	different from "00", since "r_def" is the definitive result of the interview and "00" indicates 
	that the interview was completed. */

	drop if r_def!=00 

	/* 	Third, INEGI recommends to drop all the interviews of people who were absent during the interview, 
	since there is no labor information or the questionnaire was not applied to the absentees.
	More specifically, they explain that I should eliminate those interviews where the variable "c_res" is equal to "2", 
	since "c_res" shows the residence condition and "2" is for definitive absentees.  */
	
	drop if c_res==2 

	
// MERGE PROCESS 

	* Now that the data cleaning process is complete, I will start the merging process. 
	* The first step is to merge the SDEM Database with the COE1 survey 
	merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE1T`year_q'
	rename _merge merge_COE1T`year_q'

	* The second step is to merge the SDEM Database with the COE2 survey 
	merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE2T`year_q'
	rename _merge merge_COE2T`year_q'

