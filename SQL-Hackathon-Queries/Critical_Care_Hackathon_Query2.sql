65.Show the average sodium value for each patient.

select  inp_no , avg(cast(labvalue as float)) as avg_sodium from lab
where item in ('Sodium ion (Na +)', 'Sodium (Na)', 'Sodium ion concentration (CNa+)')
and labvalue is not null	
group by inp_no;	



66.For each department show the count of patients whose condition got worse a year after discharge.	

select  distinct count(b.patient_id) as patient_count , discharge_dept from baseline b inner join outcome o
on b.patient_id = o.patient_id
where sf36_oneyearcomparehealthcondition in ('5_Much worse now than one year ago', '④比1年前差一些') and follow_date is not null
and extract(year from age(follow_date, icu_discharge_time)) >= 1	
group by discharge_dept 


67.Identify the patients who have the same systolic blood pressure values recorded for more than two consecutive days.

with sbp_consecutive AS(
	select distinct inp_no, invasive_sbp, Date(charttime) as chartdate,
	row_number() over (partition by inp_no order by charttime)
	- extract(day from charttime ):: integer as grp_sbp
	from nursingchart
	where invasive_sbp is not null 
),
consecutive_days as (
	select 
	  distinct inp_no, invasive_sbp,
	  min(chartdate) as start_date,
	  max(chartdate) as end_date,
	  count(*) as consecutive_days_count
	from sbp_consecutive
	group by inp_no, invasive_sbp , grp_sbp
)
select distinct
	inp_no,
	invasive_sbp,
	start_date,
	end_date,
	consecutive_days_count
from consecutive_days	
where consecutive_days_count > 2;


	


68.Show the 9th youngest patient and if they are alive or not.


with rank_patient as 
	(
	select patient_id ,
	       age,
	       rank() over (  order by age ) rank_number
    from baseline
    )
select distinct r.patient_id, age, rank_number, follow_vital
from rank_patient r inner join outcome o
on 	r.patient_id = o.patient_id
where rank_number = 9


	
	

69.Show the bar distribution of ventilator modes for Pneumonia patients. Hint: Do not consider null values.	


select 	breathing_pattern, count(infectionsite) Pneumonia_patients from nursingchart n inner join baseline b
on n.inp_no = b.inp_no	
where infectionsite = 'Pneumonia'	and breathing_pattern is not null
group by breathing_pattern 
order by Pneumonia_patients desc





	
70.Create a view on baseline table with a check option on admit department .

create view baseline_view as
select * from baseline
where admitdept is not null
with check option

insert into baseline_view values (1111111, 1010101, 10 , 'Male', null , 'Others' , '2019-02-03 12:48:24')



71.How many patients were admitted to Surgery within 30 days of getting discharged?

select distinct count(b.patient_id) patients_admitted_to_surgery_within_30days  from baseline b inner join transfer t
on b.patient_id = t.patient_id
where transferdept = 'Surgery'	
and t.starttime <= b.icu_discharge_time + interval '30 days'
and t.starttime >= b.icu_discharge_time


	
72.What percentage of the patients with blood oxygen saturation < 90 are alive?

select (cast(count(distinct case when ds.status_discharge_temp = 'Alive' then 1 end) as decimal ) /
	     count(distinct n.inp_no) ) * 100 as percentage_alive_patients 
from nursingchart n
inner join ( select distinct inp_no,
	                              case
	                              when status_discharge = 'Dead' then 'Dead'
	                              else 'Alive'
	                              end as status_discharge_temp
	                              from icd ) ds
on n.inp_no = ds.inp_no
where n.blood_oxygen_saturation < 90 




73.List the tables where column Patient_ID is present.(display column position number with respective table also)

select  table_name , column_name , ordinal_position from information_schema.columns
where table_schema = 'public' and column_name = 'patient_id'	
	


74.Find the average heart rate of patients under 40.

select count(distinct n.inp_no) as patients_count , avg(heart_rate) as avg_heart_rate
from nursingchart n inner join baseline b
on 	n.inp_no = b.inp_no
where b.age < 40 and n.heart_rate is not null


75.Use CTE to calculate the percentage of patients with hypoproteinemia who had to be intubated.

with hypoproteinemia_patients as (	
select  distinct i.inp_no , icd_desc , endotracheal_intubation 
from icd i inner join nursingchart n
on 	i.inp_no = n.inp_no
where icd_desc ='hypoproteinemia' 
)	
select(cast(count(case when endotracheal_intubation ~ '^[0-9]+(\.[0-9]+)?$' then 1 end) as decimal )/count(inp_no) )*100 as percentage_intubated
from hypoproteinemia_patients



76.Identify patients whose breathing tube has been removed.

select  distinct inp_no , extubation from nursingchart 
where extubation = true



	
	
77.Compare each diastolic blood pressure value with the previous reading. And show previous and current value.		


select inp_no, invasive_diastolic_blood_pressure as current_dbp,
lag(invasive_diastolic_blood_pressure) over (partition by inp_no order by charttime) as previous_dbp,
charttime as current_charttime,
lag(charttime) over (partition by inp_no order by charttime) as previous_chartdate
from nursingchart 	
where invasive_diastolic_blood_pressure is not null	
order by inp_no, charttime	


	

78.List patients who have more than 500 entries in the nursing chart.

with patient_entries as (	
                         select inp_no, count(inp_no) as entries from nursingchart 
                         group by inp_no 
                         )
select inp_no , entries from patient_entries
where entries > 500





79.Display month name and the number of patients discharged from the ICU in that month.

SELECT  count(distinct b.patient_id) as patients_discharge , TO_CHAR( icu_discharge_time , 'Month YYYY') AS month_name from baseline  b inner join icd i
on b.patient_id = i.patient_id	
where status_discharge IN ('Recovered' , 'Uncovered' , 'Cured' , 'Others')
group by TO_CHAR( icu_discharge_time , 'Month YYYY')
order by min(icu_discharge_time) 



	
80.Write a function that calculates the percentage of people who had moderate body pain after 4 weeks.

create or replace function calculate_morderate_pain_percentage()
returns decimal as $$
declare 
	percentage decimal;
begin
	select (cast(count(case when sf36_pain_bodypainpast4wk = '4_Moderate' then 1 end) as decimal )
	/count(patient_id)) * 100 as percentage_moderate_pain
into percentage	
from outcome	
where sf36_pain_bodypainpast4wk is not null;
return percentage;
end;
$$ language plpgsql;	

select calculate_morderate_pain_percentage();











	