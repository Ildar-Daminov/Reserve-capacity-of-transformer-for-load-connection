[![DOI](https://zenodo.org/badge/416074946.svg)](https://zenodo.org/doi/10.5281/zenodo.12510117)

# Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection
<img align="left" alt="Coding" width="90" src="https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/86/2b/34/862b34d7-a946-7cbd-3267-5d0e6fecedae/source/512x512bb.jpg">

  
This repository shares the MATLAB code and data for the conference paper 📋:\
Ildar Daminov, Anton Prokhorov,Tatiana Moiseeva, Marie-Cécile Alvarez-Hérault, Raphaël Caire,["Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection"](https://www.cired-repository.org/bitstream/handle/20.500.12455/708/CIRED%202019%20-%202051.pdf?sequence=1&isAllowed=y) in CIRED conference, Madrid, Spain, 2019.
  
  
## Paper's abstract
This paper presents new approach to determine power reserve of congested primary substations by taking into account the thermal modelling of power transformers. As novelty, the proposed approach considers the uncertainty of thermal model's input parameters-annual ambient temperature variation and annual irregularity of new consumer's load profile. The approach suggested ensures power transformers to continue operation within the acceptable thermal parameters when new consumers are interconnected for this reserve value. The proposed approach is evaluated for real primary substation, located at Tomsk, Russia. The results are compared with conventional approach for reserve determination.

## How to run a code 
There are two ways how you may run this code:
  
I. Launching all calculations at once. This will reproduce all figures in the paper for 20 seconds:
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
* T_history_Tomsk.mat - Historical ambient temperature in Tomsk, Russia ([weather data](https://www.meteoblue.com/en/historyplus) provided by [meteoblue](https://www.meteoblue.com/))

## How to cite this paper 
Ildar Daminov, Anton Prokhorov,Tatiana Moiseeva, Marie-Cécile Alvarez-Hérault, Raphaël Caire,"Application of dynamic transformer ratings to increase the reserve of primary substations for new load interconnection"in in CIRED conference, Madrid, Spain, 2019.


## More about DTR of power transformers 
<img align="left" alt="Coding" width="250" src="https://sun9-19.userapi.com/impg/3dcwjraHJPNgrxtWv7gEjZTQkvv5T0BttTDwVg/e9rt2Xs8Y5A.jpg?size=763x1080&quality=95&sign=7c57483971f31f7009fbcdce5aafd97e&type=album">This paper is a part of PhD thesis "Dynamic Thermal Rating of Power Transformers: Modelling, Concepts, and Application case". The full text of PhD thesis is available on [Researchgate](https://www.researchgate.net/publication/363383515_Dynamic_Thermal_Rating_of_Power_Transformers_Modelling_Concepts_and_Application_case) or [HAL theses](https://tel.archives-ouvertes.fr/tel-03772184). Other GitHub repositories on DTR of power transformers:
* Article: Assessment of dynamic transformer rating, considering current and temperature limitations. [GitHub repository](https://github.com/Ildar-Daminov/Assessment_Dynamic_Thermal_Rating_of_Transformers)
* Article: Demand Response Coupled with Dynamic Thermal Rating for Increased Transformer Reserve and Lifetime. [GitHub repository](https://github.com/Ildar-Daminov/Demand-response-coupled-with-DTR-of-transformers)
* Article: Energy limit of oil-immersed transformers: A concept and its application in different climate conditions. [GitHub repository](https://github.com/Ildar-Daminov/Energy-limit-of-power-transformer)
* Conference paper: Optimal ageing limit of oil-immersed transformers in flexible power systems [GitHub repository](https://github.com/Ildar-Daminov/MATLAB-code-for-CIRED-paper)
* Conference paper: Receding horizon algorithm for dynamic transformer rating and its application for real-time economic dispatch. [GitHub repository](https://github.com/Ildar-Daminov/Receding-horizon-algorithm-for-dynamic-transformer-rating)
