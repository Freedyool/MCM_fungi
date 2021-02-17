# instruction

We use R and excel to process our data. Here we will explain how we deal with our dataset.

## how we deal with competition matrix

Experimental_outcomes.csv -> mat.csv -> compe.mat

## how we deal with enviromental data

- real tempreture curve
  - S2021*.txt(3 files) -> datasetForMatlab/c*.mat(4 files)
- moisture classify
  - Table4(details in 5.4 of the paper)

## how we deal with extension rate

- original data
  - Fungi_moisture_curves.csv
  - Fungi_tempreture_curves.csv
- processed data
  - extension_rate.7z(37 files)
- code used data
  - gr*.mat(tempreture-extension curves fitted under different moisture types)(5 files)

## how we deal with decomposition rate

- original data
  - Fungi_tempreture_curves.csv
- processed data
  - decomposition_rate.7z(37 files)
- processed data
  - dr.mat(tempreture-decomposition curves fitted)

## data processing tools

R excel(plot also) matlab
