## Introduction

This repository was built for MCM competition. In this match, we choosed Probelm_A which required us to build a model to study the interaction between different types of fungal communities. To solve this problem, we built three models bellow. Here we will show you the relating dataset and our code files. The concrete description will also be provided so that you can repeat our results.(if you care about the result only, go to the bottom of this README file[Last Part] please)

## Our Work

Model One-Decomposition of Individual Fungal Species.

Model Two-Fungal Community Evolution Model.

Model Three-Decay Activity of Multiple Species of Fungi.

Our dataset and code files were divided into two parts. First part was all about model-two above. Another part was about model-one and model-three.

First part (Markov chain model):

dataset

- original_data/Experimental_outcomes.csv
- processed_data/mat.csv

code file

- R script/pro_1.r(part of this code file): we use this to obtain the competition matrix
- code/MatlabScript/markov.m getp.m

Second Part (Cellular automaton):

dataset

- original_data(all)
- processed_data/datasetForMatlab.zip(all)

code file

- code/MatlabScript(all)

## Tips for Part Two

In MatlacSript/Pro1.m code file, we have four code blocks. The first three code blocks contained three different system parameter settings for different experiments.

The first one was setted to simulate the decomposition of individual fungal species which corresponding with Model One.

The second one was setted to simulate the fungi competition between just two species. You can get two simulation cases by changing the competition matrix.([0 0.5 1; 0.5 0 1;0 0 0] for a stalemate case and [0 1 1; 1 0 1; 0 0 0] for an occupation case)

The third one was setted to simulate multiple species of fungi under the ideal laboratory environment. Also, if you want to sumulate the real enviroment, you should modify these system parameters as you want.

After choosing one of three code blocks above to execute, you should then excute code block 4. Usually it takes about 1 to 5 minutes to get the simulation result. Further, you should excute code block 5 to obtain the output of this cellular automata.(details in 5.3 of our paper)

## Last Part

If you just want to validate our results in paper, you should follow steps bellow.(It's our mistakes that we didn't use random seed to make sure that you can really repeat our simulation and get the same result, but we have saved our result matrix to let you know that our results are not fake.)

First, you should load all dataset required.(unzip the processed_data/datasetForMatlab.zip and make sure all mat files are in your workspace)

Secondly, put the code file into your workspace.(code/MatlabScript/my_calc.m)

Thirdly, load the simulation result.(result/exp1/5-9.mat)

At last, remove the comment on line 25(in my_calc.m) and excute this code file.
