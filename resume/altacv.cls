% REQUIRMENTS AND DEFINITIONS ###################################################
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}
\ProvidesClass{altacv}[2018/12/01 AltaCV v1.1.5, yet another alternative class for a résumé/curriculum vitae.]

% Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
% Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}

% added for convenience
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi


\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
\RequirePackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
\RequirePackage{afterpage}
% \RequirePackage{marginfix}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlength{\parindent}{0pt}


% NEW ENVIRONMENTS ##############################################################
\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}
\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}


% NEW COMMANDS ###################################################################
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}


% define symbol
\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}
% for adding your own symbols
% Used for normal text
\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{\normalfont #1}\hspace{0.5em}#2\hspace{2em}}}
% Used for URLS's the url goes first, then the text
\newcommand{\printinfourl}[3]{\mbox{\textcolor{accent}{\normalfont {#1}}\hspace{0.5em}\href{#2}{#3}\hspace{2em}}}

% Further definitions of info things
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[2]{\printinfourl{\emailsymbol}{#1}{#2}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\printinfo{\phonesymbol}{#1}}
\newcommand{\homepage}[2]{\printinfourl{\homepagesymbol}{#1}{#2}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[2]{\printinfourl{\linkedinsymbol}{#1}{#2}}
\newcommand{\github}[2]{\printinfourl{\githubsymbol}{#1}{#2}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}



% Define Header
% MESS WITH THE 8 and the photodiameter-8em and kern 15pc to center photo
\newcommand{\makecvheader}{%
  \begingroup
    \ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter-11em}}{}
    \raggedright\color{emphasis}
    {\Huge\bfseries\MakeUppercase{\@name}\par}
    \smallskip
    {\large\bfseries\color{accent}\@tagline\par}
    \medskip
    {\footnotesize\bfseries\@personalinfo\par}
    \ifdef{\@photodiameter}{
    \end{minipage}\hfill
    \begin{minipage}{\@photodiameter}
    \includegraphics[scale=0.7]{coop_logo.png}
    % \tikz\path[fill overzoom image={\@photo}]circle[radius=0.3];
    \end{minipage}\kern 15pc \par}{}
  \endgroup
}


% CV section
\newcommand{\cvsection}[2][]{
  \bigskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{heading}\LARGE\bfseries\MakeUppercase{#2}}\\[-1ex]
  {\color{heading}\rule{\linewidth}{2pt}\par}\medskip
}


% CV subsection
\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\bfseries{#1}\par}\medskip
}


% CV Event
\newcommand{\cvevent}[4]{
  \textbf{\large\color{emphasis}#1}\par
  % \smallskip\normalsize
  \ifstrequal{#2}{}{}{{\color{accent}#2}\par\smallskip}
  \ifstrequal{#3}{}{}{{\small\makebox[0.5\linewidth][l]{\faCalendar\hspace{0.5em}#3}}}
  \ifstrequal{#4}{}{}{{\small\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#4}}}\par
  \smallskip\normalsize
}


% Cv Achievement
\newcommand{\cvachievement}[3]{%
  \begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
  \multirow{2}{*}{\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2}\\
  & #3
  \end{tabularx}%
  \smallskip
}


% CV Tag
% give a skill to put in a rounded buble
\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}


% CV Skill
% give a skill and then how many lil dots
\newcommand{\cvskill}[2]{%
\textcolor{emphasis}{\textbf{#1}}\hfill
\foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{accent}}\ratingmarker}}\par%
}


% Cv Ref
\newcommand{\cvref}[3]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.35em]
  \item[\normalfont\emailsymbol] #2
  \item[\small\normalfont\mailsymbol] #3
  \end{description}
%   \medskip
}


% make it easier to add a sidebar aligned with top of next page
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}
