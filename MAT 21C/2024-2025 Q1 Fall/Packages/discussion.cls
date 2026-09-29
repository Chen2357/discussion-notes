\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{discussion}[2024/09/25 Discussion class for MAT 21C]

\LoadClass[11pt,letterpaper]{article}

\RequirePackage[margin=1in]{geometry}

\RequirePackage{amssymb, amsthm, amsmath}
\RequirePackage{mleftright}
\mleftright

\RequirePackage{titlesec}
\titleformat{\section}{\normalfont\Large\bfseries}{\@seccntformat{section}}{0em}{}
% \titleclass{\section}{top}
% \titlespacing{\section}{0pt}{-25pt}{10pt}

%% \discussion{number}
\newcommand{\discussion}[1]{\title{MAT 021C Discussion #1}}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\setlength{\headheight}{14.49998pt}
\fancyhead[L]{\@author}
\fancyhead[C]{\@title}
\fancyhead[R]{\@date}

\fancypagestyle{plain}{
    \fancyhead[L]{\@date}
    \fancyhead[C]{\@title}
    \fancyhead[R]{\@author}
}

\theoremstyle{definition}
%% \begin{question}
\newtheorem{question}{Question}[]

\RequirePackage{enumitem}
%% \begin{subquestion}
\newlist{subquestion}{enumerate}{2}
\setlist[subquestion,1]{label=\textbf{(\alph*)}, ref=(\alph*)}
\setlist[subquestion,2]{label=\textbf{(\roman*)}, ref=(\alph{subquestioni}.\roman*)}
\AtBeginDocument{
    \@ifpackageloaded{cleveref}{
        \crefalias{subquestioni}{part}
        \crefalias{subquestionii}{part}
    }{}
}

\PassOptionsToPackage{italic}{derivative}

\AtBeginDocument{
    \@ifpackageloaded{hyperref}{
        \hypersetup{
            colorlinks=true,
            linkcolor=teal,
            urlcolor=teal,
        }
    }{}

    \@ifpackageloaded{interval}{
        \intervalconfig{soft open fences}
    }{}
}