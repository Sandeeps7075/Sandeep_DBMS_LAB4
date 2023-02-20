CREATE DEFINER=`root`@`localhost` PROCEDURE `ratingprocedure`()
BEGIN

    select report.SUPP_ID, report.SUPP_NAME, report.Average,
    case
    when report.Average=5 then 'Excellent Service'
    when report.Average>4 then 'good Service'
    when report.Average>2 then 'Average Service'
    else 'Poor Service'
    end as Type_of_Service from
    (select final.SUPP_ID, supplier.SUPP_NAME, final.Average from 
	(select test2.SUPP_ID, avg(test2.RAT_RATSTARS) as Average from
    (select supplier_pricing.SUPP_ID, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing
	inner join (select rating.ORD_ID, rating.RAT_RATSTARS, `order`.PRICING_ID from rating 
	inner join `order` on rating.ORD_ID = `order`.ORD_ID) 
    as test on test.PRICING_ID = supplier_pricing.PRICING_ID)as test2 
    group by supplier_pricing.SUPP_ID)as final 
    inner join supplier where final.SUPP_ID=supplier.SUPP_ID) as report;

END