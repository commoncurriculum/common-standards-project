# State and Common Core Standards JSON Repository
JSON representations of the Common Core and State Standards 

## Why?

State and national standards connect to all parts of K-12 education. In order for K12 EdTech companies to use these standards in their apps,
they need machine readable formats. 

## Hasn't this been done already?

Sort of. 

* The [Achievement Standards Network](http://asn.jesandco.org/) has created XML and JSON versions of the standards. In our experience, their schema 
doesn't fully address our needs. 
* [Academic Benchmarks](academicbenchmarks.com) is a company that sells XML and JSON versions of the standars. Like with ASN, 
we weren't satisfied with their schema.



## Guiding Principles on the Schema

* **Each standard should be it's own document**
Fetching a standard shouldn't require traversing a tree.

* **Use the [Common Education Data Standards](https://ceds.ed.gov/dataModel.aspx) created by the US Dept of Ed schema**
The fields in each standard should reflect the schema described the CEDS. 

* **Use GUIDs for cross-app communication**
For EdTech companies to better use each other's APIs, each standard needs to share the same GUID. The organization that produced 
the Common Core standards, the [NGA/CCSSO](http://www.corestandards.org/) has released
[GUIDs](http://www.corestandards.org/developments-on-common-core-state-standards-identifier-and-xml-representation).
These GUIDs are used for the standards above.

* **Cater to teachers: use short codes** Teachers live and breath the standards. They know them by name and code. Long codes
like "CC.Math.1.NBT.2a" are distracting and annoying. A teacher would call that standard "1.NBT.2a" as they already know it's a math standard
from the Common Core. The standards need to codify the commonly used short code for the standard.

* **Namespace attributes** The NGA/CCSSO (referred to in the standars as the CCSSI or Common Core State Standards Inititative) has 
released URIs, URLs, GUIDs, and official long codes for each standard. The ASN has released it's own set of identifiers and URIs for the standards.
Academic Benchmarks has their own set of GUIDs and URIs for each standard. Undoubtedly, other organizations will release metadata as well.
To organize the data, each organization's metadata should be under it's own key (e.g. "CCSSI" would hold CCCSSI's URI and URL)

* **Just data. No Markup** Standards shouldn't have HTML tags or list numbers (e.g. "1. Understand...."). 

## Example

Here's the standard as published by the NGA/CCSSO:


Here's the JSON representation:
```json
  {
    "id":"2A26EE660F72412EA29765D79C367F0B",
    "language":"English",
    "subject":"Math",
    "gradeLevel":"Grade 1",
    "code":"Math.1.OA.7",
    "shortCode":"1.OA.7",
    "listIdentifier":"7",
    "statement":"Understand the meaning of the equal sign, and determine if equations involving addition and subtraction are true or false.",
    "clarifications":[
      "For example, which of the following equations are true and which are false? 6 = 6, 7 = 8 - 1, 5 + 2 = 2 + 5, 4 + 1 = 5 + 2."
    ],
    "gradeLevels":[
      "01"
    ],
    "jurisdiction":"Common Core State Standards Initiative",
    "jurisdictionAbbreviation":"CC",
    "ASN":{
      "identifier":"http://purl.org/ASN/resources/S114343E",
      "id":"S114343E",
      "parent":"S1143430",
      "indexingStatus":"Yes",
      "authorityStatus":"Original Statement",
      "statementNotation":"1.OA.7",
      "leaf":"true"
    },
    "CCSSI":{
      "GUID":"2A26EE660F72412EA29765D79C367F0B",
      "dotNotation":"Math.1.OA.7",
      "URI":"http://corestandards.org/2010/math/content/1/OA/7",
      "currentURL":"http://www.corestandards.org/the-standards/mathematics/grade-1/operations-and-algebraic-thinking/#1-oa-7"
    }
  },
```


### Notes:
* **Grade Level vs Grade Level** As some standards address multiple grades, the plural form holds an array of the grades levels
(using the CEDS list of official identifiers). `gradeLevel` holds a string of the grade. E.g. A high school standard would target 
grades 9, 10, 11, and 12 but it's `gradeLevel` would be "High School".

* **Clarifications** In standards, the authors often have some explanatory information. For the Maryland standars, the authors 
note the limits of the state assessment. For the Common Core, the authors often give examples. Currently, the footnotes are included
in the `clarifications` section. In the future, hopefully these will be broken out in a separate `footnotes` field.

* **List identifier is an admittedly clumsy name.** It references the number or letter at the beginning of a standard. E.g.
If the the standard was `1.OA.7`, and you were rendering all the standards in `1.OA`, you could render it like (using Handlebars):

```
{{#each standard}}
  {{listIdentifier}}. {{statement}}
{{/each}}
```

which would produce:

```
1. Use addition and subtraction within 20 ...
2. Solve word problems that call for addition ...
3. Apply properties of operations ... 
```

## Folder Stucture

Munging JSON is an iterative process. To that end, the data is in three folders:

* `raw-data`
Raw Data holds the raw data downloads from the ASN or other organizations

* `transition-data`
Munging isn't an overnight process. Standards currently in transition are saved in the transition data folder.

* `clean-data`
These are the final versions of the standards. Undoubtedly, errors will be found and corrected. Thus, each 
document should have a version number for clarify.

On version numbers: these are similar to semantic versioning:
`X.y.z: Major` is for a complete change in the schema.
`x.Y.z: Minor` is for a significant error or addition. E.g. adding another organization's meta data would bump the minor version
as would fixing a systemic error with URLs or URIs in the standards.
'x.y.Z: Patch` is for typos and other tiny errors.


