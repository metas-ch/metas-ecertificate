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

## To Do

* Machine readable certificate header using [XMP](https://en.wikipedia.org/wiki/Extensible_Metadata_Platform) or PDF file properties.
* Remove text formatting `\textbf` from `\cobject` command.
* Remove text formatting `\textbf` and `\newline` from `\capplicant` command.
