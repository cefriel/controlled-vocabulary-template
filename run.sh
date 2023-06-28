#!/bin/bash

RELEASE="$1"
VOCABULARY="my-vocabulary"

if [ "$RELEASE" = "" ]; then
    echo "Provide a version number x.y.z"
    exit 1
fi

if [ -d './'$VOCABULARY'/'$RELEASE ]; then
    echo "The provided version already exists." 
else
	# From Excel to RDF
	java -jar tools/xls2rdf.jar convert -i './'$VOCABULARY'/'$VOCABULARY'.xlsx' -o './'$VOCABULARY'/'$VOCABULARY'.ttl' -l en
	sed -i $'/a skos:ConceptScheme/a\  a owl:Ontology;' './'$VOCABULARY'/'$VOCABULARY'.ttl'

	sleep 10

	# Clean /latest and create folders
	rm -r './'$VOCABULARY'/latest'
	mkdir './'$VOCABULARY'/latest'
	mkdir './'$VOCABULARY'/'$RELEASE

	# Create serialisations and documentation
	java -jar tools/widoco.jar -uniteSections -noPlaceHolderText -ontFile './'$VOCABULARY'/'$VOCABULARY'.ttl' -outFolder './'$VOCABULARY'/latest' -lang en

	# Move files
	mv './'$VOCABULARY'/latest/index-en.html' './'$VOCABULARY'/latest/index.html'
	mv './'$VOCABULARY'/latest/ontology.jsonld' './'$VOCABULARY'/latest/'$VOCABULARY'.jsonld'
	mv './'$VOCABULARY'/latest/ontology.nt' './'$VOCABULARY'/latest/'$VOCABULARY'.nt'
	mv './'$VOCABULARY'/latest/ontology.owl' './'$VOCABULARY'/latest/'$VOCABULARY'.owl'
	mv './'$VOCABULARY'/latest/ontology.ttl' './'$VOCABULARY'/latest/'$VOCABULARY'.ttl'
	rm './'$VOCABULARY'/latest/'*'.md'
	cp -r './'$VOCABULARY'/latest/'* './'$VOCABULARY'/'$RELEASE
fi