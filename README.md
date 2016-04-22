About
------

`viconf` solves the following problems for me:

- I cannot remembered where programs put their config file.
- I am too lazy to `man command` to look up the config file location.
- I often make typos when editing config files.

Depends
--------

`viconf-syncdb`, which updates meta config file,
a.k.a. a map of commands and config file paths,
depends on the following programs:

- `curl`
- `git`
- `jq`

Usage
-----

Run:

    viconf command

Then `viconf` will open the config file for this command, and you can edit it.
And `viconf` will try to check the syntax before saving the file.

Occasionally, run `viconf-syncdb` to update meta config file.

Install
--------

### With basher

```sh
; basher install weakish/viconf
; viconf-syncdb
```

Require [basher][] version: `>=39875bc`.

[basher]: https://github.com/basherpm/basher

### With node


```sh
sudo npm install -g coffee-script
git clone https://github.com/weakish/viconf.git
cd viconf
npm install shelljs
sudo coffee make.coffee
```

This will install the `viconf` bin file to `/usr/local/bin/`.
You can specify install directory via `make.coffee install`, e.g.

```sh
sudo coffee make.coffee install /usr/bin
```

or

```sh
coffee make.coffee install ~/bin
```


Contribute
-----------

https://github.com/weakish/viconf

License
--------

0BSD
