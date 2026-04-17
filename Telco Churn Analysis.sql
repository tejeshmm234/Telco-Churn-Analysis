use telco_churn;
select * from telco;
select count(*) from telco;
select count(case when churn='Yes' then 1 end) as Churned,count(case when churn='No' then 1 end) as Retained from telco;
select Customer_ID from telco where total_charges=0;


-- CUSTOMERS CHURN VS RETAIN --

select count(*) as Total_Customers,
count(case when churn='No' then 1 end) as Retained_Customers,
round(avg(case when churn='No' then 1 else 0 end)*100,2) as Retentionrate_pct ,
count(case when churn='Yes' then 1 end) as Churned_Customers,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct
from telco;
-- The dataset contains total 7043 customers, out of which 73.46% are retained customers which is 5174 customers remain with the company service. --
-- While ~26% customers churned, which is 1869 customers left the service --
-- This is not normal,it is high when compared to average churn rate of telco industries which is 15%-20%.--
-- This can affect the company's recurring revenue and may increase if not addressed--


-- AVERAGE TENURE OF CUSTOMERS --

select round(avg(tenure),2) as OverallAvg_Tenure,round(avg(case when churn='Yes' then tenure end),2) as Churned_AvgTenure,
round(avg(case when churn='No' then Tenure end),2) as Retained_AvgTenure from Telco; 
-- Average Tenure of customers in the company is ~32 months --
-- Retained customers stay for ~37 months on average,which is above the normal average tenure of Telco industries(32-34 months).  
-- But churned customers stay only ~18 months which is nearly half of the average tenure of telco industry --
-- It means customers are leaving early before even spending minimum 2 years. 

-- AVERAGE MONTHLY CHARGES OF CUSTOMERS --

select round(avg(monthly_charges),2) as Avg_MonthlyCharges,round(avg(case when churn='Yes' then monthly_charges end),2) as Churned,
round(avg(case when churn='No' then monthly_charges end),2) as Retained from Telco;
 -- Overall average monthly charges of total customers is ~$65 -- 
 -- But for churned customers it is ~$74.This is above the average monthly charges of the company --
 -- Where as Retained customers it is ~$61, which is lower than overall average --
 -- Customers with high monthly charges are likely to churn  --
 

-- CHURN RATE BY TENURE BAND --

select case when tenure between 0 and 12 then '0-12'
     when tenure between 13 and 24 then '13-24'
     when tenure between 25 and 36 then '25-36'
     when tenure between 37 and 48 then '37-48'
     when tenure between 49 and 60 then '49-60'
     when tenure between 61 and 72 then '61-72' end as Tenure_Band,count(*) as Total_Customers,
     count(case when churn='Yes' then 1 end) as Total_Churned,
     round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Tenure_Band order by Tenure_Band asc;
-- Approx 47% of customers are churned in 0-12 time period , which means total 1037 out of 2186 customers left the service in this period --
-- 13-24 months shows approx 29% churn rate,which is still high --
-- 25-48 months,churn rate has fallen to ~20% --
-- 49-60 months have low churn rate ~14% --
-- 60-72 months shows very lowest churn rate of ~6% ,customers are very loyal in this period --
-- 	So,New Customers are at higher risk of churning --

   -- CHURN RATE BY CONTRACT -- 

select Contract,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 
else 0 end)*100,2) as Churnrate_pct from telco group by Contract order by Churnrate_pct desc;
-- Month-to-Month contract shows very high churn rate(~43%),which means 1655 out of 3875 customers left the service --
-- One year contract show low churn rate (~11%) ,only 166 out of 1473 left.
-- Two year contract customers are most loyal,only 48 out of 1695 customers left(~3%).  --
-- Long time contracts show low churn rate,customers are tend to stay with long time contracts--
-- Company should focus on moving customers from month-to-month to long time contracts -- 

   -- CHURN RATE BY INTERNET SERVICE --
   
select Internet_Service,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Internet_Service order by Churnrate_pct desc;  
-- Customers using Fiber Optic internet service have highest churn rate at 41.89%,which is nearly half of the customers are leaving the service --
-- DSL internet service has churn rate of 18.96%, which is nearly the industry average and relatively moderate --
-- Customers who don't have Internet Service are more stable,with very low chun rate at 7.4%--
-- Fiber Optic customers may be leaving the company because of issues with the service quality or may have a problem with pricing --
-- Company should look into this to find whether it is service problem , pricing or customers are switching to other company-- 

-- CHURN RATE BY TECH SUPPORT --

select Tech_Support,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Tech_Support order by Churnrate_pct desc;  
-- Customers with No Tech Support are leaving the company with very high churn rate at 41.64% which is nearly half of the total customers --
-- Customers who have Tech Support are churning at low rate 15.17% , making them more likely to stay--
-- Customers who don't have Internet Service are tend to stay more and are most stable with very low churn rate (7.4%) --
-- Customers who receive Tech Support when they face issue are more willing to stay,which suggests that tech support plays important role in retaining customers --
-- So, Company should focus on providing tech support to more customers,as it is most retaining factor that reduces churning --

