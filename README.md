# persuasion-analysis

# Student Persuasion Analysis

## Overview

This project explores how personality traits and discourse characteristics
relate to persuasion success among university students.

The analysis combines:

- Exploratory Data Analysis (EDA)
- Principal Component Analysis (PCA)
- K-Means Clustering
- Logistic Regression

The objective was to identify student profiles associated with a greater
probability of persuading a debate partner.

## Dataset

The dataset contains 49 psychology students who participated in a structured debate about the use of ChatGPT in academic contexts.

Variables include:

- Extraversion
- Number of Arguments
- Connectors
- Politeness Indicators
- Rudeness Indicators
- Powerless Language Indicators

Target variable:

- Persuasion Outcome

## Repository Structure

persuasion-analysis/
│
├── README.md
├── report/
│   └── Persuasion_Analysis_Report.pdf
│
├── data/
│   ├── PersuasionPART1.csv
│   ├── PersuasionPART2_numeric.csv
│   ├── PersuasionPART3_pca.csv
│   ├── PersuasionPART4_std.csv
│
├── notebooks/
│   ├── 01_exploratory_analysis.ipynb
│   └── 03_clustering_analysis.ipynb
│
├── scripts/
│   ├── 02_principal_component_analysis.R
│   └── 04_logistic_regression.R
│
└── figures/
    ├── correlation_matrix.png
    ├── scree_plot.png
    ├── pca_components.png
    ├── clusters.png
    ├── radar_cluster1.png
    └── ...

    
## Analysis Workflow

### Part 1
Exploratory analysis and correlation analysis.

File:
- notebooks/01_exploratory_analysis.ipynb

### Part 2
Principal Component Analysis (PCA).

File:
- scripts/02_principal_component_analysis.R

### Part 3
K-Means clustering and cluster interpretation.

File:
- notebooks/03_clustering_analysis.ipynb

### Part 4
Logistic regression and model evaluation.

File:
- scripts/04_logistic_regression.R

## Main Findings

Students who successfully persuaded their partners tended to:

- Score higher on extraversion
- Display stronger discourse skills
- Show more politeness indicators
- Avoid excessive rudeness indicators

The best-performing predictive model achieved:

- Accuracy: 0.80
- Precision: 0.71
- Recall: 0.77
- F1 Score: 0.74

## Full Report

The complete report is available at:

report/Persuasion_Analysis_Report.pdf
