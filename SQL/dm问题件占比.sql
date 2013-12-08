select sum(mainp) / count(mainp) as 百分比, day as 日期
  from (select case
                 when (t.problem_type_name = '破损' or t.problem_type_name = '少件') then
                  1
                 else
                  0
               end mainp,
               trunc(created_time - 1 / 2) as day
          from usrvf_gg.gt_problem t 
         where t.created_time < ?
               
           and t.created_time -1 >= ?
              )
 group by day          
        
