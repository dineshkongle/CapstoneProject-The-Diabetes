# CapstoneProject-The-Diabetes
Project Overview:
This capstone project applies predictive analytics in healthcare, specifically targeting diabetes health prediction. The primary aim is to leverage advanced machine learning techniques—Regression Analysis, Random Forest, and Support Vector Machines (SVM)—to develop models that predict the likelihood of diabetes complications effectively. This project investigates two primary research questions:
1) What are the significant predictors of diabetes?
2) Can machine learning models accurately predict the risk of developing diabetes based on identified risk factors?


Data Source:
The dataset used for this analysis is sourced from a public GitHub repository, which includes clinical and demographic data essential for diabetes outcome predictions. Detailed information about the dataset can be found on the Diabetes Health Prediction and Analysis GitHub page.


Setup and Installation:
To run this project, you need to have Python and SAS installed on your machine. Ensure you also have the following Python libraries:
Pandas
NumPy
Scikit-learn
Matplotlib
For Python: pip install pandas numpy scikit-learn matplotlib
For SAS, ensure you have access to the base software.


Usage:
Follow these steps to run the analysis:
1) Clone the repository to your local machine.
2) Ensure that the dataset is located in the root directory.
3) Run the Jupyter Notebook (CapstoneProject.ipynb) for Python analysis or the SAS file (CapstoneProject.sas) for SAS analysis to generate the predictive models.


Results:
The study validated the alternative hypothesis by identifying significant predictors of diabetes complications. Machine learning models, particularly Random Forest, showed high predictive accuracy, with the following features demonstrating significant importance:
- **Fasting Blood Sugar**
- **HbA1c**
- **Frequent Urination**
- **High Blood Pressure**

The Random Forest model exhibited an ROC AUC of 0.97, indicating excellent model performance. 
Refer to docs file For detailed findings and analysis.


Contributing:
Contributions to this project are welcome. Please fork the repository and submit a pull request with your additions.
