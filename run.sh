#!/bin/bash

RELEASE="$1"

if [ "$RELEASE" = "" ]; then
    echo "Provide a version number x.y.z"
    exit 1
fi

if [ -d './my-vocabulary/'$RELEASE ]; then
    echo "The provided version already exists." 
else
	# From Excel to RDF
	java -jar tools/xls2rdf.jar convert -i ./my-vocabulary/my-vocabulary.xlsx -o './my-vocabulary/my-vocabulary.ttl' -l en
	sed -i $'/a skos:ConceptScheme/a\  a owl:Ontology;' ./my-vocabulary/my-vocabulary.ttl

	sleep 10

	# Clean /latest and create folders
	rm -r ./my-vocabulary/latest
	mkdir ./my-vocabulary/latest
	mkdir './my-vocabulary/'$RELEASE

	# Create serialisations and documentation
	java -jar tools/widoco.jar -uniteSections -noPlaceHolderText -ontFile ./my-vocabulary/my-vocabulary.ttl -outFolder ./my-vocabulary/latest -lang en

	# Move files
	rm ./my-vocabulary/latest/*.md
	cp -r ./my-vocabulary/latest/* './my-vocabulary/'$RELEASE
fi