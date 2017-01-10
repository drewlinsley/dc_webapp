Setting up the webapp
#0. Install the following libraries:
	https://github.com/drewlinsley/clickmap_prediction
	https://github.com/drewlinsley/tf_experiments
	https://github.com/drewlinsley/dc_webapp
	They are set up under the assumption that (c) lives on a VM, while (a,b) live on a workstation with a GPU that is accessible via SSH.
	sudo apt-get install npm nodejs
	npm install
        (if using anaconda, you may need to use the following commands:
        conda install nomkl numpy scipy scikit-learn numexpr
        conda remove mkl mkl-service
        )


#1. Prepare postgresql databse
	sudo apt-get install postgresql libpq-dev postgresql-client postgresql-client-common #Install posetgresql with online installer
	sudo -i -u postgres #goes into postgres default user
	psql postgres #enter the postgres interface
	create role mircs WITH LOGIN superuser password 'XXX'; #create the admin for this webapp. make sure this password is also reflected in db.js/db_pw
	alter role mircs superuser; #ensure we are sudo
	create database mircs with owner mircs; #create the webapp's database
	\q #quit
	psql mircs -h 127.0.0.1 -d mircs < node_modules/connect-pg-simple/table.sql #prepare the database for connect-pg-simple middlware
	exit # Exit sql user

#2. Prepare config and credentials files:
	cp credentials.py.example credentials.py # and edit psql password in this file
	Add psql password in main.js (pgPassword)
	Edit data_proc_config.py to point to the image datasets
	Edit setup/prepare_ims.py and next_generation_daemon.py in case you want to run different datasets
        change the global image directory path in urlmap.js
        hardcode the number of images you're using into scripts/mirc_charts.js

#3. Initialize database with image sets
	python setup.py

#4. Run the CNN evolution daemon (do this e.g. in a screen or tmux)
	python next_generation_daemon.py

#5. Run the guess server (do this e.g. in a screen or tmux)
	cd guess_server
	python guess_server.py

#6. Finally, run the node server
	node main.js
	(and open a browser on http://localhost:8090)

---

x8 / pclpslabserrecit3 setup

We currently run the webservice under youssef@pclpslabserrecit3.services.brown.edu (VM3) and the CNN guess server under x8.clps.brown.edu.
Opening a remote tunnel from x8 to VM3, run on x8:

	autossh -M 20000 -R 7777:localhost:7777 -N youssef@pclpslabserrecit3.services.brown.edu

(TODO: Drew: Why did you use monitor port 20000 on autossh? Sven: Because I'm crazy like that.)

From the guess_server, images are expected to be in ../images. On x8, this folder is symlinked to /media/data_gluster/attention/dc_webapp/images.
To synchronize the image dataset from VM3 to x8, run on x8:

	rsync -avz youssef@pclpslabserrecit3.services.brown.edu:/home/youssef/dc_webapp/images /media/data_gluster/attention/dc_webapp/


If something goes wrong on the guess server (i.e. returns HTTP status 500), you can uncomment in guess_server.py:

	app.debug = True

To test whether the guess_server is reachable on VM3 at all, you can run e.g. on VM3:

	wget localhost:7777/guess

which will return a 500 because of missing parameters, but should at least reach some kind of server. If you cannot open the remote tunnel because the port is in use, try killing any lingering sshd processes and restart the ssh daemon.
