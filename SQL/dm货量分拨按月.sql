 select sum(t.WEIGHT) as 重量, trunc(t.SEND_DATE - 1/2,'mm') as 月份
  from usrvf_gg.gt_bill t
 where t.SEND_DATE >= to_date('2013-01-01 12:00:00', 'yyyy-mm-dd  hh24:mi:ss') 
   and t.SEND_DATE <= to_date('2013-5-01 12:00:00', 'yyyy-mm-dd  hh24:mi:ss') 
 group by trunc(SEND_DATE - 1/2,'mm')
