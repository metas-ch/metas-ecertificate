\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecertificate}[2021/10/25 V2.9 METAS eCertificate]
% Option nodata --> PDF/A-2u (PDF V1.7)
% No problems found with Adobe Preflight
\DeclareOption{nodata}{
    \def\@cdata{0}
}
% Option data --> PDF/A-3u (PDF V1.7)
% Problems:
% - Bundesarchiv supports only PDF/A-1b and PDF/A-2u, see https://www.bar.admin.ch/bar/de/home/archivierung/ablieferung/digitale-unterlagen.html
% - Open eGov LocalSigner 4.2.4 supports only PDF/A-1b and PDF/A-2u. But it's working as well with PDF/A-3u.
% - METAS-API support ???
\DeclareOption{data}{
    \def\@cdata{1}
}
\ExecuteOptions{nodata}
\ProcessOptions\relax
\LoadClass[a4paper,11pt]{article}


\newcommand{\cnumber}[1]{\def\@cnumber{#1}}
\newcommand{\coldnumber}[1]{\def\@coldnumber{#1}}
\newcommand{\cobject}[1]{\def\@cobject{#1}}
\newcommand{\corder}[1]{\def\@corder{#1}}
\newcommand{\capplicant}[1]{\def\@capplicant{#1}}
\newcommand{\cdateofcalibration}[1]{\def\@cdateofcalibration{#1}}
\newcommand{\cmarking}[1]{\def\@cmarking{#1}}
\newcommand{\cdate}[1]{\def\@cdate{#1}}
\newcommand{\csection}[1]{\def\@csection{#1}}
\newcommand{\cauthor}[1]{\def\@cauthor{#1}}
\newcommand{\creviewer}[1]{\def\@creviewer{#1}}
\newcommand{\clogo}[1]{\def\@clogo{#1}}
\newcommand{\ccmc}[1]{\def\@ccmc{#1}}
\newcommand{\uhref}[2]{\href{#1}{\uline{#2}}}

\def\@coldnumber{0}
\def\@clogo{1}
\def\@clogocont{0}
\def\@ctraceability{The reported measurement values are traceable to national standards and thus to internationally supported realisations of the SI units.}
\def\@cmutualrecognition{This certificate is consistent with Calibration and Measurement Capabilities (CMCs) that are included in Appendix C of the Mutual Recognition Arrangement (MRA) drawn up by the International Committee for Weights and Measures. Under the MRA, all participating institutes recognize the validity of each other's calibration certificates and measurement reports for the quantities, ranges and measurement uncertainties specified in Appendix C (for details see \uhref{https://www.bipm.org}{www.bipm.org}).}

\usepackage{geometry}
\setlength{\headheight}{25mm}
\setlength{\headsep}{9mm}
\setlength{\footskip}{5.5mm} 
\geometry{left=30mm, right=15mm, top=45mm, bottom=28mm}
\usepackage[T1]{fontenc}
\usepackage[scaled]{uarial}
\renewcommand*\familydefault{\sfdefault}
\usepackage{ifthen}
\usepackage{graphicx}
\usepackage{lastpage}
\usepackage{fancyhdr}
\pagestyle{fancy}

\usepackage[normalem]{ulem}

% Embedfile
\usepackage{embedfile}
\newcommand{\datafile}[2]{
    \ifthenelse{\equal{\@cdata}{1}}
        {\embedfile[filespec={#2},ucfilespec={#2},filesystem=URL,mimetype=application/octet-stream,afrelationship={/Data},desc={#2},stringmethod=escape]{#1#2}}
        {}
}

% PDF/A
\RequirePackage{filecontents}
\RequirePackage{etoolbox}
\AtEndPreamble{
    \ifthenelse{\equal{\@cdata}{1}}
        {\RequirePackage[a-3u,pdf17]{pdfx}} % Option data --> PDF/A-3u (PDF V1.7)
        {\RequirePackage[a-2u,pdf17]{pdfx}} % Option nodata --> PDF/A-2u (PDF V1.7)
}
% PDF/A Metadata (XMP)
\begin{filecontents}{\jobname.xmpdata}
    \Title{Certificate of Calibration No \@cnumber}
    \Author{\@cauthor}
\end{filecontents}

\usepackage[pdfa]{hyperref}
\ifthenelse{\equal{\@cdata}{1}}
    {\pdfminorversion=7} % Option data --> PDF/A-3u (PDF V1.7)
    {\pdfminorversion=7} % Option nodata --> PDF/A-2u (PDF V1.7)
\ifthenelse{\equal{\@cdata}{1}}
    {\hypersetup{pdfpagemode={UseAttachments}}} % Option data
    {}
\hypersetup{
    pdfpagelayout={SinglePage},
    pdfduplex={Simplex},
    pdfprintscaling=None,
    bookmarksopenlevel=0,
    colorlinks=true,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=blue
}

% PDF/A Metadata (Document Properties / Custom Properties)
\AtBeginDocument{
    \pdfstringdef\pdfcnumber\@cnumber
    \pdfstringdef\pdfcoldnumber\@coldnumber
    \pdfstringdef\pdfcobject\@cobject
    \pdfstringdef\pdfcorder\@corder
    \pdfstringdef\pdfcapplicant\@capplicant
    \pdfstringdef\pdfctraceability\@ctraceability
    \pdfstringdef\pdfcdateofcalibration\@cdateofcalibration
    \pdfstringdef\pdfcmarking\@cmarking
    \pdfstringdef\pdfcdate\@cdate
    \pdfstringdef\pdfcauthor\@cauthor
    \pdfstringdef\pdfcreviewer\@creviewer
    \pdfstringdef\pdfcsection\@csection
    \ifthenelse{\equal{\@ccmc}{1}}{\pdfstringdef\pdfccmc{True}}{\pdfstringdef\pdfccmc{False}}
    \pdfinfo{/Certificate_of_Calibration_No (\pdfcnumber)
             /Replaces_the_Certificate_No (\pdfcoldnumber)
             /Object (\pdfcobject)
             /Order (\pdfcorder)
             /Applicant (\pdfcapplicant)
             /Traceability (\pdfctraceability)
             /Date_of_Calibration (\pdfcdateofcalibration)
             /Marking (Calibration label METAS \pdfcmarking)
             /Date_of_Certificate (\pdfcdate)
             /For_the_Measurements (\pdfcauthor)
             /Approved_by (\pdfcreviewer, \pdfcsection)
             /CMC (\pdfccmc)
    }
}
\pdfsuppressptexinfo15

\fancyhead[L]{}
\fancyhead[C]{}
\fancyhead[R]{}
\fancyfoot[L]{\fontsize{7.5pt}{9.5pt}\selectfont{}
This document is only valid and reviewable in its electronic form.\newline{}
Please observe the information given on \uhref{https://www.metas.ch/ecert}{www.metas.ch/ecert}.
\ifthenelse{\equal{\@clogo}{1}}{\newline{}\newline{}\textbf{METAS}\newline{}Lindenweg 50, 3003 Bern-Wabern, Switzerland, phone +41 58 387 01 11, \uhref{https://www.metas.ch}{www.metas.ch}}{}}
\fancyfoot[C]{}
\fancyfoot[R]{\fontsize{7.5pt}{9.5pt}\selectfont{}~\newline{}\thepage{}/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\renewcommand{\maketitle}{
\newgeometry{left=30mm, right=15mm, top=11mm, bottom=28mm} 
\noindent\hspace*{-20mm}\begin{tabular}{@{}p{10mm}@{} @{}p{10mm}@{} @{}p{60mm}@{} @{}p{105mm}@{}}
  \vspace{30mm} & \multicolumn{2}{ @{}p{70mm}@{} }{
    \ifthenelse{\equal{\@clogo}{1}}{\vtop{\vskip-1ex\hbox{\includegraphics{CDBund2.pdf}}}}{}
  } 
  & \fontsize{7.5pt}{12.5pt}\selectfont{}\vspace{-3.75pt}\textbf{Federal Institute of Metrology METAS}\newline{}\\
	& & \multicolumn{2}{@{}p{165mm}@{}}{\fontsize{20pt}{22pt}\selectfont{}\textbf{Certificate of Calibration No \@cnumber{}}}\\
	\ifthenelse{\equal{\@coldnumber}{0}}
	{
	\vspace{44pt} & & & \\
	}
	{
	& & & \\
	& & \multicolumn{2}{@{}p{165mm}@{}}{\textit{Replaces the certificate no \@coldnumber{}}} \\
	\vspace{17pt} & & & \\
	}
	& & \textit{Object}              & \@cobject{} \\
	& & & \\
	& & \textit{Order}               & \@corder{} \\
	& & & \\
	& & \textit{Applicant}           & \@capplicant{} \\
	& & & \\
	& & \textit{Traceability}        & \@ctraceability{} \\
	& & & \\
	& & \textit{Date of Calibration} & \@cdateofcalibration{} \\
	& & & \\
	& & \textit{Marking}             & Calibration label METAS \@cmarking{} \\
	%\vspace{44pt} & & & \\
	& & & \\
	& & & \\
	& & & \\
	& & \multicolumn{2}{@{}p{165mm}@{}}{3003 Bern-Wabern, \@cdate{}} \\
	& & & \\
	& & & \\
	& & \textit{For the Measurements}& \@cauthor{} \\
	& & & \\
	& & & \\
	& & \textit{Approved by}         & \@creviewer{} \\
	& &                              & \@csection{} \\
	& & & \\
\end{tabular}
\ifthenelse{\equal{\@ccmc}{1}}{
\vfill
\noindent\hspace*{-20mm}\begin{tabular}{@{}p{20mm}@{} @{}p{165mm}@{}}
	\vtop{\vskip-1ex\hbox{\includegraphics[width=17.7mm]{CIPM_MRA_c.png}}} & \fontsize{9pt}{11pt}\selectfont{}\textbf{Mutual recognition}\newline{}\@cmutualrecognition
	\vspace{7pt}
\end{tabular}
}{}
\newpage
\restoregeometry
\fancyhead[L]{\ifthenelse{\equal{\@clogocont}{1}}
{\hspace{-10mm}\vtop{\vskip-1ex\hbox{\includegraphics{CDBund2.pdf}}}\vspace{11.68pt}\newline{}\fontsize{12pt}{14pt}\selectfont{}\textbf{Certificate of Calibration No \@cnumber{}}}
{\fontsize{12pt}{14pt}\selectfont{}\textbf{Certificate of Calibration No \@cnumber{}}\newline{}\vspace{11.68pt}}
} % 13.54pt with CDBund.pdf
\fancyfoot[L]{\fontsize{7.5pt}{9.5pt}\selectfont{}
\ifthenelse{\equal{\@clogocont}{1}}{\newline{}\newline{}\textbf{METAS}\newline{}Lindenweg 50, 3003 Bern-Wabern, Switzerland, phone +41 58 387 01 11, \uhref{https://www.metas.ch}{www.metas.ch}}{}}
\renewcommand{\headrulewidth}{0pt}%{0.5pt}
}
\newcommand{\uncsection}{
\section*{Uncertainty of Measurement}
The reported uncertainty of measurement is stated as the combined standard uncertainty multiplied by a coverage factor \emph{k}\,=\,2. The measured value (\emph{y}) and the associated expanded uncertainty (\emph{U}) represent the interval (\emph{y}\,$\pm$\,\emph{U}) which contains the value of the measured quantity with a probability of approximately 95\,\%. The uncertainty was estimated following the guidelines of the ISO (GUM:2008).\\
The measurement uncertainty contains contributions originating from the measurement standard, from the calibration method, from the environmental conditions and from the object being calibrated. The longterm characteristic of the object being calibrated is not included.
}
\endinput
