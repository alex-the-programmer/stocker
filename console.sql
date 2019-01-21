select count(*)
from companies;

select count(*)
from stats;



select *
from companies
where symbol like '%.%';

select *
from companies
where symbol like '%JJG%';


select distinct exchange
from companies;


select *
from companies
where id = 7872;

select s.name, count(*)
from companies
  left join sectors s on companies.sector_id = s.id
group by s.id, s.name
order by count(*) desc;

select t.name, count(*)
from companies
       left join companies_tags ct on companies.id = ct.company_id
        left join tags t on ct.tag_id = t.id
group by t.id, t.name
order by count(*) desc;


select count(*)
from stats
where  return_on_equity = 0;


select min(latest_eps), max(latest_eps)
from stats;

select latest_eps > 0, count(*)
from stats
group by ret > 0;

week_52_high = 0
or week_52_low = 0; #means null; on NYSE they're not null'; a lot of other fields are also missing on these records.looks like it's a data bug; only 15 records
not sure about week52change; 723 records

short_interest 4617 records
dividend_rate 3490 rec also have dividend_yield 0

latest_eps could be negative - it's half and half

looks like float = 0 -stock is not available for purchase (number of shares); though it could be preasures

eps_surprise_prs <0 means company underperformed

ebidta =earnings before ...




truncate charts;

ALTER SEQUENCE charts_id_seq RESTART WITH 1;

-- companies prices with sectors
select companies.symbol, companies.name, s.name sector, c.close
from companies
  join charts c on companies.id = c.company_id
  left join sectors s on companies.sector_id = s.id
where c.date = '2019-01-04';


select *
from charts
where close is null;

-- linear hystogram of number of companies per rounded prices
select round(c.close) bucket, count(*)
from companies
       join charts c on companies.id = c.company_id
where c.date = '2019-01-04'
group by round(c.close)
order by round(c.close);

-- linear histogram of average companies volotility within buckets of rounded prices
select round(c.close) bucket, avg(abs((c.close - c.open)*100/c.open))
from companies
       join charts c on companies.id = c.company_id
where c.date = '2018-12-11'
  and c.open is not null
group by round(c.close)
order by round(c.close);

-- linear histogram of maximum companies volotility within buckets of rounded prices
select round(c.close) bucket, max((c.close - c.open)*100/c.open)
from companies
       join charts c on companies.id = c.company_id
where c.date = '2018-12-11'
  and c.open is not null
group by round(c.close)
order by round(c.close);

-- linear histogram of maximum companies volotility within buckets of rounded low/high prices
select round(c.high) bucket, max((c.high - c.low) * 100 / c.low)
from companies
       join charts c on companies.id = c.company_id
where c.date = '2018-12-11'
  and c.low is not null
  and c.high is not null
group by round(c.high)
order by round(c.high);


-- update cheap flag on the companies
update companies
set cheap = true
from charts
where companies.id = charts.company_id
  and charts.date = '2019-01-04'
  and round(charts.close) <= 2;

-- histogram of cheap companie: mostly healthcare and tech
select distinct s.name, count(*)
from companies
  left join sectors s on companies.sector_id = s.id
where cheap
group by s.name
order by count(*) desc ;


-- linear hystogram of number of cheap companies per rounded prices
select round((c.close)::numeric, 1) bucket, count(*)
from companies
       join charts c on companies.id = c.company_id
where c.date = '2019-01-04'
  and companies.cheap
group by round((c.close)::numeric, 1)
order by round((c.close)::numeric, 1);


SELECT  1 AS one FROM "charts" WHERE (date >= '2019-01-05') LIMIT 1;