# Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection
<img align="left" alt="Coding" width="60" src="https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/86/2b/34/862b34d7-a946-7cbd-3267-5d0e6fecedae/source/512x512bb.jpg">

  
This repository shares the MATLAB code and data for the conference paper 📋:\
Ildar Daminov, Anton Prokhorov,Tatiana Moiseeva, Marie-Cécile Alvarez-Hérault, Raphaël Caire,["Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection"](https://www.cired-repository.org/bitstream/handle/20.500.12455/708/CIRED%202019%20-%202051.pdf?sequence=1&isAllowed=y) in CIRED conference, Madrid, Spain, 2019.
  
  
## Paper's abstract
This paper presents new approach to determine power reserve of congested primary substations by taking into account the thermal modelling of power transformers. As novelty, the proposed approach considers the uncertainty of thermal model's input parameters-annual ambient temperature variation and annual irregularity of new consumer's load profile. The approach suggested ensures power transformers to continue operation within the acceptable thermal parameters when new consumers are interconnected for this reserve value. The proposed approach is evaluated for real primary substation, located at Tomsk, Russia. The results are compared with conventional approach for reserve determination.

## How to run a code 
There are two ways how you may run this code:
  
I. Launching all calculations at once. This will reproduce all figures in the article but it would take 6-7 minutes:
1. Copy this repository to your computer 
2. Open the script main.m
3. Launch the script "main.m" by clicking on the button "Run" (usually located at the top of MATLAB window).\
As alternative, you may type ```main``` 
in Command Window to launch the entire script. 


II. Launching the specific section of the code to reproduce the particular figure: 
1. Copy this repository to your computer 
2. Open the script main.m 
3. Find the section (Plotting the Figure XX) corresponding to the Figure you would like to reproduce. 
4. Put the cursor at any place of this section and click on the button "Run Section" (usually located at the top of MATLAB window)


## Files description
Main script:
* main.m - the principal script which launches all calculations
  
Additional functions: 
* ONAF_transformer.m - a thermal model of ONAF power transformer (up to 100 MVA) per the loading guide IEC 60076-7. ONAF stand for a cooling system : Oil Natural Air Forced
  
More details are given inside of functions and script "main.m"

Initial data:
* Initial_Data - Load profile + ambient temperature profile + time vector 
* T_history_Tomsk.mat - Historical ambient temperature in Tomsk, Russia (source: [MeteoBlue](https://www.meteoblue.com/fr/historyplus))

## How to cite this paper 
Ildar Daminov, Anton Prokhorov,Tatiana Moiseeva, Marie-Cécile Alvarez-Hérault, Raphaël Caire,"Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection"in in CIRED conference, Madrid, Spain, 2019.
