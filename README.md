# UPDATE - December 2015
Head over to http://commonstandardsproject.com to browse the standards and see documentation for the API. The code is at [http://github.com/commonstandardsproject](http://github.com/commonstandardsproject). Or, checkout the [importer which will download the standards from the API and put them into your database](https://github.com/commonstandardsproject/standards-importer).

# State and Common Core Standards JSON Repository
JSON representations of the Common Core and State Standards 

## Why?

State and national standards connect to all parts of K-12 education. In order for K12 EdTech companies to use these standards in their apps, they need machine readable formats. 

## Hasn't this been done already?

Sort of. 

* The [Achievement Standards Network](http://asn.jesandco.org/) has created XML and JSON versions of the standards. In our experience, their schema doesn't fully address our needs. 
* [Academic Benchmarks](academicbenchmarks.com) is a company that sells XML and JSON versions of the standars. Like with ASN, 
we weren't satisfied with their schema.


## Example

Here's the JSON representation you can find on the 
```json
  standard_set = {
    "title": "Grade 1",
    "subject": "Mathematics",
    "educationLevels": [
      "01"
    ],
    "license": {
      "title": "CC BY 3.0 US",
      "URL": "http://creativecommons.org/licenses/by/3.0/us/",
      "rightsHolder": "Desire2Learn Incorporated"
    },
    "document": {
      "id": "D2604890",
      "valid": "2011",
      "title": "Maryland College and Career-Ready Standards - Mathematics (PK-8)",
      "sourceURL": "http://mdk12.org/instruction/curriculum/mathematics/index.html",
      "asnIdentifier": "D2604890",
      "publicationStatus": "Published"
    },
    "jurisdiction": {
      "id": "49FCDFBD2CF04033A9C347BFA0584DF0",
      "title": "Maryland"
    },
    "standards": {
      "0AD25973CF4E4DC892561BEEF05C6BB4": {
        "id": "0AD25973CF4E4DC892561BEEF05C6BB4", 
        "asnIdentifier": "S2604988",
        "position": 33000,
        "depth": 2,
        "statementNotation": "1.NBT.4",
        "statementLabel": "Standard",
        "description": "Add within 100, including adding a two-digit number and a one-digit number, and adding a two-digit number and a multiple of 10, using concrete models or drawings and strategies based on place value, properties of operations, and/or the relationship between addition and subtraction; relate the strategy to a written method and explain the reasoning used. Understand that in adding two-digit numbers, one adds tens and tens, ones and ones, and sometimes it is necessary to compose a ten.",
        "ancestorIds": [
          "E5B209C180E24242B7D337302A19D69B",
          "3993CD0C80874BE0B5CE62758D97F64A"
        ]
      }
    }
  }
```

## Progress

All standards are done!

## Contributing

There are three primary ways to contribute:

* **Give feedback on the schema** Does the schema solve your needs? Are there fields you want or need?
* **Convert other state standards to the schema** Ping me, `scott at commoncurriculum dot com` to chat.
