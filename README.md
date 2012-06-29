# State and Common Core Standards JSON Repository
JSON representations of the Common Core and State Standards 

# Why?

State and national standards connect to all parts of K-12 education. In order for K12 EdTech companies to use these standards in their apps,
they need machine readable formats. 

# Hasn't this been done already?

Sort of. 

* The [Achievement Standards Network](http://asn.jesandco.org/) has created XML and JSON versions of the standards. In our experience, their schema 
doesn't fully address our needs. 
* [Academic Benchmarks](academicbenchmarks.com) is a company that sells XML and JSON versions of the standars. Like with ASN, 
we weren't satisfied with their schema.




# Guiding Principles on the Schema

* **Each standard should be it's own document**
Fetching a standard shouldn't require traversing a tree.

* **Use the [Common Education Data Standards](https://ceds.ed.gov/dataModel.aspx) created by the US Dept of Ed schema**
The fields in each standard should reflect the schema described the CEDS. 

* **Use GUIDs for cross-app communication**
For EdTech companies to better use each other's APIs, each standard needs to share the same GUID. The organization that produced 
the Common Core standards, the [NGA/CCSSO](http://www.corestandards.org/) has released
[GUIDs](http://www.corestandards.org/developments-on-common-core-state-standards-identifier-and-xml-representation).
These GUIDs are used for the standards above

* **Cater to teachers: use short codes** Teachers live and breath the standards. They know them by name and code. Long codes
like "CC.Math.1.NBT.2a" are distracting and annoying. A teacher would call that standard "1.NBT.2a" as they already know it's a math standard
from the Common Core. The standards need to codify the commonly used short code for the standard.

* **Namespace attributes** The NGA/CCSSO (referred to in the standars as the CCSSI or Common Core State Standards Inititative) has 
released URIs, URLs, GUIDs, and official long codes for each standard. The ASN has released it's own set of identifiers and URIs for the standards.
Academic Benchmarks has their own set of GUIDs and URIs for each standard. Undoubtedly, other organizations will release metadata as well.
To organize the data, each organization's metadata should be under it's own key (e.g. "CCSSI" would hold CCCSSI's URI and URL)



