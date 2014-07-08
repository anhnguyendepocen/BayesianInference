insheet using bayes.txt, tab clear names
rename whatsthemostyouarewillingtopayto wtptails
rename v31 wtpheads
rename whatpercentchancedoyoubelievethe pctheads
ren whatdoyoubelievethepercentbiasof biasheads
ren didyoucomeherefromasite site
ren levelofeducation education
ren whichcolordoyoubeton colorbet
ren whydidyoubetonthat colorind
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
gen age8under =  age == "8 or under"
gen age9_13 = age == "'9-13"
gen age14_17 =  age == "14-17"
gen age18_25 =  age == "18-25"
gen age26_35 =  age == "26-35"
gen age36_45 =  age == "36-45"
gen age46_55 =  age == "46-55"
gen age65up =  age == "over 65"



egen pctheads2 = cut(pctheads), at(0(5)100)

gen ind = colorind == "I bet randomly" || colorind == "I don't know or I don't care"
gen notind = colorind == "Black hasn't come up in a while" || colorind == "Red is the current trend"

destring wtpheads, replace
egen wtpheads2 = cut(wtpheads), at(0(5)100)
replace wtpheads2 = 100 if wtpheads2 >= .