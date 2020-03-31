# LND REST API Example

This example is for trying the exchange of funds on the Lightning Network.

You can easily try multi-hop payments using Jupyter Notebook.

lnd is used as an implementation of the Lightning network.

The daemons run in regtest mode. They run as docker containers.

* lnd: v0.9.2-beta
* Bitcoin Core: 0.19.1
* Jupyter Notebook


## Requirement

* VirtualBox
* Vagrant


## Usage

You can set up the environment by following the steps below.

```bash
$ git clone https://github.com/kadokko/example-lnd-rest-api.git
$ cd example-lnd-rest-api
$ vagrant up
$ vagrant ssh
$ cd /vagrant_share
$ ./start.sh
```

You can try this example on the following page.

```
http://localhost:20000/notebooks/lnd-rest-api-example.ipynb
```