-- CHURN RATE BY PAYMENT METHOD --

select Payment_Method,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Payment_Method order by Churnrate_pct desc;
-- Customers who use Electronic Check payment method show very high churn rate (45.29%),which means nearly half of the customners leaving the company --
-- Remaining payment methods such as Mailed Check,Bank transfer and Credit Card show low churn rate ranging between 15% to 19%,which is close to normal industry average--
-- Customers using Electronic check are leaving at higher rate,may be because they are already leaving due to other factros or may be facing issues with this payment method  --
-- Company should look into who these Electronic check users are and find out why they are leaving at such a hight churn rate--

-- CHURN RATE BY PAPERLESS BILLING --

select Paperless_Billing,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Paperless_Billing order by Churnrate_pct desc;
-- Customers who use paperless billing leaving the company at high churn rate of around 34% --
-- Customers who do not use Paperless billing are more stable,and are leaving at low churn rate around 16.33% --
-- Customers who use Paperless Billing may also be the ones who are leaving due to other factors,or may be they are more comfortable with technology or easily switching to better options if they find one --
-- Company should look into this and fing out what could be the factors that are making customers to leave --

-- CHURN RATE BY SENIOR CITIZEN --

select Senior_Citizen,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco group by Senior_Citizen order by Churnrate_pct desc;    
-- Senior citizens are churning at very high rate,around 42%,nearly half of the total leaving the company --
-- Where as Non Senior Citizens have moderate churn rate of around 24% which is not low churn rate, but this could be because of any other factors --
-- But Senior Citizens show significantly high churn rate, may be because they face difficukties with the service,having trouble with payments and not not comfortable with tehcnology--
-- Customer should look into this and find out why they are leaving and try to make service easier and more accessible for them--

-- CHRUN RATE BY CONTRACT AND INTERNET SERVICE --

select Contract,Internet_Service,count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
group by Contract,internet_service
order by Churnrate_pct desc;
-- Month to Month contract customers who use Fiber Optic Internet service have the highest churn rate at around 55%, which is a risky customer segment where more than half of the customers are leaving --
-- Customers who use DSL in month to month contract have high churn rate at around 32% , which is still Higher than the normal average --
-- One year contract customers using Fiber Optic and Month to Month customers with no internet service, show  moderate churn rate of around 19% ,which is medium risk segment--
-- Customers on One year and Two year contracts show much lower churn rates across all internet service types,which means long term contracts help to improve customer reteention --
-- Fiber Optic leading to high churn rate across all the contract types,which suggests that customers are not fully satisfied with service --
-- Customers with short term contracts who also use Fiber Optic are churning at high rate which needs immediate attention --
-- Company should fix any issues with Fiber Optic service and also encoruage the customers to move to long term contracts,.This can help reducing the churn rate --

-- CHURN RATE BY INTERNET SERVICE AND TECH_SUPPORT --

select Internet_Service,Tech_Support ,count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where tech_support in ('Yes','No')
group by tech_support,internet_service
order by Churnrate_pct desc;
-- Fiber Optic customers without Tech Support have the highest churn rate(50%) among all the segments,which is high risk segment where half of the customers leaving --
-- DSL customers without Tech Support also have a High Churn Rate around 28%,but it is lower whe compared to Fiber Optic customers wihtout Tech Support --
-- Customers who have Tech Support have low churn rate for both Fiber Optic aand DSL services,which suggests that customers having support available help them stay --
-- Customers who do not have Tech Support are leaving the company at very high churn rate compared to who have Tech Support across all Internet service types --
-- Tech Support is an important factor which can influence the cutomers to stay or leave the company --
-- Even with Tech Support ,Fiber Optic customers are leaving at high churn rate of around 20% , but without Tech Support churn rate goes much higher.This means Fiber Optic may have some issues that Tech Support alone cannot fix --
-- Company should focus on providing tech support to more customers,especially Fiber Optic customers and fixes the issues with Fiber Optic as this is clearly highest risk segment--

-- CHRUN RATE BY CONTRACT AND MONTHLY CHARGES --

select Contract,case when Monthly_Charges>=80 then 'High' else 'Low' end as Charges ,count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
group by Contract,Charges
order by Churnrate_pct desc;
-- Month to Month contract customers with high charges have the highest churn rate at around 52%, which means more than half of these customers are leaving the company --
-- Month to Month with low charges also show high rate but it is lower when compared to High charges customers which means short term contract customers tend to leave more regardless of the charges --
-- One year contract customers with high charges show moderate churn rate at around 20%,but those with low charges show very low churn rate of around 6% --
-- Two year contract customers are very loyal ,they show very low churn rate below 5% regardless of the price. But with high charges churn rate is more than lower charges --
-- Short term customers are already a high risk factor and high charges are making it even worse by pushing more customers to leave --
-- Company should encourage customers to move to long term contracts and also look into the pricing as both these steps can help in bringing the churn rate down --

