use data_mysql;

select * from cc_wfm limit 5;

# 1️⃣ Total Calls Handled by Each Agent

select agent_id,agent_name,count(call_id) as total_calls
from cc_wfm
group by agent_id,agent_name
order by total_calls desc;

# 2️⃣ Average CSAT Score by Team
select team,round(avg(csat_score),2) as avg_csat_score
from cc_wfm
group by team
order by avg_csat_score desc;

# 3️⃣ SLA Performance by Channel

select channel,
count(call_id) as total_calls,
sum(case when sla_met = 'Y' then 1 else 0 end) as sla_met_calls,
round(sum(case when sla_met = 'Y' then 1 else 0 end)*  100/count(call_id),2) as sla_percentage
from cc_wfm
group by channel;

# 4️⃣ Average Handle Time by Queue

select queue,
round(avg(handle_time_sec),2) as avg_handle_time
from cc_wfm
group by queue;

# 5️⃣ Call Volume by Day of Week

select day_of_week,
count(call_id) as total_calls
from cc_wfm
group by day_of_week
order by total_calls desc;

# 6️⃣ Escalated Calls Percentage

select count(call_id) as total_calls,
sum(case when disposition = 'Escalated' then 1 else 0 end) as disposition_calls,
round(sum(case when disposition = 'Escalated' then 1 else 0 end)*100/count(call_id),2) as escalated_calls_percentage
from cc_wfm;

# 7️⃣ Average Talk Time by Skill Level

select skill_level,
round(avg(talk_time_sec),2) as avg_talk_time
from cc_wfm
group by skill_level;

# 8️⃣ Top 5 Agents with Highest CSAT

select agent_id,
round(avg(csat_score),2)	as highest_score
from cc_wfm
group by agent_id
order by  highest_score desc
limit 5;

# 9️⃣ Transfer Rate by Team

select team,count(*) as total_calls,
sum(case when transfer_flag = 'Y' then 1 else 0 end) as transfer_rate,
round(sum(case when transfer_flag = 'Y' then 1 else 0 end)* 100/ count(*),2) as transter_rate_percentage
from cc_wfm
group by team;

# 🔟 Repeat Call Analysis
select queue,
sum(case when repeat_call_flag = 'Y' then 1 else 0 end) as repeat_call
from cc_wfm
group by queue
order by repeat_call desc; 

# 1️⃣1️⃣ Average Handle Time by Shift

select shift,
round(avg(handle_time_sec),2) as avg_handle_time
from cc_wfm
group by shift;

# 1️⃣2️⃣ Calls Handled by Channel
select channel,
count(call_id) as total_calls
from cc_wfm
group by channel;

# 1️⃣3️⃣ Agents Missing SLA the Most

select agent_name,
sum(case when sla_met = "N" then 1 else 0 end) as sla_missed
from cc_wfm
group by agent_name
order by sla_missed desc;

# 1️⃣4️⃣ Average Handle Time by Tenure
select 
case 
when tenure_years < 2  then 'New'
when tenure_years between 2 and 5 then 'Mid'
else 'Experienced'
end as tenure_group,
round(avg(handle_time_sec),2) as avg_handle_time
from cc_wfm
group by tenure_group;

# 1️⃣5️⃣ Hourly Call Volume

select call_hour,
count(*) as total_calls
from cc_wfm
group by call_hour
order by total_calls desc;
