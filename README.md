if me
=====

An open-source community for mental health experiences

Geting involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If you have any questions, email tojulianguyen@gmail.com.

Getting started
---------------

### Installing Programs

Easiest ways to install Ruby on Rails and Postgres:

http://railsinstaller.org/en

http://www.postgresql.org/download/

The steps below should be straightforward for Linux and OSX users. Windows users please refer to this [guide](https://gist.github.com/KelseyDH/11198922) for tips on setup.

### Running the App

After cloning the app on your local machine, in your terminal run the following commands in the `/ifme` directory

```
bundle install
```

### Possible Errors

If `Ruby Bundle Symbol not found: _SSLv2_client_method (LoadError)` is encountered, try running the following commands.

```
rvm get stable
```

```
rvm reinstall ruby
```

```
rvm gemset pristine
```

On Windows, you may encounter an error like `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`.  If this happens, download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

### Setting up Postgres

Time to set up a Postgres user!

```
sudo su - postgres
```

```
createuser -s -r ifme_app
````

In `pg_hba.conf`, make sure the value for `auth-method` in the `ifme_app` database is `trust`. This is because no password is being used for the local development and test databases, as seen in `database.yml`. Refer to this [guide](http://www.postgresql.org/docs/8.2/static/auth-pg-hba-conf.html) as a reference.

### Running the app locally

After exiting from Postgres by typing in `exit` in the terminal, run the following commands.

```
bin/rake db:create db:migrate
```

```
rails s
```

Testing accounts
-----------------

They have been created in `seeds.rb`.

```
Email: test1@example.com
Password: password99
```

```
Email: test2@example.com
Password: password99
```

Rspec tests
------------

Always write unit tests for the changes you've made! If you see any missing unit tests, write them!

```
rspec
```
