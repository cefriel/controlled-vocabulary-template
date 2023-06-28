# controlled-vocabulary-template

Template repository for controlled vocabularies.

## How to

Create a repository starting from this template repository. Rename the folders and the repository accordingly to the identifier of the controlled vocabulary. The IRI of the controlled vocabulary is composed using the repository name as https://w3id.org/my-namespace/my-vocabulary. The repository name should be used to replace `my-vocabulary` in all the places.

1. The RDF files describing the controlled vocabularies can be defined manually or by modifying the template Excel file [my-vocabulary.xlsx](.my-vocabulary/my-vocabulary.xlsx). Documentation on how to create more advanced Excel files can be found [here](https://xls2rdf.sparna.fr/rest/doc.html).

2. Download the tools as discussed below and put the JARs in the `tools` folder to automatise their execution through the `run.sh` script. A Java installation is required.

### `xls2rdf`: Excel to RDF
Download release JAR from [here](https://github.com/sparna-git/xls2rdf/releases) and rename it as `xls2rdf.jar`. You can alternatively use the user interface available at https://skos-play.sparna.fr/play/convert. Documentation for the CLI tool is available [here](https://github.com/sparna-git/xls2rdf/wiki/Command-line-Excel-to-RDF-conversion). The `run.sh` script was tested with version `2.2.0`.

### `widoco`: RDF to HTML
Download release JAR from [here](https://github.com/dgarijo/Widoco/releases) and rename it as `widoco.jar`. Documentation for the CLI tool is available [here](https://github.com/dgarijo/Widoco#how-to-use-widoco). The `run.sh` script was tested with version `1.4.19`.

3. Execute the `sh run.sh x.y.z` script providing as argument the correct version number. The version number should be the same declared in the Excel file.

4. Git commit and push
