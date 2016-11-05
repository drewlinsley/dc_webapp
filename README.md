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
	j. create table image_count (_id bigserial primary key,num_images bigint, current_generation bigint, generations_per_epoch bigint); #create a table that holds the number of images we are working with (for random selection later on)
	k. create table cnn (_id bigserial primary key, sixteen_baseline_accuracy float, nineteen_baseline_accuracy float, sixteen_attention_accuracy float, nineteen_attention_accuracy float, epochs bigint, date timestamp with time zone); #create a table that will track some fun stuff for the website, like consecutive clicks
	k. create table clicks (_id bigserial primary key, high_score bigint, date timestamp with time zone); #create a table that will track some fun stuff for the website, like consecutive clicks

2. Initialize images into the database
	a. python prepare_ims.py 


#TODO
1. create a script that runs baselinevgg16,baselinevgg19,attentionvgg16, and attentionvgg19 and adds their accuracy to the database. The attention versions will generate click maps by extracting click coordinates from the database.
2. Trigger this script with prepare_ims.py
3. Also trigger this script in db.js line 51, when we have surpassed the epoch threshold.
4. Create about.js, which reads from  the cnn database and produces two graphs. 1 showing the progress of the project (how many generations of click images) and 2 showing how it helps cnn accuracy