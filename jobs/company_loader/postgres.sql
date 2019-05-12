select *
from sectors;


select *
from companies
where cheap;

select *
from charts
order by date desc
limit 10;


select count(*)
from charts
where company_id = 1290;

-- update cheap flag on the companies
update companies
set cheap = true
from charts
where companies.id = charts.company_id
  and charts.date = '2019-05-10'
  and round(charts.close) <= 2;

truncate charts;

ALTER SEQUENCE charts_id_seq RESTART WITH 1;  