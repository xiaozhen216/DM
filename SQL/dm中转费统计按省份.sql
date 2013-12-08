select sum(money) as 金额, 省份,trunc(日期 - 1 / 2) as 日期
  from (select distinct b.code,
                        t.price_type 费用类型,
                        case
                          when t.price_type = '派件费' then
                           -1 * to_number(t.money)
                          else
                           to_number(t.money)
                        end money,
                        case
                          when (s.range_id=60002) then
                           '华北'
                          when s.org_name = '福建分公司' then
                           '浙江'
                          else
                           replace(s.org_name, '分公司', '')
                        end 省份,
                         a.operate_site_name 计费中心,
                        a.site_name 上一站,
                        a.operate_site_name 操作站,
                        a.pay_company 付款方,
                        a.charge_company 收款方,
                        t.created_time as 日期
        
          from usrvf_gg.gt_bill_detail t,
               usrvf_gg.gt_charging    a,
               usrvf_gg.gt_bill        b,
               usrvf_gg.gt_site        s
         where t.charging_id = a.id
           and a.bill_id = b.id
           and b.send_site_id = s.id
           and t.created_time >=
               to_date('2013-11-18 12:00:00', 'yyyy-mm-dd  hh24:mi:ss')
           and t.created_time <=
               to_date('2013-11-19 11:59:59', 'yyyy-mm-dd  hh24:mi:ss'))
 group by trunc(日期 - 1 / 2),省份
/* group by to_char(shouru.日期, 'yyyy-IW')*/

/*select distinct b.code,
               t.price_type 费用类型,
               case
                 when a.charge_company_id = 5555 then
                  t.money
                 else
                  '-' || t.money
               end 金额,
               case
                 when a.charge_company_id = 5555 then
                  a.operate_site_name
                 else
                  a.site_name
               end 计费中心,
               a.site_name 上一站,
               a.operate_site_name 操作站,
               a.pay_company 付款方,
               a.charge_company 收款方,
               trunc(t.created_time) as 日期

 from usrvf_gg.gt_bill_detail t,
      usrvf_gg.gt_charging    a,
      usrvf_gg.gt_bill        b
where t.charging_id = a.id
  and a.bill_id = b.id*/
