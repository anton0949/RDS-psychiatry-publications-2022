# Publications from the departments of Adult Psychiatry and Child & Adolescent Psychiatry in the Region of Southern Denmark, 2022

## Method for the 2022 reports:

A bibliometric analysis was conducted on published articles with affiliations to the Region of Southern Denmark in the fields of Child and Adolescence Psychiatry and Adult Psychiatry for the year 2022.

Initially, we obtained a wide filter export of publications from the university library, covering all publications with authors having potential affiliation to the region’s departments for the year 2022. The export is called a "PURE report" and is located in `/Data/Pure.docx`.

Unique references published in peer-reviewed journals with a DOI number were identified and imported into EndNote reference management software. EndNote was used to automatically search online databases for reference updates, and the resulting dataset was exported as an EndNote XML file. The XML export file acts as primary input in our tooling used for building the reports and should be located in the `/Data` directory named `2022.xml`. The tooling is documented below.

Using the `author_extract.R` script we generated a complete author list database in the CSV format. This should also be located in the `/Data` directory named `authors.csv`.

For each author registered in the PURE report we manually checked their affiliations to determine how they should be included in our dataset. If an author had an affiliation to the departments, it was noted in the author list database generated above. In column “type” we putted “ADULT” if they was affiliatated to the departments of Adult Psychiatry; “BUP” if affiliation to the departments of Child and Adolescence Psychiatry and “NON” if the author was confirmed not having an affiliation to either of the departments. Rest of the authors was left blank.

Any references in the PURE report that were not relevant to the study were manually excluded by putting their DOI number along with an exclusion reason in the excluded.CSV file. Some references without was without DOI, here we putted the title.

We ran build_jif.R” to build a database of journals stored in the CSV formatted in `/Data/jif.csv`. To the database we manually added the corresponding Journal Impact Factor along with a source. Preferable we used The Journal Citation Reports (JCR) produced by Clarivate Analytics as source.
In file “2022.R” we prepared our tooling for building the report data.

**Summary of relevant datafile:**
- `/Data/PURE.docx`: The original data source provided by the university library.
- `/Data/excluded.csv`: List of exluded articles along with a reason.
- `/Data/authors.csv`: List of all authors in our dataset. Column type shows author affiliation.
- `/Data/jif.csv`: Journal impact factor database
- `/Data/2022.xml`: Our reference database in EndNote XML format

## Tooling

We utilized the R programming language to develop tooling that allows for the generation of figures and tables for our bibliometric reports. To generate the reports, we use the "create_report" function with relevant parameters, which is implemented in the `2022.R` file. To run the function, we provided the relevant data files as described above. 

This allows for easy rebuilding and compilation of reports increasing efficiency and giving the workflow a stricter method and better overview because of the data files. 

Additionally, it gives each department easy access to generate reports based on sub-datasets just by modifying the Endnote and CSV databases.

## BibTeX

```BibTeX
@techreport{Gregersen2022Adult,
    title={Publications from the departments of Adult Psychiatry in the Region of Southern Denmark, 2022},
    author={Gregersen, Anton Tambour and Mandal, Pranga Prava and Agharazi, Armaghan and Munk-Jørgensen, Povl},
    year={2023},
    institution={Psychiatric Research Academy},
    type={Technical Report}
}

@techreport{Gregersen2022BUP,
    title={Publications from the departments of Child & Adolescent Psychiatry in the Region of Southern Denmark, 2022},
    author={Gregersen, Anton Tambour and Mandal, Pranga Prava and Agharazi, Armaghan and Munk-Jørgensen, Povl},
    year={2023},
    institution={Psychiatric Research Academy},
    type={Technical Report}
}
```
