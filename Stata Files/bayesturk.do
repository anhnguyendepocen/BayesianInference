
insheet using bayesturk.csv, comma names clear

ren levelofeducation education
ren whichcolordoyoubeton roulettecolor
ren whydidyoubetonthat roulettewhy
ren whatisthemostthatyouwouldbewilli wtplottery
ren flip1of20 flip1
ren flip2of20 flip2
ren flip3of20 flip3
ren flip4of20 flip4
ren flip5of20 flip5
ren flip6of20 flip6
ren flip7of20 flip7
ren flip8of20 flip8
ren flip9of20 flip9
ren flip10of20 flip10
ren flip11of20 flip11
ren flip12of20 flip12
ren flip13of20 flip13
ren flip14of20 flip14
ren flip15of20 flip15
ren flip16of20 flip16
ren flip17of20 flip17
ren flip18of20 flip18
ren flip19of20 flip19
ren flip20of20 flip20

*	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20
*	H	H	T	H	H	T	H	H	H	H	T	H	T	H	H	H	T	H	H	H
* H H T H H T H H H H T H T H H H T H H H
foreach num of numlist 1/2 4/5 7/10 12 14/16 18/20 {
	label variable flip`num' "[H] Flip `num'/20"
}

foreach num of numlist 3 6 11 13 17 {
	label variable flip`num' "[T] Flip `num'/20"
}


local tails flip3 flip6 flip11 flip13 flip17
local heads flip1 flip2 flip4 flip5 flip7 flip8 flip9 flip10 flip12 flip14 flip15 flip16 flip18 flip19 flip20

ren howdoyoucallitheadsortails call
ren whatsthemostyoudbewillingtospend wtpcall
ren whatpercentchancedoyoubelievethe pctheads
ren howdoyoubelievethiscoinisweighte weighted


label define call 0 "Tails" 1 "Heads"
encode call, gen(call2) label(call)
drop call
ren call2 call

foreach X of numlist 1/20 {
	encode flip`X', gen(t`X') label(call)
}
drop flip1-flip20

replace wtpcall = "$100" if wtpcall == "More than $100"
destring wtpcall, replace ignore($)


label define gender 0 "Male", modify
label define gender 1 "Female", modify
gen byte gender2:gender = gender == "Female"
drop gender
ren gender2 gender
label var gender "Gender"


label define roulettecolor 0 "Black", modify
label define roulettecolor 1 "Red", modify
gen byte roulettecolor2:roulettecolor = roulettecolor == "Red"
drop roulettecolor
ren roulettecolor2 roulettecolor
label var roulettecolor "Color bet on"

label define roulettewhy 1 "Black hasn't come up in a while", modify
label define roulettewhy 2 "Red is the current trend", modify
label define roulettewhy 3 "I bet randomly", modify
label define roulettewhy 4 "I don't know or I don't care", modify
encode roulettewhy, gen(roulettewhy2) label(roulettewhy)
drop roulettewhy
ren roulettewhy2 roulettewhy
label var roulettewhy "Bet reasoning"

*label define independence 0 "No", modify
*label define independence 1 "Yes", modify
label define independence 0 "Nonindependent", modify
label define independence 1 "Independent", modify
gen independence = roulettewhy == 3 | roulettewhy == 4
label values independence independence
label var independence "Independence"


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

gen ethnicity2 = regexs(1) if regexm(ethnicity, "^([^\,]*)\,*.*")
label define ethnicity 0 "Other", modify
label define ethnicity 1 "American Indian / Native American", modify
label define ethnicity 2 "Asian", modify
label define ethnicity 3 "Black / African", modify
label define ethnicity 4 "East Indian / Asian Subcontinent" , modify
label define ethnicity 5 "Hispanic / Latino", modify
label define ethnicity 6 "Jewish", modify
label define ethnicity 7 "Middle Eastern", modify
label define ethnicity 8 "Pacific Islander", modify
label define ethnicity 9 "White / Caucasian", modify
encode ethnicity2, gen(ethnicity3) label(ethnicity)
drop ethnicity ethnicity2
ren ethnicity3 ethnicity
label var ethnicity "Ethnicity"


replace region = "Central Asia (the stans)" if region == ")"
encode region, gen(region2)
drop region
ren region2 region

label define education 1 "Less than High School or GED", modify
label define education 2 "High School or GED", modify
label define education 3 "Some College", modify
label define education 4 "Associates Degree and/or Technical Certifications", modify
label define education 5 "Bachelors Degree", modify
label define education 6 "Masters Degree", modify
label define education 7 "Doctorate", modify
encode education, gen(education2) label(education)
drop education
ren education2 education
label var education "Level of education"


replace wtplottery = 100 if wtplottery > 100
egen wtplottery5 = cut(wtplottery), at(0(5)105)
label var wtplottery "WTP for lottery"
label var wtplottery5 "WTP for lottery (5% incr)"


replace fieldofstudy = "Humanities" if fieldofstudy == "Humanities / Liberal Arts"
replace fieldofstudy = "STEM" if fieldofstudy == "STEM (Science, Technology, Engineering, Math)"
label define fieldofstudy 0 "Other", modify
label define fieldofstudy 1 "Humanities", modify
label define fieldofstudy 2 "Medicine", modify
label define fieldofstudy 3 "Social Sciences", modify
label define fieldofstudy 4 "STEM", modify
encode fieldofstudy, gen(fieldofstudy2) label(fieldofstudy)
drop fieldofstudy
ren fieldofstudy2 fieldofstudy


replace weighted = subinstr(weighted, "50% tails, 50% heads", "50%/50%", .)
replace weighted = subinstr(weighted, " biased towards heads", "H", .)
replace weighted = subinstr(weighted, " biased towards tails", "T", .)
label define weighted 0 "100%T" 1 "95%T" 2 "90%T" 3 "85%T" 4 "80%T" 5 "75%T" 6 "70%T" 7 "65%T" 8 "60%T" 9 "55%T" 10 "50%/50%" 11 "55%H" 12 "60%H" 13 "65%H" 14 "70%H" 15 "75%H" 16 "80%H" 17 "85%H" 18 "90%H" 19 "95%H" 20 "100%H"
encode weighted, gen(weighted2) label(weighted)
drop weighted
ren weighted2 weighted


*forvalues i = 1/20 {
*	ren t`i' flip`i'
*}


order sample timestamp gender age ethnicity region education fieldofstudy roulettecolor roulettewhy independence wtplottery5 wtpheads wtpheads5 pctheads5 biasheads


****GRAPHS

hist pctheads00, percent title("Bayesian Inference Distribution") subtitle("After series of flips") ytitle("Percent of sample") xtitle("Chance of toss being heads") xlabel(0 25 50 75 100,valuelabel) legend(off) by(ind)

graph twoway (lfitci wtplottery wtpcall) (scatter wtplottery wtpcall), title("WTP Correlation") subtitle("Before and after series of flips") ytitle("WTP 50% Lottery (Before)") xtitle("WTP Coin Lottery (After)") legend(off)