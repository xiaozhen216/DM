select inCenter.日期  as 日期,
       inCenter.重量  as 入网重量,
       outCenter.重量 as 出网重量
  from (select round(sum(w)/1000) as 重量, 分拨,日期
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
                          replace(t.center_in_name, '分拨', '')
                       end 分拨,
                       trunc(t.created_time - 1 / 2) as 日期
                  from usrvf_gg.gt_bill t, usrvf_gg.gt_site s
                 where t.created_time >=
                       to_date('2013-10-1 08:00:00', 'yyyy-mm-dd  hh24:mi:ss') +
                       1 / 2
                   and t.created_time <=
                       to_date('2013-10-25 08:00:00',
                               'yyyy-mm-dd  hh24:mi:ss') + 3 / 2
                   and t.send_site_id = s.id
                 group by t.center_in_name, trunc(t.created_time - 1 / 2))
         group by 日期,分拨) inCenter,
       (select round(sum(w)/1000) as 重量, 分拨,日期
          from (select sum(weight) as w,
                       case
                         when t.center_out_name = '苏州' then
                          '无锡'
                         when t.center_out_name = '昆山' then
                          '无锡'
                         when t.center_out_name = '仙居' then
                          '台州'
                         when t.center_out_name = '顺德' then
                          '广州'
                         when t.center_out_name = '扬州' then
                          '南京'
                         when t.center_out_name = '上海闵行一部' then
                          '上海'
                         when t.center_out_name = '佛山' then
                          '广州'
                         when t.center_out_name = '莞城' then
                          '新塘'
                         when t.center_out_name = '玉环' then
                          '台州'
                         when t.center_out_name = '乐清一部' then
                          '台州'
                         when t.center_out_name = '河源' then
                          '虎门'
                         when t.center_out_name = '河北廊坊' then
                          '北京'
                         when t.center_out_name = '肇庆' then
                          '广州'
                         when t.center_out_name = '河北张家口' then
                          '北京'
                         else
                          replace(t.center_out_name, '分拨', '')
                       end 分拨,
                       trunc(t.created_time - 1 / 2) as 日期
                  from usrvf_gg.gt_bill t, usrvf_gg.gt_site s
                 where t.created_time >=
                       to_date('2013-10-1 08:00:00', 'yyyy-mm-dd  hh24:mi:ss') +
                       1 / 2
                   and t.created_time <=
                       to_date('2013-10-25 08:00:00',
                               'yyyy-mm-dd  hh24:mi:ss') + 3 / 2
                   and t.send_site_id = s.id
                 group by t.center_out_name, trunc(t.created_time - 1 / 2))
         group by 日期,分拨) outCenter
 where inCenter.日期 = outCenter.日期
   and inCenter.分拨 = outCenter.分拨
   and inCenter.分拨 = '虎门'
 order by 日期
