## KMesh Cluster

It gives the instructions and eseential dependencies to build the cluster required by KMesh.

### Cluster

First, you should install the kind in your local machine.
It's suggested to install the latest kind,
but you can also use the bin/kind.

Put the kind to a path which is included in the $PATH, e.g.,

	cp bin/kind ~/bin/
	export PATH=~/bin:$PATH


Similiarly, install kubectl and cilium using the same way.

### Deploy the test environment

Follow the instructions:

First, build a test cluster:

	kind create cluster --config kind-config.yaml


Second, prepare necessary components for tests (cilium, apps, ...):

	./env.sh

If the above script fails, please check each pod and see what's happening (in most case, it's because of network issues).


