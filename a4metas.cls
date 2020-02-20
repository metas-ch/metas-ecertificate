\ProvidesClass{a4metas}[2013/01/07 V0.3 Metas a4]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,11pt]{article}

\usepackage{geometry}
\setlength{\headheight}{25mm}
\setlength{\headsep}{9mm}
\setlength{\footskip}{9mm} 
\geometry{left=30mm, right=15mm, top=45mm, bottom=28mm}
\usepackage[T1]{fontenc}
\usepackage[scaled]{uarial}
\renewcommand*\familydefault{\sfdefault}
\usepackage{ifthen}
\usepackage{graphicx}
\usepackage{lastpage}
\usepackage{fancyhdr}

\fancypagestyle{fancytitle}{%
\fancyhead[L]{\ifthenelse{\equal{\@clogo}{1}}{\hspace{-10mm}\vtop{\vskip-1ex\hbox{\includegraphics{CDBund2.pdf}}}\vspace{11.68pt}\newline{}}{}}
\fancyhead[C]{}
\fancyhead[R]{}
\fancyfoot[L]{\fontsize{7.5pt}{9.5pt}\selectfont{}This document may not be published or forwarded other than in full.\ifthenelse{\equal{\@clogo}{1}}{\newline{}\newline{}\textbf{METAS}\newline{}Lindenweg 50, 3003 Bern-Wabern, Switzerland, phone +41 58 387 01 11, www.metas.ch}{}}
\fancyfoot[C]{}
\fancyfoot[R]{\fontsize{7.5pt}{9.5pt}\selectfont{}\thepage{}/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
}

\pagestyle{fancy}
\fancyhead[L]{\ifthenelse{\equal{\@clogo}{1}}{\hspace{-10mm}\vtop{\vskip-1ex\hbox{\includegraphics{CDBund2.pdf}}}\vspace{11.68pt}\newline{}}{}\fontsize{12pt}{14pt}\selectfont{}\textbf{\@cinfo{}}}
\fancyhead[C]{}
\fancyhead[R]{}
\fancyfoot[L]{\fontsize{7.5pt}{9.5pt}\selectfont{}This document may not be published or forwarded other than in full.\ifthenelse{\equal{\@clogo}{1}}{\newline{}\newline{}\textbf{METAS}\newline{}Lindenweg 50, 3003 Bern-Wabern, Switzerland, phone +41 58 387 01 11, www.metas.ch}{}}
\fancyfoot[C]{}
\fancyfoot[R]{\fontsize{7.5pt}{9.5pt}\selectfont{}\thepage{}/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0pt}

\newcommand{\clogo}[1]{\def\@clogo{#1}}
\newcommand{\cinfo}[1]{\def\@cinfo{#1}}

\let\maketitletemp\maketitle
\renewcommand{\maketitle}{
\maketitletemp
\thispagestyle{fancytitle}

\fancyhead[L]{\ifthenelse{\equal{\@clogo}{1}}{\hspace{-10mm}\vtop{\vskip-1ex\hbox{\includegraphics{CDBund2.pdf}}}\vspace{11.68pt}\newline{}}{}\fontsize{12pt}{14pt}\selectfont{}\textbf{\@cinfo{}}}
\renewcommand{\headrulewidth}{0.5pt}

}