-- CHURN RATE BY CONTRACT,INTERNET SERVICE AND TECH SUPPORT --

select Contract, Internet_Service,Tech_Support ,count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where tech_support in ('Yes','No')
group by contract,tech_support,internet_service
order by Churnrate_pct desc;
-- Month-to-Month customers using Fiber Optic with no Tech Support have the highest churn rate at around 57%, which means a very high number of customers in this group are leaving the company --
-- Month-to-Month customers, regardless of the internet service or Tech Support, show a high churn rate above 30%. However, DSL customers with Tech Support are showing a moderate churn rate of around 22% --
-- One-Year contract customers using Fiber Optic show a moderate churn rate of around 20% with or without Tech Support. This means even long-term contracts are not stopping churn when customers are using Fiber Optic, indicating that Fiber Optic has deeper issues--
-- All remaining segments show a very low churn rate below 10%. This confirms that long-term contracts significantly help in keeping customers, and the churn rate decreases further based on internet service type and Tech Support availability --
-- The company should first encourage customers to move to long-term contracts, then fix the issues with Fiber Optic service, and also provide Tech Support to more customers — as all three steps together can help in reducing the churn rate  --

-- CHURN RATE BY CONTRACT AND PAYMENT METHOD --

select Contract,Payment_Method,count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
group by Contract,Payment_method
order by Churnrate_pct desc;
-- Month-to-Month contract customers paying through Electronic Check have the highest churn rate at around 54%, which means more than half of these customers are leaving the company --
-- Month-to-Month contract customers still show a high churn rate above 30% regardless of the payment method, which means that short-term contracts are already a high risk factor on their own --
-- One-Year contract customers show a low churn rate of around 10%, but those paying through Electronic Check are leaving more with a moderate churn rate of around 20% --
-- Two-Year contract customers are very loyal and show very low churn rates regardless of the payment method, but Electronic Check users still have a slightly higher churn rate among this group --
-- Short-term contracts are already driving churn at a very high rate, and Electronic Check is making it even worse. This suggests that Electronic Check users may already be at risk due to other factors as well--
-- The company should focus on encouraging customers to move to long-term contracts and also look into the issues with Electronic Check payment method or find out if any other factors are influencing customers to leave, as fixing these can help in bringing the churn rate down --

-- CHURN RATE BY CONTRACT AND TENURE BAND --

select Contract,
case when tenure between 0 and 12 then '0-12'
     when tenure between 13 and 24 then '12-24'
     when tenure between 25 and 36 then '25-36'
     when tenure between 37 and 48 then '37-48'
     when tenure between 49 and 60 then '49-60'
     when tenure between 61 and 72 then '61-72' end as Tenure_Band,
     count(*) as Total_Customers,
Count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
group by Contract,Tenure_Band
order by Churnrate_pct desc;
-- Month-to-Month contract customers in their first year show a very high churn rate of around 51%, which means nearly half of the new customers are leaving the company early --
-- Month-to-Month contract customers show a high churn rate overall, but it gradually decreases as the customer stays longer with the company --
-- One-Year contract customers show a low churn rate of around 10% on average, but the churn rate varies across different tenure periods, which may be due to other influencing factors --
-- Two-Year contract customers are the most loyal, showing a very low churn rate of around 3%, which confirms that long-term customers tend to stay with the company --
-- The company should encourage customers to move to long-term contracts and also find out the factors that are influencing customers to leave early --

-- HIGH RISK CUTSOMER SEGMENT --

create view High_Risk_Customer as
select Contract,Payment_Method,Internet_Service,Tech_Support,
case when Monthly_Charges >=80 then 'High' else 'Low' end as Charges,
case when Tenure >12 then 'High' else 'Low' end as Tenure_period,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct,
     case when Monthly_Charges >=80 and Tenure<=12 then 'Critical'
     when Monthly_Charges<80 or Tenure<=12 then 'High'
     else 'Moderate' end as Risk from telco
where Contract = 'Month-to-Month' and
	Payment_Method='Electronic Check' and
    Tech_Support='No' and
    Internet_Service='Fiber optic'
