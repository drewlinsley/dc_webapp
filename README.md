Setting up the webapp

1. Prepare postgresql databse
	a. sudo apt-get install postgresql libpq-dev postgresql-client postgresql-client-common
 #Install posetgresql with online installer
	b. sudo -i -u postgres #goes into postgres default user
	c. psql postgres #enter the postgres interface
	d. create role mircs WITH LOGIN superuser password 'XXX'; #create the admin for this webapp
	e. alter role mircs superuser; #ensure we are sudo
	f. create database mircs with owner mircs; #create the webapp's database
	g. \q #quit
	h. psql mircs -h 127.0.0.1 -d mircs < node_modules/connect-pg-simple/table.sql #prepare the database for connect-pg-simple middlware
	i. psql mircs -h 127.0.0.1 -d mircs #log into the database with the admin credentials
	j. create table images (_id bigserial primary key, image_path varchar, syn_name varchar, click_path varchar, generations bigint); #create a table that will point to all the images in the webapp
	j. create table image_count (_id bigserial primary key,num_images bigint, current_generation bigint); #create a table that holds the number of images we are working with (for random selection later on)
	k. create table cnn (_id bigserial primary key, 16_baseline_accuracy float, 19_baseline_accuracy float, generations bigint, date timestamp with time zone); #create a table that will track some fun stuff for the website, like consecutive clicks

2. Initialize images into the database
	a. python prepare_ims.py 
