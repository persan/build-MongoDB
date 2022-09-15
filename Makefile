# This is the script to build mongodb from source in acrodance with.
# 	https://github.com/mongodb/mongo/blob/master/docs/building.md
# The host requires 
#	moreutils for "ts"
#	git
#	podman 



# Reqires the folowing packages from PyPi:
#  PyYAML-6.0					PyYAML-6.0-cp310-cp310-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_12_x86_64.manylinux2010_x86_64.whl
#  cryptography-36.0.2			cryptography-36.0.2-cp36-abi3-manylinux_2_24_x86_64.whl
#  ninja-1.10.2.3				ninja-1.10.2.3-py2.py3-none-manylinux_2_5_x86_64.manylinux1_x86_64.whl
#  psutil-5.8.0					psutil-5.8.0.tar.gz
#  requirements_parser-0.3.1	requirements_parser-0.3.1-py3-none-any.whl
#  types-PyYAML-6.0.11			types_PyYAML-6.0.11-py3-none-any.whl
#  types-setuptools-57.4.1		types_setuptools-57.4.18-py3-none-any.whl
#  typing-extensions-4.3.0		typing_extensions-4.3.0-py3-none-any.whl

podman?=podman

mongoTag:=6.0.0
src-inside:=/mnt

all:mongo
	${podman} build . -t mongo-builder:1.0
run:
	${podman} run --user=${user} --privileged \
	                          -v${PWD}/mongo:${src-inside}:rw \
	                          -v${PWD}/Makefile:/Makefile:rw \
	                          -it localhost/mongo-builder:1.0\
	                          make build 2>&1 | ts "%H:%M:%S>  " | tee compile.log

mongo-clone:
	git clone https://github.com/mongodb/mongo.git
	touch mongo-clone

.PHONY:mongo
mongo:mongo-clone
	git -C $@ clean -xdff
	git -C $@ checkout -B tags/r${mongoTag}

build: # Target to be run inside the container
	cd ${src-inside};python3 -m pip install -r etc/pip/compile-requirements.txt
	cd ${src-inside};python3 buildscripts/scons.py install-mongod --disable-warnings-as-errors MONGO_VERSION=${mongoTag}

