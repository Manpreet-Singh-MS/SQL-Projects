create database music_store;

use music_store;

#create Artist Table

create table artist(
artist_id int not null primary key,
name varchar(20));

#create Album Table

create table album(
album_id int not null primary key,
title varchar(10),
artist_id int,
foreign key (artist_id) references artist(artist_id)
on delete cascade
);

#create Track Table

create table track(
track_id int not null primary key,
name varchar(20),
album_id int,
mediatype_id int,
genre_id int,
composer varchar(20),
milliseconds int,
bytes int,
unit_price int,
foreign key(genre_id) references genre(genre_id),
foreign key(mediatype_id) references mediatype(mediatype_id));

#create MediaType Table

create table mediatype(
mediatype_id int not null primary key,
name varchar(20));

#create Genre Table

create table genre(
genre_id int not null primary key,
name varchar(20));

#create Playlist_Track Table

create table playlist_track(
playlist_id int,
track_id int,
foreign key (playlist_id) references playlist(playlist_id),
foreign key (track_id) references track(track_id));

#create Playlist Table

create table playlist(
playlist_id int not null primary key,
name varchar(20));

#create table employee

create table employee(
employee_id int not null primary key,
last_name varchar(20),
first_name varchar(20),
title varchar(20),
reports_to varchar(20),
birth_date date,
hire_date date,
address varchar(20),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code int,
phone int unique key,
fax int,
email varchar(30) unique key
);

#create table customer

create table customer(
customer_id int not null primary key,
first_name varchar(20),
last_name varchar(20),
company varchar(20),
address varchar(20),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code int,
phone int unique key,
fax int,
email varchar(30) unique key,
supportRep_id int);

#create table invoice

create table invoice(
invoice_id int not null primary key,
customer_id int,
invoice_date date,
billing_address varchar(20),
billing_city varchar(20),
billing_state varchar(20),
billing_country varchar(20),
billing_postal_code int,
total int,
foreign key(customer_id) references customer(customer_id));

#create table invoice_line

create table invoice_line(
invoice_line_id int not null primary key,
invoice_id int,
track_id int,
unit_price int,
quantity int,
foreign key(invoice_id) references invoice(invoice_id),
foreign key(track_id) references track(track_id));

