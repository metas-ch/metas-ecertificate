# metas-ecertificate
[METAS](https://www.metas.ch/) eCertificate is [LaTeX](https://en.wikipedia.org/wiki/LaTeX) template for an electronic calibration certificate with embedded data files.

## Certificate without Data

The following command will generate a [PDF/A-2u](https://en.wikipedia.org/wiki/PDF/A) without embedded data files:
````tex
\documentclass[nodata]{ecertificate}
````

## Certificate with Data

The following command will generate a [PDF/A-3u](https://en.wikipedia.org/wiki/PDF/A) with embedded data files:
````tex
\documentclass[data]{ecertificate}
````

The following command embedds a data file:
````tex
\datafile{DIRECTORY/}{FILENAME}
````

Multiple embedded data files are allowed in a [PDF/A-3u](https://en.wikipedia.org/wiki/PDF/A).
    
## Certificate Header

The following commands describe the certificate header:

````tex
\cnumber{XXX-01234}
%\coldnumber{XXX-01233}
\cobject{\textbf{Beschreibung des Pr\"uflings, eindeutige Identifikation}}
\corder{Kurze Beschreibung des Auftrags (Wenn aufgrund des Kalibriergegenstandes der Kalibrierumfang klar ist (z. B. Widerstand, Endmass), kann dieser Abschnitt ausnahmsweise weggelassen werden.)}
\capplicant{\textbf{Name und Adresse des Auftraggebers} \newline{}Firma, [Abteilung], Adresse PLZ Ort}
\cdateofcalibration{dd.mm.yyyy}
\cmarking{mm.yyyy}
\cdate{20 February 2020}
\csection{Sector xxx}
\cauthor{First Name Last Name}
\creviewer{Dr First Name Last Name, Head of sector}
\ccmc{1}
````
Uncomment the command `\coldnumber{XXX-01233}` will add the following text to the first page of the certificate:

> *Replaces the certificate no XXX-01233*

The command `\ccmc{0}` will not add the CMC logo. The command `\ccmc{1}` will add the CMC logo to first page.

## Certificate Content

A calibration certificate contains the following sections:
````tex
\begin{document}
    \maketitle
    \section*{Extent of the Calibration}
    bla
    \section*{Measurement Procedure}
    bla
    \section*{Measurement Conditions}
    bla
    \section*{Measurement Results}
    bla
    \uncsection
\end{document}
````

## Metadata

The [metadata](https://en.wikipedia.org/wiki/PDF#Metadata) of the generated PDF can be accessed for example from [Python](https://www.python.org/) using the [PyPDF2](https://pypi.org/project/PyPDF2/) package:
````python
from PyPDF2 import PdfFileReader
pdf_reader = PdfFileReader(open("eExample.pdf", "rb"), strict=False)
pdf_info = pdf_reader.getDocumentInfo()
````

`pdf_info` contains the following values:

````python
{
    '/Certificate_of_Calibration_No': 'XXX-01234',
    '/Replaces_the_Certificate_No': '0',
    '/Object': 'Beschreibung des Prüflings, eindeutige Identifikation',
    '/Order': 'Kurze Beschreibung des Auftrags (Wenn aufgrund des Kalibriergegenstandes der Kalibrierumfang klar ist (z. B. Widerstand, Endmass), kann dieser Abschnitt ausnahmsweise weggelassen werden.)',
    '/Applicant': 'Name und Adresse des Auftraggebers Firma, [Abteilung], Adresse PLZ Ort',
    '/Traceability': 'The reported measurement values are traceable to national standards and thus to internationally supported realisations of the SI units.',
    '/Date_of_Calibration': 'dd.mm.yyyy',
    '/Marking': 'Calibration label METAS mm.yyyy',
    '/Date_of_Certificate': '20 February 2020',
    '/For_the_Measurements': 'First Name Last Name',
    '/Approved_by': 'Dr First Name Last Name, Head of sector, Sector xxx',
    '/CMC': 'True', 
    '/Title': 'Certificate of Calibration No XXX-01234',
    '/Creator': 'LaTeX with hyperref',
    '/CreationDate': "D:20200221075548+01'00'", 
    '/ModDate': "D:20200221075548+01'00'", 
    '/Producer': 'pdfTeX', 
    '/Trapped': '/False', 
    '/GTS_PDFA1Version': 'PDF/A-3u:2012'
}
````

## Embedded Data Files

The [embedded data files](https://en.wikipedia.org/wiki/PDF#File_attachments) of the generated PDF can be accessed as well from [Python](https://www.python.org/) using the [PyPDF2](https://pypi.org/project/PyPDF2/) package:
````python
from PyPDF2 import PdfFileReader
pdf_reader = PdfFileReader(open("eExample.pdf", "rb"), strict=False)
pdf_embedded_files = pdf_reader.trailer["/Root"]["/Names"]["/EmbeddedFiles"]["/Names"]
pdf_file_names = pdf_embedded_files[0::2]
````

`pdf_file_names` contains the following file names:

````python
['01419_Att20dB(f-m)_52371_01_01.sdatb', 'data_01.txt', 'data_02.txt']
````

The following code reads the content for example of the second attached file `data_01.txt`:

````python
pdf_file_index = pdf_file_names.index('data_01.txt')
pdf_data_index = 2*pdf_file_index + 1
pdf_data_object = pdf_embedded_files[pdf_data_index].getObject()
data = pdf_data_object["/EF"]["/F"].getData()
````
The value of `data` is the content `b'Test 01'` of the file `data_01.txt`.

## To Do

- [x] Machine readable certificate header using [XMP](https://en.wikipedia.org/wiki/Extensible_Metadata_Platform) or PDF file properties.
- [ ] Remove text formatting `\textbf` from `\cobject` command.
- [ ] Remove text formatting `\textbf` and `\newline` from `\capplicant` command.
