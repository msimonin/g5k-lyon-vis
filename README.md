g5k-lyon-vis
============

Real time visualisation of the power consumption of Lyon cluster.

Installation
------------

* Clone the repository

* Enter the directory and create a `.auth` file containing the base64 encoding of your `login:password`.

```shell
echo "login:password" | base64 > .auth
chmod 600 .auth
```

* Enter the repository and type :

```
$) bundle install
```

* Launch the server : 

```
$) bundle exec puma
```

* From here clients can connect to `http://yourip:9292`
