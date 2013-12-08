 select sum(收入) as 收入,省份 from (select sum(money) as 收入,  case
         when (s.org_name = '北京分公司' or s.org_name = '天津分公司' or
              s.org_name = '河北分公司') then
          '华北'
          when s.org_name = '福建分公司' then '浙江'
         else
          replace(s.org_name, '分公司', '')
       end 省份   ,trunc(register_date) as 日期
  from GT_STOCK_APPLY t,usrvf_gg.gt_site s
 where t.register_date >=
       to_date('2013-10-1 00:00:00', 'yyyy-mm-dd  hh24:mi:ss')
   and t.register_date <=
       to_date('2013-11-19 23:59:59', 'yyyy-mm-dd  hh24:mi:ss')
   and s.id=t.apply_site_id
 group by trunc(register_date),s.org_name)
 group by 省份
 
