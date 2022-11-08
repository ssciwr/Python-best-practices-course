# 1. Code alignment

Which of the below alignments are correct?

- [ ] a

        abs_area = area_A + area_B +
          area_C + area_D

- [ ] b

        abs_area = area_A + area_B 
            + area_C + area_D

I think there must be a backslash, otherwise wrong syntax?!

- [ ] c

        result = my_function(area_A, area_B, 
            area_C, area_D)

- [x] d

        result = my_function(area_A, area_B, 
                             area_C, area_D)

- [x] e

        result = my_function(
            area_A, area_B, 
            area_C, area_D
            )

# 2. Naming conventions

Which of the below naming conventions are correct?  

Classes:  
- [ ] a `class my-first-analysis:` 
- [ ] b `class my_first_analysis:` 
- [ ] c `class Myfirstanalysis:` 
- [x] d `class MyFirstAnalysis:`   

Functions:  
- [x] a `def calc_area(x):` 
- [ ] b `def calc-area(x):` 
- [ ] c `def calcarea(x):` 
- [ ] d `def Calc_area(x):`   

Variables:  
- [ ] a `O = abs(x)`
- [ ] b `I = abs(x)`
- [ ] c `l = abs(x)`
- [x] d `abs_x = abs(x)`  

Constants:  
- [x] a `THRESHOLD = 0.1`
- [ ] b `threshold = 0.1`
- [ ] c `Threshold = 0.1`
- [ ] d `T = 0.1`  

d is ok, but not very informative

Other:  
- [ ] a `list = my_areas`
- [x] b `list_ = my_areas`
- [ ] c `__list__ = my_areas`
- [ ] d `_list = my_areas`  

avoid clash

Modules:  
- [ ] a `Numerical.py`
- [ ] b `numerical.py`
- [x] c `numerical_analysis.py`
- [ ] d `numerical-analysis.py`

Packages:  
- [ ] a `MyCoolPackage`
- [ ] b `my-cool-package`
- [ ] c `my_cool_package`
- [x] d `analysator`