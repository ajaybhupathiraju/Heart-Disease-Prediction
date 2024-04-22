---------- Age column anaysis ----------

-- No of patients group by age
select h.age,count(1) from heartdisease h
group by h.age
order by h.age asc


--Identify top 10 age groups % having heart diseases 
select h.age,cast(count(1) as float)/(select count(1) from heartdisease h1)*100 "No of heart patients" from heartdisease h 
where h.target = 1
group by h.age
order by count(1) desc
limit 10

-- Age with high cholestrol levels > 240 mg/dL and above
select h.age,avg(h.cholesterol)"average cholesterol levels",count(1)"No of patients" from heartdisease h 
group by h.age
having avg(h.cholesterol) >240
order by h.age

-- blood presure increases, patiens gets older
select h.age,count(1) from heartdisease h 
where h."resting bp s" > 140
group by h.age
having count(1) > 10
order by count(1) desc 

-- No of patients group by age,sex
select h.age,case when h.sex=1 then 'Male' 
	   else 'Female' 
	   end "Gender",case 
	   when h.sex=1 then 'Male' 
	   else 'Female' 
	   end "Gender",
	   count(1)
from heartdisease h
where h.target = 1
group by h.age,h.sex
order by h.age asc

------------- Gender column anaysis ----------------------
-- geneder ratios
select case 
	   when h.sex=1 then 'Male' 
	   else 'Female' 
	   end "Gender",
	   count(1) total,
	   cast(count(1) as float)/(select count(1) from heartdisease h1)*100 "ratio"
	from heartdisease h 
	group by h.sex
-- observations - Mens have high rate of heart diesease, approx. 47%



-- geneder ratios with heart disease
select case 
	   when h.sex=1 then 'Male' 
	   else 'Female' 
	   end "Gender",
	   count(1) total,
	   cast(count(1) as float)/(select count(1) from heartdisease h1)*100 "ratio"
	from heartdisease h 
	where h.target =1
	group by h.sex;
-- observations - Mens have high rate of heart diesease, approx. 47%

------------- chest pain type column anaysis ----------------------	

select case when h."chest pain type"='1' then 'typical angina pain' 
when h."chest pain type"='2' then 'atypical angina pain'
when h."chest pain type"='3' then 'non-anginal pain' else 'asymptomatic' end , cast( count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h.target =1
group by h."chest pain type" 
order by h."chest pain type"
-- observations :- 40.5 % patients have heart disease with complete absence of symptoms

select case when h."chest pain type"='1' then 'typical angina pain' 
when h."chest pain type"='2' then 'atypical angina pain'
when h."chest pain type"='3' then 'non-anginal pain' else 'asymptomatic' end , cast( count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h.target =1 and h."exercise angina"=1 
group by h."chest pain type" 
order by h."chest pain type"
-- observations :- 28 % patients have heart disease with complete absence of symptoms but feels chest discomfort while doing exercise.

select case when h."chest pain type"='1' then 'typical angina pain' 
when h."chest pain type"='2' then 'atypical angina pain'
when h."chest pain type"='3' then 'non-anginal pain' else 'asymptomatic' end , cast( count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h.target =1 and h."resting ecg"=2 and h."resting bp s">=140
group by h."chest pain type" 
order by h."chest pain type"
-- observations :- 11 % patients have heart disease with complete absence of symptoms, but suffers with of left ventricular hypertrophy. [ventricular hypertrophy is a thickening of the wall of the heart's main pumping chamber].Since high blood presure is the main causes of ventricular hypertrophy


------------- resting blood pressure column anaysis ----------------------	

-- 34% populations have high bp
select cast(count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h."resting bp s" >=140;

-- 9.7% populations have high bp with ventricular hypertrophy
select cast(count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h."resting bp s" >=140 and h."resting ecg"=2

-- 6.1% populations have heart disease with high bp and ventricular hypertrophy
select cast(count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h."resting bp s" >=140 and h."resting ecg"=2 and h.target =1

-- approx 8.5% of patients have life style disorders [both high in bp & diabetic]
select cast(count(1) as float)/(select count(1) from heartdisease h1)*100 from heartdisease h 
where h."resting bp s" >=140 and h."fasting blood sugar" =1 

-- 220-age gives maximum allowed heart rate of a person while doing excersie, 
select 220-h.age "max ideal heart rate",h."max heart rate" as "max heart rate recorded" from heartdisease h where h."max heart rate" > 220-h.age;

-- approx 4% of patients noticed irregular heart beats have high bp
select cast (count(1) as float) / (select count(1) from heartdisease h1)*100 from heartdisease h where h."max heart rate" > 220-h.age
and h."resting bp s" >=140


------------- ST segment column anaysis ---------------------------
-- values in range 1-3 -> 1: upsloping, 2: flat and 3: downsloping
-- ST segment is usually flat on the baseline ECG, But it may be slightly elevated or depressed > 1mm conditions called myocardial infarction 
-- upsloping & downsloping > 1mm treat as abnormal deviations.

-- patients with myocardial infarction upsloping & downsloping > 1mm
select *  from heartdisease h where h."ST slope">1

-- patients with myocardial infarction in ideal relaxing state
select *  from heartdisease h where h."ST slope">1 and h."exercise angina"=0 

-- 28% patients with myocardial infarction when exercise
select cast (count(1) as float)/(select count(1) from heartdisease h1)*100  from heartdisease h where h."ST slope">1 and h."exercise angina"=1 and target =1

