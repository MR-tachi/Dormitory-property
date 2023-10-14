use [C:\USERS\ACER\DOCUMENTS\VISUAL STUDIO 2017\PROJECTS\DATABASE1\AMVAL_KHABGAH.MDF]

create view  hurts  (hurt_id,pcode,national_id)
as select * from rhurt 
union 
select * from shurt ;

drop view hurts;
select * from hurts;
  
create view name_hurt (f_name,l_name,p_name,cost)
as select fname,lname ,id_number,pcode , pname,cost
from (hurts join people on national_id = id_number)
join dormproperty on hurts.pcode = dormproperty.pcode
join eternalproperty on fk_pcode = hurts.pcode 


select fname,lname ,id_number , fk_pcode , pname,cost
from (hurts join people on national_id = id_number)
join dormproperty on hurts.pcode = dormproperty.pcode
join eternalproperty on fk_pcode = hurts.pcode 


select fname,lname,id_number,fk_pcode , pname,cost 
                from(hurts join people on national_id = id_number)
                join dormproperty on hurts.pcode = dormproperty.pcode
                join eternalproperty on fk_pcode = hurts.pcode 


select * from name_hurt


create trigger test
on eternalproperty
after insert 
as
begin 
print 'You Have Added New item';
end


CREATE PROCEDURE bad_branch @br varchar(10)
AS
	SELECT * from student join shurt on student.fk_sidnumber=shurt.fk_sidnumber
		where @br=branch
RETURN 0


exec bad_branch @br = "comp"--test procedure
exec bad_branch @br = "mech"--test procedure


select * from name_hurt

create procedure expensive @cost int 
as
	select pname , price ,pshop 
	from dormproperty 
	where @cost < price 
return 0
 drop procedure expensive


exec expensive @cost=300000--test procedure
exec expensive @cost = 20000--test procedure