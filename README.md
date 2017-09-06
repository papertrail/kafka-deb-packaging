kafka-deb-packaging
===================

Not so simple debian packaging for Apache Kafka

## Notes:
Due to maven's braindamage, a recent version of pbuilder with the --use-network flag needs to be 
used to build the package.

## Changelog
2015-Mar-18 : Updated for latest Kafka 0.8.2.1 and use sbt in system path.
2016-Apr-29:  Updated for 0.8.2.2 and use binary dist
2017-Sep-5 :  Updated to use dpkg-buildpackage/pbuilder and include librato metrics jar