group by Charges,Tenure_period,Risk
order by churnrate_pct desc;
-- This analysis focuses on the most high-risk customer group which includes Month-to-Month contract, Electronic Check payment, Fiber Optic internet and no Tech Support customers --
-- Customers with high monthly charges and low tenure show the highest churn rate at around 76%, which means nearly 3 out of 4 customers in this group are leaving the company. This is the most critical segment --
-- Even customers with low charges and low tenure show a very high churn rate of around 71%, which means new customers in this high-risk group are leaving at a very high rate regardless of the charges --
-- Customers with low tenure are clearly at-high risk, as both high and low charge customers show churn rates above 70% when tenure is low --
-- Customers with higher tenure show lower churn rates around 55-56%, which suggests that customers who have stayed longer are likely to continue staying, but the churn rate is still very high --
-- High monthly charges combined with low tenure is the most dangerous combination with a churn rate of 76%, making it the top priority segment for the company --
-- The company should immediately focus on this critical segment and offer better pricing, provide Tech Support, and try to move them to long term contracts before they decide to leave --

          ---  CHURN RATE IMPACT BY_ADD-ONS  ---
          
-- CHURN RATE BY PHONE SERVICE --

select Phone_Service,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
group by Phone_Service;
-- Customers with phone service churn at around 27% and without phone service churn at around 25% --
-- Both customers are leaving at almost the same rate --
-- So,Phone service is not an important factor in churn,there may be other factors that influence churn rate --

-- CHURN RATE BY MULTIPLE LINES --

select Multiple_Lines,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where Multiple_Lines in ('Yes','No')
group by Multiple_Lines
order by Churnrate_pct desc;
-- Customers with multiple lines churn at around 28% and customers without multiple lines churn at around 25% --
-- The difference is small,but customers with multiple lines are leaving slightly more --
-- So,multiple lines are not really driving the churn rate,other factors may be the reason for churning --

-- CHURN RATE BY ONLINE SECURITY --

select Online_Security,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco
where Online_Security in ('Yes','No')
group by Online_Security order by Churnrate_pct desc;
-- Customers without online security churn at around 42%, which is very high --
-- Customers with online security churn at only around 15%, almost 3 times lower --
-- This shows that online security is a strong factor in churn, customers who feel less protected are more likely to leave --

-- CHURN RATE BY ONLINE BACKUP --

select Online_Backup,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where Online_Backup in ('Yes','No')
group by Online_Backup
order by Churnrate_pct desc;
-- Customers without online backup churn at around 40%, while customers with online backup churn at around 22% --
-- Customers without online backup are leaving at almost twice the rate of customers with online backup --
-- So online backup is an important factor, customers who don't have it are much more likely to churn --

-- CHURN RATE BY DEVICE PROTECTION --

select Device_Protection,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where Device_Protection in ('Yes','No')
group by Device_Protection
order by Churnrate_pct desc;
-- Customers without device protection churn at around 39%, while customers with device protection churn at around 23% --
-- Customers without device protection are leaving at almost twice the rate of customers with device protection--
-- So device protection is an important factor, customers who don't have it are much more likely to churn --

-- CHURN RATE BY STREAMING MOVIES --

select Streaming_Movies,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where Streaming_Movies in ('Yes','No')
group by Streaming_Movies
order by Churnrate_pct desc;
-- Customers without streaming movies churn at around 34% and customers with streaming movies churn at around 30% --
-- The difference is small, both groups are leaving at a similar rate --
-- So streaming movies is not really an important factor in churn --

-- CHURN RATE BY STREAMING TV --

select Streaming_TV,count(*) as Total_Customers,count(case when churn='Yes' then 1 end) as Total_Churned,
round(avg(case when Churn='Yes' then 1 else 0 end)*100,2) as Churnrate_pct from telco 
where Streaming_TV in ('Yes','No')
group by Streaming_TV
order by Churnrate_pct desc;
-- Customers without streaming TV churn at around 34% and customers with streaming TV churn at around 30% --
-- The difference is small, both groups are leaving at a similar rate --
-- So streaming TV is also not really an important factor in churn --

-- RANK WISE ADD ONS --

