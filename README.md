About
------

`viconf` solves the following problems for me:

- I cannot remembered where programs put their config file.
- I am too lazy to `man command` to look up the config file location.
- I often make typos when editing config files.

Usage
-----

Run:

    viconf command

Then `viconf` will open the config file for this command, and you can edit it.
And `viconf` will try to check the syntax before saving the file.

Install
--------

You need `wget` and node module `coffee`, `shelljs` to install this script.

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

You can use the following command to update configure files from the upstream repo (Be careful, it will overrides your local changes.)

```sh
coffee make.coffee updatedb
```

Contribute
-----------

<https://github.com/weakish/viconf>
