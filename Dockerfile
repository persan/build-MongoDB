FROM ubuntu:latest
RUN apt-get clean ;apt-get update  ; apt-get upgrade -y
RUN apt-get install -y g++ make \
		cmake\
		libssl-dev\
		libcurl4-openssl-dev\
		liblzma-dev\
		ninja-build\
		python3-pip\
		python3 build-essential\
		python3-certifi\
		python3-cffi\
		python3-charset-normalizer\
		python3-cheetah\
		python3-cryptography\
		python3-idna\
		python3-packaging\
		python3-psutil\
		python3-pycparser\
		python3-pymongo\
		python3-pyparsing\
		python3-jsonschema\
		python3-regex\
		python3-requests\
		python3-psutil\
		python3-urllib3

RUN apt-get install -y \
		python3-devel\
		openssl-devel
