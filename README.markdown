Skeleton SMA
============

Installation
------------

After installing and setting up [rbenv](https://github.com/sstephenson/rbenv):

`gem install bundle`

`bundle install`



Database setup:

`gem install data_mapper`

`sudo apt-get install libsqlite3-dev`

Create table users(U_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL DEFAULT 0, email varchar(255) NOT NULL UNIQUE, password varchar(90) NOT NULL,userclass varchar(30) NOT NULL, tagged INT DEFAULT 0);

Running
-------

Development:

`shotgun -p 4567 -s webrick config.ru`

Production:

`thin config.ru`
