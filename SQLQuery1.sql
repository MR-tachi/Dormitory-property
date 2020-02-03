use [C:\USERS\ACER\DOCUMENTS\VISUAL STUDIO 2017\PROJECTS\DATABASE1\AMVAL_KHABGAH.MDF]

create table store(
sname varchar(15) not null unique  ,
cond int ,
capacity int 
);

create table dormmanagement
(daddress varchar(100) not null unique);

drop table dormproperty

create table dormproperty
(
pcode int unique not null identity(10000 ,1),
price int not null check (price>0),
pname varchar(20) not null ,
fk_daddress varchar(100) ,
pshop varchar(20) ,
pbuydate timestamp ,
foreign key (fk_daddress) references dormmanagement(daddress)
on delete set null on update cascade
);

alter table dormproperty drop column pbuydate;
alter table dormproperty add pbuydate datetime;
create table people
(
id_number varchar(10) not null unique ,
lname varchar(20) not null,
fname varchar(20) not null
);

drop table responsible
create table responsible 
(
fk_ridnumber varchar(10) not null unique ,
city varchar(10) not null,
region varchar(10) not null,
street varchar(10) not null,
alley varchar(10) not null,
plaque varchar(10) not null,
foreign key (fk_ridnumber) references people(id_number)
);

create table student 
(
fk_sidnumber varchar(10) not null unique ,
branch varchar(10),
snum varchar(10) not null unique,
block_name varchar(10) not null ,
room_num int not null ,
foreign key (fk_sidnumber) references people (id_number)
);

create table worker 
(
fk_widnumber varchar(10) not null unique ,
city varchar(10) not null,
region varchar(10) not null,
street varchar(10) not null,
alley varchar(10) not null,
plaque varchar(10) not null,
foreign key (fk_widnumber) references people(id_number)
);
drop table storing_property
create table storing_property
(
fk_pcode int unique not null,
fk_sname varchar(15)  ,
foreign key (fk_pcode) references dormproperty(pcode) 
on delete cascade on update cascade,

foreign key (fk_sname) references store(sname)
on update cascade on delete set null
);



drop table controling
create table controling
(
fk_pcode int not null,
fk_ridnumber varchar(10) not null,
foreign key (fk_pcode) references dormproperty(pcode)
on update cascade on delete cascade,
foreign key (fk_ridnumber) references responsible(fk_ridnumber)
on delete no action,
primary key(fk_pcode,fk_ridnumber)
);

create table managerphone
(
fk_daddress varchar(100) not null ,
phonenumber varchar(11) not null 
primary key(fk_daddress,phonenumber),
foreign key (fk_daddress) references dormmanagement(daddress)
);


create table peoplephone
(
fk_id_number varchar(10) not null ,
phonenumber varchar(11) not null 
primary key(fk_id_number,phonenumber),
foreign key (fk_id_number) references people(id_number)
);
drop table consume
create table consume
(
fk_pcode int not null,
fk_widnumber varchar(10) not null,
foreign key (fk_pcode) references dormproperty(pcode)
on update cascade on delete no action,
foreign key (fk_widnumber) references worker(fk_widnumber)
on delete no action,
primary key(fk_pcode,fk_widnumber)
);

drop table rhurt
create table rhurt
(
rhurt_id int not null primary key identity(1,2),
fk_pcode int not null,
fk_ridnumber varchar(10) not null,
foreign key (fk_pcode) references dormproperty(pcode)
on update cascade on delete no action,
foreign key (fk_ridnumber) references responsible(fk_ridnumber)
on delete no action

);

drop table shurt
create table shurt
(
shurt_id int not null primary key identity(2,2),
fk_pcode int not null,
fk_sidnumber varchar(10) not null,
foreign key (fk_pcode) references dormproperty(pcode)
on update cascade on delete no action,
foreign key (fk_sidnumber) references student(fk_sidnumber)
on delete no action
);

create table rpay
(
paydate date not null,
fk_rhurtid int not null unique,
fk_daddress varchar(100) not null ,
foreign key (fk_rhurtid) references rhurt(rhurt_id)
on delete no action,
foreign key (fk_daddress) references dormmanagement (daddress)
on update cascade on delete no action
);

create table spay
(
paydate date not null,
fk_shurtid int not null unique,
fk_daddress varchar(100) not null ,
foreign key (fk_shurtid) references shurt(shurt_id)
on delete no action,
foreign key (fk_daddress) references dormmanagement (daddress)
on update cascade on delete no action
);

drop table tempproperty
create table tempproperty
(
fk_pcode int not null unique,
usedate date
foreign key (fk_pcode) references dormproperty(pcode)
on delete cascade on update cascade
);

drop table eternalproperty
create table eternalproperty
(
fk_pcode int not null unique,
cost int not null,
foreign key (fk_pcode) references dormproperty(pcode)
on delete cascade on update cascade
);	

alter table store
add constraint cap_check check(capacity > 0)


alter table dormproperty 
add constraint price_limit check (price <10000000)



create assertion hurt_constraint 
CHECK ( NOT EXISTS ( SELECT * FROM dormproperty join eternalproperty on pcode=fk_pcode)
WHERE (price>cost)); -- deleted from sql :|