select Add_ONs,Yes_Churnrate_pct,No_Churnrate_pct,Impact,dense_rank() over 
(order by Impact desc) as Rank_ from
(select 'Phone_Service' as Add_ONs,
round(sum(case when Churn='Yes' and Phone_Service='Yes'then 1 else 0 end)*100/sum(case when Phone_Service='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Phone_Service='No'then 1 else 0 end)*100/sum(case when Phone_Service='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Phone_Service='No'then 1 else 0 end)*100/sum(case when Phone_Service='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Phone_Service='Yes'then 1 else 0 end)*100/sum(case when Phone_Service='Yes' then 1 else 0 end),2)as Impact from telco
union all
select 'Multiple_Lines' as Add_ONs,
round(sum(case when Churn='Yes' and Multiple_Lines='Yes'then 1 else 0 end)*100/sum(case when Multiple_Lines='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Multiple_Lines='No'then 1 else 0 end)/sum(case when Multiple_Lines='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Multiple_Lines='No'then 1 else 0 end)*100/sum(case when Multiple_Lines='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Multiple_Lines='Yes'then 1 else 0 end)*100/sum(case when Multiple_Lines='Yes' then 1 else 0 end),2)as Impact  from telco
union all
select 'Online_Security' as Add_ONs,
round(sum(case when Churn='Yes' and Online_Security='Yes'then 1 else 0 end)*100/sum(case when Online_Security='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Security='No'then 1 else 0 end)*100/sum(case when Online_Security='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Security='No'then 1 else 0 end)*100/sum(case when Online_Security='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Online_Security='Yes'then 1 else 0 end)*100/sum(case when Online_Security='Yes' then 1 else 0 end),2)as Impact  from telco
union all
select 'Online_Backup' as Add_ONs,
round(sum(case when Churn='Yes' and Online_Backup='Yes'then 1 else 0 end)*100/sum(case when Online_Backup='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Backup='No'then 1 else 0 end)*100/sum(case when Online_Backup='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Backup='No'then 1 else 0 end)*100/sum(case when Online_Backup='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Online_Backup='Yes'then 1 else 0 end)*100/sum(case when Online_Backup='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Device_Protection' as Add_ONs,
round(sum(case when Churn='Yes' and Device_Protection='Yes'then 1 else 0 end)*100/sum(case when Device_Protection='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Device_Protection='No'then 1 else 0 end)*100/sum(case when Device_Protection='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Device_Protection='No'then 1 else 0 end)*100/sum(case when Device_Protection='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Device_Protection='Yes'then 1 else 0 end)*100/sum(case when Device_Protection='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Streaming_Movies' as Add_ONs,
round(sum(case when Churn='Yes' and Streaming_Movies='Yes'then 1 else 0 end)*100/sum(case when Streaming_Movies='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_Movies='No'then 1 else 0 end)*100/sum(case when Streaming_Movies='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_Movies='No'then 1 else 0 end)*100/sum(case when Streaming_Movies='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Streaming_Movies='Yes'then 1 else 0 end)*100/sum(case when Streaming_Movies='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Streaming_TV' as Add_ONs,
round(sum(case when Churn='Yes' and Streaming_TV='Yes'then 1 else 0 end)*100/sum(case when Streaming_TV='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_TV='No'then 1 else 0 end)*100/sum(case when Streaming_TV='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_TV='No'then 1 else 0 end)*100/sum(case when Streaming_TV='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Streaming_TV='Yes'then 1 else 0 end)*100/sum(case when Streaming_TV='Yes' then 1 else 0 end),2) as Impact  from telco) as Add_On_Impact;
-- Online Security has the highest impact on churn (~27%). Customers without this add-on are more likely to leave --
-- Online Backup and Device Protection show moderate impact (~18% and ~17%), indicating they also help in improving customer retention --
-- Customers who do not subscribe to security-related add-ons (Online Security, Backup, Protection) have higher churn compared to others --
-- Streaming add-ons have very low impact on churn, suggesting they are not strong retention drivers. Other factors may be influencing customers to leave --
-- Phone Service and Multiple Lines show negative impact, meaning customers with these services churn slightly more. These features may not contribute to retention and could be associated with high-risk customer segments --
-- Overall, the company should focus on promoting Online Security, Online Backup, and Device Protection, as they have the strongest impact on churn--
-- Company should also analyze other Add-ONs to undertsand their low or negative impacts and indentify any issues related to pricing or service quality --

-- OVERALL MONTHLY REVENUE LOSS --

select count(*) as Total_Churned,sum(monthly_charges) as Monthly_RevenueLoss from telco where Churn='Yes';
-- Out of 7043 customers, 1869 have churned, that is around 26% of total customers --
-- These customers were contributing $1,39,130.85 every month to the company --
-- This is the recurring monthly revenue the company is losing due to churn --

-- MONTHLY REVENUE LOSS BY CHURN FOR CONTRACT --

select Contract,count(*) as Total_Churned,sum(monthly_charges) as Monthly_RevenueLoss from telco where Churn='Yes' group by contract;
-- Month-to-month customers account for the biggest revenue loss at $1,20,847 per month --
-- One year contract customers contribute $14,118 in monthly revenue loss --
-- Two year contract customers contribute only $4,165 in monthly revenue loss --
-- Month-to-month customers are biggest source of revenue loss among the group  -- 
-- Company should focus on retaining them as top priority  --

-- MONTHLY REVENUE LOSS BY CHURN FOR PAYMENT METHOD --

select Payment_Method,count(*) as Total_Churned,sum(monthly_charges) as Monthly_RevenueLoss from telco where Churn='Yes' group by Payment_Method;
-- Electronic check customers contribute the highest monthly revenue loss at around $84,289 -- which is more than the other three methods combined --
-- Mailed check, bank transfer, and credit card customers contribute much less, ranging from around $16,000 to $20,000 each --
-- This shows that electronic check is the most critical payment method to focus on when trying to reduce revenue loss --

-- MONTHLY REVENUE LOSS BY CHURN FOR INTERNET SERVICE --

select Internet_Service,count(*) as Total_Churned,sum(monthly_charges) as Monthly_RevenueLoss from telco where Churn='Yes' group by Internet_Service;
-- Fiber optic customers contribute the highest monthly revenue loss at around $1,14,300, which is significantly more than DSL and no internet customers combined --
-- DSL customers contribute around $22,529 and customers with no internet service contribute only around $2,302 per month --
-- This shows that fiber optic is the most critical internet service segment to focus on when trying to reduce revenue loss --

-- MONTHLY REVENUE LOSS BY CHURN FOR TENURE BAND--

select 
case when tenure between 0 and 12 then '0-12'
     when tenure between 13 and 24 then '12-24'
     when tenure between 25 and 36 then '25-36'
     when tenure between 37 and 48 then '37-48'
     when tenure between 49 and 60 then '49-60'
     when tenure between 61 and 72 then '61-72' end  as Tenure_Band,
     count(*) as Total_Churned,sum(monthly_charges) as Monthly_RevenueLoss from telco where Churn='Yes' group by tenure_band;
-- Customers in the 0-12 months tenure band contribute the highest monthly revenue loss at around $68,954, which is more than all other tenure bands combined --
-- As tenure increases, the revenue loss keeps decreasing , but it slightly changed in the 25-36 tenure band,which may be due to other factors --
-- This shows that early-stage customers are the biggest revenue risk, if the company can retain customers in the first 12 months, it can significantly reduce revenue loss --

-- LOYAL CUSTOMER PROFILE --
use telco_churn;
select Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco;
-- Around 19% of customers stayed with company for more than 60 months.This is nearly double the overall average tenure of 32 months,making them the most loyal customers in the dataset --

-- LOYAL CUSTOMER  PROFILE BY CONTRACT --

select Contract,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct
from telco group by Contract order by LoyalCustomers_pct DESC;
-- Around 56% of all Two-Year contract customers stayed with the company for more than 60 months.This contract has high percentage of loyal customers --
-- One-Year contract customers show moderate loyalty, with around 19% of them staying more than 60 months --
-- Month-to-Month contract customers have the lowest loyalty. Only around 2% of them stayed for more than 60 months --
-- Overall, customers on longer contracts tend to stay with the company much longer --

-- LOYAL CUSTOMER  PROFILE BY INTERNET SERVICE --

select Internet_Service,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Internet_Service order by LoyalCustomers_pct desc;
-- DSL internet service type has  more loyal customers among all, around 20%.Fiber Optic service and No internet service have nearly the same share of Loyal customers ,around 18% --
-- There is no big difference across all internet service types ,so it is not strong factor for customer loyalty --

-- LOYAL CUSTOMER  PROFILE BY TECH SUPPORT --

select Tech_Support,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Tech_Support order by LoyalCustomers_pct desc;
-- Customers who have Tech Support have the highest share of loyal customers at around 34% --
-- Customers with no internet service come next at around 18% --
-- Customers without Tech Support have the lowest share of loyal customers at around 9% --
-- Customers who have Tech Support are much more likely to stay long term compared to those who don't. It is one of the stronger factors in customer loyalty --

-- LOYAL CUSTOMER  PROFILE BY ONLINE SECURITY --

select Online_Security,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Online_Security order by LoyalCustomers_pct desc;
-- Customers who have Online Security enabled have the highest share of loyal customers at around 35% --
-- Customers with no internet service come next, with around 18% of them being loyal customers --
-- Customers who do not have Online Security have the lowest share, with only around 10% of them staying more than 60 months --
-- Overall, customers with Online Security are more likely to stay long compared to those without it --

-- LOYAL CUSTOMER  PROFILE BY PAYMENT METHOD  --

select Payment_Method,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers ,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Payment_Method order by LoyalCustomers_pct desc;
-- Customers who pay via Bank Transfer (automatic) and Credit Card (automatic) have the highest share of loyal customers, at around 32% and 31% . Both are very close to each other --
-- Customers who pay via Electronic Check and Mailed Check have a much lower share of loyal customers, both around 8% --
-- Overall, customers who use automatic payment methods tend to stay with the company much longer compared to customers who pay manually --

-- LOYAL CUSTOMER  PROFILE BY PAPERLESS BILLING --

select Paperless_Billing,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Paperless_Billing order by LoyalCustomers_pct desc ;
-- Customers without paperless billing have a slightly higher share of loyal customers at around 19%, compared to customers with paperless billing at around 18% --
-- The difference between the two groups is very small, so paperless billing does not play a big role in customer loyalty --

-- LOYAL CUSTOMER  PROFILE BY ONLINE BACKUP --

select Online_Backup,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Online_Backup order by LoyalCustomers_pct desc ;
-- Customers who have Online Backup enabled have the highest share of loyal customers at around 33% --
-- Customers with no internet service come next, with around 18% of them being loyal customers --
-- Customers without Online Backup have the lowest share, with only around 8% of them staying more than 60 months --
-- Overall, customers with Online Backup are more likely to stay longer compared to those without it --

-- LOYAL CUSTOMER  PROFILE BY DEVICE PROTECTION --

select Device_Protection,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Device_Protection order by LoyalCustomers_pct desc ;
-- Customers who have Device Protection enabled have the highest share of loyal customers at around 32% --
-- Customers with no internet service come next, with around 18% of them being loyal customers --
-- Customers without Device Protection have the lowest share, with only around 8% of them staying more than 60 months --
-- Overall, customers with Device Protection are more likely to stay longer compared to those without it --

-- LOYAL CUSTOMER  PROFILE BY PHONE SERVICE --

select Phone_Service,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Phone_Service order by LoyalCustomers_pct desc ;
-- Customers with Phone Service have a slightly higher share of loyal customers at around 19%, compared to customers without Phone Service at around 17% --
-- The difference between the two groups is very small, so Phone Service does not play a big role in customer loyalty --

-- LOYAL CUSTOMER  PROFILE WITH MULTIPLE LINES --

select Multiple_Lines,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Multiple_Lines order by LoyalCustomers_pct desc ;
-- Customers with Multiple Lines have the highest share of loyal customers at around 29% --
-- Customers with no phone service come next, with around 17% of them being loyal customers --
-- Customers with a single line have the lowest share, with only around 10% of them staying more than 60 months --
-- Overall, customers with Multiple Lines are more likely to stay longer compared to those with a single line --

-- LOYAL CUSTOMER  PROFILE WITH STREAMING TV --

select Streaming_TV,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Streaming_TV order by LoyalCustomers_pct desc ;
-- Customers who have Streaming TV enabled have the highest share of loyal customers at around 27% --
-- Customers with no internet service come next, with around 18% of them being loyal customers --
-- Customers without Streaming TV have the lowest share, with only around 11% of them staying more than 60 months --
-- Overall, customers with Streaming TV are more likely to stay longer compared to those without it --

-- LOYAL CUSTOMER  PROFILE WITH STREAMING MOVIES --

select Streaming_Movies,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Streaming_Movies order by LoyalCustomers_pct desc;
-- Customers who have Streaming Movies enabled have the highest share of loyal customers at around 28% --
-- Customers with no internet service come next, with around 18% of them being loyal customers --
-- Customers without Streaming Movies have the lowest share, with only around 10% of them staying more than 60 months --
-- Overall, customers with Streaming Movies are more likely to be long term customers compared to those without it --

-- LOYAL CUSTOMER  PROFILE AMONG SENIOR CITIZENS --

select Senior_Citizen,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Senior_Citizen order by LoyalCustomers_pct desc;
-- Non-senior customers have a slightly higher share of loyal customers at around 19%, compared to senior citizens at around 18% --
-- The difference between the two groups is very small, so whether a customer is a senior citizen or not does not play a big role in customer loyalty --

-- LOYAL CUSTOMER  PROFILE BY PARTNER --

select Partner,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Partner order by LoyalCustomers_pct desc;
-- Customers who have a partner have a much higher share of loyal customers at around 30%, compared to customers without a partner at around 8% --
-- This is one of the biggest differences seen across all factors, so customers having partners tend to stay longer  --

-- LOYAL CUSTOMER  PROFILE BY DEPENDENTS --

select Dependents,Count(*) as Total_Customers,
count(case when churn='No' and Tenure>=61 then 1 end) as Loyal_Customers,
round(avg(case when churn='No' and Tenure>=61 then 1 else 0 end)*100,2) as LoyalCustomers_pct from telco group by Dependents order by LoyalCustomers_pct desc;
-- Customers who have dependents have a higher share of loyal customers at around 26%, compared to customers without dependents at around 16% --
-- Customers with dependents are more likely to be stay longer compared to those without dependents --

-- AVEARGE MONTHLY CHARGES OF LOYAL CUSTOMERS --

select count(*) as Loyal_Customers,round(AVG(Monthly_charges),2) as Avg_Charges from telco where churn='No' and Tenure>=61;
-- The average monthly charges for loyal customers is around $74. This is a fairly high amount, which suggests that loyal customers are subscribed to multiple services or long term contracts rather than a basic plan. --

                             -- LOYAL CUSTOMERS PROFILE (TENURE >=61 MONTHS) --
-- 1.Loyal customers are mostly non-senior adults. Senior citizens and non-seniors have almost the same loyalty rate, so age does not make a big difference --
-- 2.Customers having partner are much more likely to be loyal. This is one of the strongest factors observed across all dimensions --
-- 3.Customers with dependents also show higher loyalty compared to those without dependents --
-- 4.Almost all loyal customers have phone service. Customers with multiple lines also show higher loyalty than single line customers --
-- 5.Among internet service types, DSL customers have the highest loyalty rate. But the difference across all three types is very small, so internet service is not a strong factor --
-- 6.Customers with add-on services like Online Security, Online Backup, Device Protection, and Tech Support have significantly higher loyalty rates compared to those without these services --
-- 7.Customers who use Streaming TV and Streaming Movies also show higher loyalty, around 27-28% --
-- 8.Two-Year contract customers have largest share of loyal customers. Longer contracts clearly go hand in hand with longer tenure --
-- 9.Customers who use automatic payment methods like Bank Transfer and Credit Card have much higher loyalty rates compared to manual payment methods users --
-- 10.Paperless billing does not make a noticeable difference in loyalty --
-- 11.The average monthly charge for loyal customers is around $74, which shows that loyal customers have subscribed to multiple services and have longer contracts --
-- 12.Overall, A typical loyal customer is a non-senior adult with a partner or dependents, subscribed to a full bundle of services, on a two-year contract, and paying automatically --

select Add_ONs,Yes_Churnrate_pct,No_Churnrate_pct,Impact,dense_rank() over(order by Impact desc) as Rank_ from
(select 'Phone_Service' as Add_ONs,
round(sum(case when Churn='Yes' and Phone_Service='Yes'then 1 else 0 end)*100/sum(case when Phone_Service='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Phone_Service='No'then 1 else 0 end)*100/sum(case when Phone_Service='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Phone_Service='No'then 1 else 0 end)*100/sum(case when Phone_Service='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Phone_Service='Yes'then 1 else 0 end)*100/sum(case when Phone_Service='Yes' then 1 else 0 end),2)as Impact from telco
union all
select 'Multiple_Lines' as Add_ONs,
round(sum(case when Churn='Yes' and Multiple_Lines='Yes'then 1 else 0 end)*100/sum(case when Multiple_Lines='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Multiple_Lines='No'then 1 else 0 end)/sum(case when Multiple_Lines='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Multiple_Lines='No'then 1 else 0 end)*100/sum(case when Multiple_Lines='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Multiple_Lines='Yes'then 1 else 0 end)*100/sum(case when Multiple_Lines='Yes' then 1 else 0 end),2)as Impact  from telco
union all
select 'Online_Security' as Add_ONs,
round(sum(case when Churn='Yes' and Online_Security='Yes'then 1 else 0 end)*100/sum(case when Online_Security='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Security='No'then 1 else 0 end)*100/sum(case when Online_Security='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Security='No'then 1 else 0 end)*100/sum(case when Online_Security='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Online_Security='Yes'then 1 else 0 end)*100/sum(case when Online_Security='Yes' then 1 else 0 end),2)as Impact  from telco
union all
select 'Online_Backup' as Add_ONs,
round(sum(case when Churn='Yes' and Online_Backup='Yes'then 1 else 0 end)*100/sum(case when Online_Backup='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Backup='No'then 1 else 0 end)*100/sum(case when Online_Backup='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Online_Backup='No'then 1 else 0 end)*100/sum(case when Online_Backup='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Online_Backup='Yes'then 1 else 0 end)*100/sum(case when Online_Backup='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Device_Protection' as Add_ONs,
round(sum(case when Churn='Yes' and Device_Protection='Yes'then 1 else 0 end)*100/sum(case when Device_Protection='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Device_Protection='No'then 1 else 0 end)*100/sum(case when Device_Protection='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Device_Protection='No'then 1 else 0 end)*100/sum(case when Device_Protection='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Device_Protection='Yes'then 1 else 0 end)*100/sum(case when Device_Protection='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Streaming_Movies' as Add_ONs,
round(sum(case when Churn='Yes' and Streaming_Movies='Yes'then 1 else 0 end)*100/sum(case when Streaming_Movies='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_Movies='No'then 1 else 0 end)*100/sum(case when Streaming_Movies='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_Movies='No'then 1 else 0 end)*100/sum(case when Streaming_Movies='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Streaming_Movies='Yes'then 1 else 0 end)*100/sum(case when Streaming_Movies='Yes' then 1 else 0 end),2) as Impact  from telco
union all
select 'Streaming_TV' as Add_ONs,
round(sum(case when Churn='Yes' and Streaming_TV='Yes'then 1 else 0 end)*100/sum(case when Streaming_TV='Yes' then 1 else 0 end),2) as Yes_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_TV='No'then 1 else 0 end)*100/sum(case when Streaming_TV='No' then 1 else 0 end),2) as No_Churnrate_pct,
round(sum(case when Churn='Yes' and Streaming_TV='No'then 1 else 0 end)*100/sum(case when Streaming_TV='No' then 1 else 0 end)-
sum(case when Churn='Yes' and Streaming_TV='Yes'then 1 else 0 end)*100/sum(case when Streaming_TV='Yes' then 1 else 0 end),2) as Impact  from telco) as Add_On_Impact;