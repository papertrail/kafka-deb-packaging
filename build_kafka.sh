#!/bin/bash
set -e
set -u
name=kafka
version=0.10.1.1
scala_version=2.11
description="Apache Kafka is a distributed publish-subscribe messaging system."
url="https://kafka.apache.org/"
arch="all"
section="misc"
license="Apache Software License 2.0"
package_version="-1"
src_package="kafka_${scala_version}-${version}.tgz"
download_url="http://mirror.cc.columbia.edu/pub/software/apache/kafka/${version}/${src_package}"
origdir="$(pwd)"

#_ MAIN _#
rm -rf ${name}*.deb
if [ ! -f "${src_package}" ]; then
  wget ${download_url}
fi
mkdir -p tmp && pushd tmp
TMPDIR=$(pwd)
rm -rf kafka-$version
mkdir -p kafka-$version
#cd kafka-$version
mkdir -p kafka-${version}/usr/lib/kafka
mkdir -p kafka-${version}/etc/default
mkdir -p kafka-${version}/etc/init
mkdir -p kafka-${version}/etc/kafka
mkdir -p kafka-${version}/var/log/kafka
mkdir -p kafka-${version}/debian

cp ${origdir}/kafka-broker.default kafka-${version}/etc/default/kafka-broker
cp ${origdir}/kafka-broker.upstart.conf kafka-${version}/etc/init/kafka-broker.conf
cp ${origdir}/debian/* kafka-${version}/debian

tar zxf ${origdir}/${src_package}
cd kafka_${scala_version}-${version}
mv config/log4j.properties config/server.properties ../kafka-${version}/etc/kafka
mv * ../kafka-${version}/usr/lib/kafka
cd ../kafka-${version}

#fpm -t deb \
#    -n ${name} \
#    -v ${version}${package_version} \
#    --description "${description}" \
#    --url="{$url}" \
#    -a ${arch} \
#    --category ${section} \
#    --vendor "" \
#    --license "${license}" \
#    -m "${USER}@localhost" \
#    --prefix=/ \
#    -s dir \
#    -- .
#mv kafka*.deb ${origdir}
popd
