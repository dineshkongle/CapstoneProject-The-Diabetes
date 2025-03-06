/* IMPORT DATA SET */
PROC IMPORT DATAFILE=REFFILE 
	DBMS=CSV 
	OUT=MYLIBCAP.CAPSTONE; 
	GETNAMES=YES; 
RUN; 
/* Overview of each variable */
PROC CONTENTS DATA=MYLIBCAP.CAPSTONE; RUN; 


/* Summary Statistics */
proc means data=MYLIBCAP.CAPSTONE N mean std min max; 
	var Age BMI DiastolicBP SystolicBP FastingBloodSugar HbA1c; 
	class Gender Ethnicity; 
	title "Summary Statistics for Key Variables"; 
run;


/* Remove DoctorInCharge due to confidentiality concerns*/
data MYLIBCAP.CAPSTONE_cleaned;
    set MYLIBCAP.CAPSTONE;
    drop DoctorInCharge;
run;


/* Creating Dummy Variables for variables like Ethnicity, SocioeconomicStatus, and EducationLevel which are coded as integers but are categorical*/
data MYLIBCAP.CAPSTONE_prepped;
    set MYLIBCAP.CAPSTONE_cleaned;

    /* Creating dummy variables for Ethnicity */
    if Ethnicity = 0 then Ethnicity_0 = 1; else Ethnicity_0 = 0;
    if Ethnicity = 1 then Ethnicity_1 = 1; else Ethnicity_1 = 0;
    if Ethnicity = 2 then Ethnicity_2 = 1; else Ethnicity_2 = 0;
    if Ethnicity = 3 then Ethnicity_3 = 1; else Ethnicity_3 = 0;

    /* Creating dummy variables for SocioeconomicStatus */
    if SocioeconomicStatus = 0 then SES_0 = 1; else SES_0 = 0;
    if SocioeconomicStatus = 1 then SES_1 = 1; else SES_1 = 0;
    if SocioeconomicStatus = 2 then SES_2 = 1; else SES_2 = 0;

    /* Creating dummy variables for EducationLevel */
    if EducationLevel = 0 then Edu_0 = 1; else Edu_0 = 0;
    if EducationLevel = 1 then Edu_1 = 1; else Edu_1 = 0;
    if EducationLevel = 2 then Edu_2 = 1; else Edu_2 = 0;
    if EducationLevel = 3 then Edu_3 = 1; else Edu_3 = 0;
run;

/* standardization of BMI, SystolicBP, and DiastolicBP, this transformation makes these variables ready for inclusion in analytical models that might be sensitive to variable scaling, ensuring that all the features contribute equally to the analysis, regardless of their original units or scales. */
proc standard data=MYLIBCAP.CAPSTONE_prepped out=MYLIBCAP.CAPSTONE_standardized mean=0 std=1;
    var BMI SystolicBP DiastolicBP;
run;


/* Descriptive Statistics and Visualizations */
proc means data=MYLIBCAP.CAPSTONE_standardized;
    var BMI SystolicBP DiastolicBP;
run;

/* Histograms for continuous variables */
proc sgplot data=MYLIBCAP.CAPSTONE_standardized;
    histogram BMI;
    title "Distribution of BMI";
run;

proc sgplot data=MYLIBCAP.CAPSTONE_standardized;
    histogram SystolicBP;
    title "Distribution of Systolic BP";
run;

proc sgplot data=MYLIBCAP.CAPSTONE_standardized;
    histogram DiastolicBP;
    title "Distribution of Diastolic BP";
run;

/* Bar charts for categorical data */
proc sgplot data=MYLIBCAP.CAPSTONE_standardized;
    vbar Ethnicity;
    title "Distribution by Ethnicity";
run;


/* Frequency Distributions for Categorical Data */
proc freq data=MYLIBCAP.CAPSTONE_standardized;
    tables Diagnosis;
    title "Frequency Distribution of Diagnosis";
run;



/* Additional visualizations – Education Level */
proc sgplot data=MYLIBCAP.CAPSTONE_standardized;
    vbar EducationLevel;
    title "Distribution by Education Level";
run;



/* Logistic Regression to identify the significant predictors of diabetes */
proc logistic data=MYLIBCAP.CAPSTONE_standardized;
   class Gender(ref='0') FamilyHistoryDiabetes(ref='0') 
         Edu_0(ref='0') Edu_1(ref='0') Edu_2(ref='0') Edu_3(ref='0') 
         Ethnicity_0(ref='0') Ethnicity_1(ref='0') Ethnicity_2(ref='0') Ethnicity_3(ref='0') 
         SES_0(ref='0') SES_1(ref='0') SES_2(ref='0')
         / param=ref;
   model Diagnosis(event='1') = Age BMI FamilyHistoryDiabetes Gender PhysicalActivity AlcoholConsumption
                                Edu_0 Edu_1 Edu_2 Edu_3 Ethnicity_0 Ethnicity_1 Ethnicity_2 Ethnicity_3
                                SES_0 SES_1 SES_2;
   output out=pred p=pred;
run;


