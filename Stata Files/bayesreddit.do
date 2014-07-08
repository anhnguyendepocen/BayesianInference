insheet using bayes.txt, tab clear names
rename whatsthemostyouarewillingtopayto wtptails
rename v31 wtpheads
rename whatpercentchancedoyoubelievethe pctheads
ren whatdoyoubelievethepercentbiasof biasheads
ren didyoucomeherefromasite site
ren levelofeducation education
ren whichcolordoyoubeton roulettecolor
ren whydidyoubetonthat roulettewhy
ren whatisthemostyouarewillingtopayf wtplottery
ren flip1outof20 flip1
ren flip2outof20 flip2
ren flip3outof20 flip3
ren flip4outof20 flip4
ren flip5outof20 flip5
ren flip6outof20 flip6
ren flip7outof20 flip7
ren flip8outof20 flip8
ren flip9outof20 flip9
ren flip10outof20 flip10
ren flip11outof20 flip11
ren flip12outof20 flip12
ren flip13outof20 flip13
ren flip14outof20 flip14
ren flip15outof20 flip15
ren flip16outof20 flip16
ren flip17outof20 flip17
ren flip18outof20 flip18
ren flip19outof20 flip19
ren flip20outof20 flip20


replace age = "9-13" if age=="'9-13"
gen age8under = age == "ages 8 or under"
gen age9_13 = age == "9-13"
gen age14_17 = age == "14-17"
gen age18_25 = age == "18-25"
gen age26_35 = age == "26-35"
gen age36_45 = age == "36-45"
gen age46_55 = age == "46-55"
gen age65up = age == "over 65"

*label var age8under "ages 8 or under"
*label var age9_13 "ages 9-13"
*label var age14_17 "ages 14-17"
*label var age18_25 "ages 18-25"
*label var age26_35 "ages 26-35"
*label var age36_45 "ages 36-45"
*label var age46_55 "ages 46-55"
*label var age65up "ages over 65"

tab age, gen(agegroup)
label var agegroup1 "ages 8 or under"
label var agegroup2 "ages 9-13"
label var agegroup3 "ages 14-17"
label var agegroup4 "ages 18-25"
label var agegroup5 "ages 26-35"
label var agegroup6 "ages 36-45"
label var agegroup7 "ages 46-55"
label var agegroup8 "ages over 65"

label define age 5 "8 or under", modify
label define age 10 "9-13", modify
label define age 15 "14-17", modify
label define age 21 "18-25", modify
label define age 30 "26-35", modify
label define age 40 "36-45", modify
label define age 50 "46-55", modify
label define age 60 "56-65", modify
label define age 75 "over 65", modify
encode age, gen(age2) label(age)
drop age
ren age2 age


label define gender 0 "Male", modify
label define gender 1 "Female", modify
gen byte gender2:gender = gender == "Female"
drop gender
ren gender2 gender
label var gender "Gender"


replace wtplottery = 100 if wtplottery > 100
egen wtplottery5 = cut(wtplottery), at(0(5)105)
label var wtplottery "WTP for lottery in $"
label var wtplottery5 "WTP for lottery in $5"

destring wtpheads, replace
egen wtpheads5 = cut(wtpheads), at(0(5)105)
label var wtpheads "WTP for calling heads"
label var wtpheads5 "WTP for calling heads in $5"


list pctheads if pctheads < 1
replace pctheads = pctheads*100 if pctheads < 1
egen pctheads5 = cut(pctheads), at(0(5)105)
label var pctheads "% weight of heads"
label var pctheads5 "% weight of heads (5% incr)"

egen biasheads2 = cut(biasheads), at(0(5)105)
drop biasheads
ren biasheads2 biasheads
label var biasheads "Estimation of heads bias"


***ORDER
order timestamp gender age ethnicity education fieldofstudy roulettecolor roulettewhy independence wtplottery wtplottery5 wtpheads wtpheads5 pctheads pctheads5 biasheads
**OR
order flip1-flip20 agegroup1-agegroup7, last

append gender age ethnicity education fieldofstudy roulettewhy independence wtplottery5 wtpheads

******GRAPHS
histogram wtplottery2, discrete percent title("Lottery: 50% for $100") subtitle("(Presented before trials)") xtit("Willingness to pay")
