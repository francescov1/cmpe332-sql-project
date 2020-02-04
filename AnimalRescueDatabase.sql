create table location
	(
		location_id varchar(5),
		name varchar(100) not null,
		address varchar(120) not null,
		telephone char(11) not null,
		type enum("spca", "rescue_org", "shelter", "adopter") not null,
		primary key (location_id)
	);

create table spca
	(
		ID varchar(5),
		location_id varchar(5) not null,
		foreign key (location_id) references location (location_id),
		primary key (ID)
	);

create table rescue_org
	(
		ID varchar(5),
		location_id varchar(5) not null,
		foreign key (location_id) references location (location_id),
		primary key (ID)
	);

create table shelter
	(
		ID varchar(5),
		location_id varchar(5) not null,
		website_url varchar(2083) not null,
		max_dogs numeric(4, 0) check (max_dogs >= 0) not null default 0,
		max_cats numeric(4, 0) check (max_cats >= 0) not null default 0,
		max_rabbits numeric(4, 0) check (max_rabbits >= 0) not null default 0,
		max_rodents numeric(4, 0) check (max_rodents >= 0) not null default 0,
		foreign key (location_id) references location (location_id),
		primary key (ID)
	);

create table adopter
	(
		ID varchar(5),
 	 	location_id varchar(5) not null,
 	 	foreign key (location_id) references location (location_id),
 	 	primary key (ID)
	)

create table animal
	(
		ID varchar(5),
		type enum('dog', 'cat', 'rabbit', 'rodent') not null
		location_id varchar(5) not null,
		foreign key (location_id) references location (location_id),
		primary key (ID)
	)

create table employee
	(
		ID varchar(5),
		name varchar(100) not null,
		address varchar(120) not null,
		telephone char(11) not null,
		owner boolean not null default false,
		location_id varchar(5) not null,
		foreign key (location_id) references location (location_id),
		primary key (ID)
	)

create table driver
	(
		ID varchar(5),
		name varchar(100) not null,
		telephone char(11) not null,
		license_plate varchar(8) not null,
		driver_license_number numeric(20, 0) not null,
		rescue_org varchar(5) not null,
 	 	foreign key (rescue_org) references rescue_org (ID),
		primary key (ID)
	)

create table vet_visit
	(
		ID varchar(5),
		name varchar(100) not null,
		condition varchar(200) not null,
		weight numeric(4,2) not null,
		date Date not null,
		animal_id varchar(5) not null,
		foreign key (animal_id) references animal (ID),
		primary key (ID)
	)

create table trip
	(
		ID varchar(5),
		arrival_date Date not null,
		origin varchar(5) not null,
		destination varchar(5) not null,
		driver_id varchar(5) not null,
		animal_id varchar(5) not null,
		foreign key (origin) references location (location_id),
		foreign key (destination) references location (location_id),
 	 	foreign key (driver_id) references driver (ID),
 	 	foreign key (animal_id) references animal (ID),
		primary key (ID)
	)

create table transaction
	(
		ID varchar(5),
		amount numeric(5, 2) check (amount >= 0) not null,
		animal_id varchar(5) not null,
		buyer varchar(5) not null,
		seller varchar(5) not null,
		date Date not null,
		foreign key (animal_id) references animal (ID),
		foreign key (buyer) references location (location_id),
		foreign key (seller) references location (location_id),
		primary key (ID)
	)

create table donation
	(
		ID varchar(5),
		amount numeric(5, 2) check (amount >= 0) not null,
		doner_name varchar(100) not null,
		recipient varchar(5) not null,
		date Date not null,
		foreign key (recipient) references location (location_id),
		primary key (ID)
	)
