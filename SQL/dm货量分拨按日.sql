select sum(w) as 重量, 分拨
  from (select sum(weight) as w,
               case
                 when t.center_in_name = '苏州' then
                  '无锡'
                 when t.center_in_name = '昆山' then
                  '无锡'
                 when t.center_in_name = '仙居' then
                  '台州'
                 when t.center_in_name = '顺德' then
                  '广州'
                 when t.center_in_name = '扬州' then
                  '南京'
                 when t.center_in_name = '上海闵行一部' then
                  '上海'
                 when t.center_in_name = '佛山' then
                  '广州'
                 when t.center_in_name = '莞城' then
                  '新塘'
                 when t.center_in_name = '玉环' then
                  '台州'
                 when t.center_in_name = '乐清一部' then
                  '台州'
                 when t.center_in_name = '河源' then
                  '虎门'
                 when t.center_in_name = '河北廊坊' then
                  '北京'
                 when t.center_in_name = '肇庆' then
                  '广州'
                 when t.center_in_name = '河北张家口' then
                  '北京'
                 else
                  replace(t.center_in_name,'分拨','') 
               end 分拨
          from usrvf_gg.gt_bill t, usrvf_gg.gt_site s
         where t.created_time >=
               to_date('2013-10-27 08:00:00', 'yyyy-mm-dd  hh24:mi:ss')
           and t.created_time <=
               to_date('2013-10-28 07:59:59', 'yyyy-mm-dd  hh24:mi:ss')
           and t.send_site_id = s.id
         group by t.center_in_name)
 group by 分拨
 order by 重量 desc
