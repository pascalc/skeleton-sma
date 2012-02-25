Skeleton SMA
============

Installation
------------

After installing and setting up [rbenv](https://github.com/sstephenson/rbenv):

`gem install bundle`

`bundle install`

Running
-------

Development:

`shotgun -p 4567 -s webrick config.ru`

Production:

`thin config.ru`