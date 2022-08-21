% resume.cls
%
% This file provides the styling for the resume as a whole and defines various
% environments and commands needed to use the formatting provided.
% 
% As of current, this document class is not very configurable as I have no need.
% That may change in the future.
%
% For reference, commands are exported to set author/header information:
% 	\Author
%	\Subtitle
%	\Loc(ation)
%	\Phone
%	\Email
%
% and provides the following environments for use:
% General Sections:
%	Education
%	Coursework (a 2 column tabluarx table; & goes to the second column)
%	Skills 	 (See Coursework)
%	Experience
%	Projects
%	Activities
% 
% Other environments:
%	EdEntry  (a single entry for the education section; requires the title, start and end dates)
%	TitleDescription (a "single title" description environment)
% 	ExpEntry (similar to EdEntry but intended for long-form sub-items)
%
% Please refer to the comments at their definitions below for further details

% --------------------------------------------------------------------Preamble
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[Baricus' resume formatting class]

% --------------------------------------------------------------------Options

% any defined options go here (there currently are none)

% all other options are passed to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% end options section
\ProcessOptions\relax

% load the base class article
\LoadClass[letterpaper]{article}

% --------------------------------------------------------------------Packages
%font setup
\RequirePackage{fontspec}
\setmainfont[Ligatures=TeX]{Garamond}

% page margins
\usepackage[includeheadfoot, top=0.25in, bottom=0.25in, left=0.5in, right=0.5in, headheight=50pt, headsep=8pt, letterpaper]{geometry}

%various other imports
\RequirePackage{fancyhdr}          % headerst
\RequirePackage{xcolor}            % color
\RequirePackage{hyperref}          % hyperlink reference
\RequirePackage{microtype}         % font resizing
\RequirePackage{tabularx}          % for expandable columns
\RequirePackage{enumitem}          % better lists
\RequirePackage{multicol}          % multiple columns
\RequirePackage[compact]{titlesec} % allows setting title spacing

% --------------------------------------------------------------------Formatting
% hyperlink setup to better match standard
\hypersetup{final=true, colorlinks, urlcolor=blue}

%sets up rows for tabular eviornment
\setlength{\extrarowheight}{0pt}
\newcolumntype{E}{>{\raggedleft\arraybackslash}X} % Education columns (left side alignment)
\newcolumntype{Y}{>{\hsize=.11\hsize}X}           % Year columns (fixed size, center aligned)

% tabularX removing spacing
\renewcommand\tabularxcolumn[1]{p{#1}}
\renewcommand*{\arraystretch}{0}

%sets up descriptions to be dense and off the next line
\setlist[description]{topsep=0pt, itemsep=2pt, parsep=0pt, style=nextline}

% vertical spacing setups
% lowes spacing of section headers (left spacing, above, below)
\titlespacing{\section}{0pt}{-10pt plus 0pt minus 2pt}{0pt plus 0pt minus 0pt}
% reduces multicol spacing
\setlength{\multicolsep}{0pt plus 0pt minus 0pt}
% reduces tabularx prespacing
\setlength{\textfloatsep}{0pt}
% removes space before front of lists
\setlength\topsep{0pt}
% lowers seperation between list items
\setlength\itemsep{3pt}

% header setup
% user inputted values
\newcommand{\GivenAuthor}{Author}
\newcommand{\GivenSubtitle}{Subtitle/Expected Subtitle/Oneliner}
\newcommand{\GivenLoc}{Location}
\newcommand{\GivenPhone}{Phone \#}
\newcommand{\GivenEmail}{Email@Address}
\newcommand{\Author}[1]{\renewcommand{\GivenAuthor{#1}}}
\newcommand{\Subtitle}[1]{\renewcommand{\GivenSubtitle{#1}}}
\newcommand{\Loc}[1]{\renewcommand{\GivenLoc{#1}}}
\newcommand{\Phone}[1]{\renewcommand{\GivenPhone{#1}}}
\newcommand{\Email}[1]{\renewcommand{\GivenEmail{#1}}}

%Header defining
\pagestyle{fancy}
\fancyhf{}
\lhead
{
	{\Huge \bf \GivenAuthor}               \\
	{\Large \emph{\GivenSubtitle}}
}
\rhead
{
	\GivenLoc                              \\
	\GivenPhone                            \\
	\href{mailto:\GivenEmail}{\GivenEmail}
}


% ---------------------------------------------------------------------------Custom environments
% simple environments for the start/end of various sections
% These is largely just a section header and a flush left for formatting
\newenvironment{Education} %
{                          %
	\section*{Education}   %
	\flushleft             % ensures tables work by forcing alignment
}{                         %
	\endflushleft          %
}

\newenvironment{Experience} %
{                           %
	\section*{Experience}   %
	\flushleft              %
}{                          %
	\endflushleft           %
}

% Activites are formatted into a multicolumn setup without anything fancy

\newenvironment{Activities}          %
{                                    %
	\section*{Additional Activities} %
	\begin{center}                   %
		\begin{multicols}{2}         %
			\begin{description}      %
}{                                   %
			\end{description}        %
		\end{multicols}              %
	\end{center}                     %
}

% The following three environments use tabularx to fix things into a two column format
% which is fully controllable
% Thus, to swap between the columns, the & is used as if it was a normal tabularx environment

\newenvironment{Coursework}        %
{                                  %
	\section*{Relevant Coursework} %
	\flushleft                     %
	\tabularx{\textwidth}[c]{X X}  %
}{                                 %
	\endtabularx                   %
	\endflushleft                  %
}

\newenvironment{Projects}         %
{                                 %
	\section*{Projects}           %
	\flushleft                    %
	\tabularx{\textwidth}[c]{X X} %
}{                                %
	\endtabularx                  %
	\endflushleft                 %
}

\newenvironment{Skills}           %
{                                 %
	\section*{Skills}             %
	\flushleft                    %
	\tabularx{\textwidth}[c]{X X} %
}{                                %
	\endtabularx                  %
	\endflushleft                 %
}

% TitleDescription - a "single title" description
% Takes in a title to wrap in square quotes on the first call to \item,
% rebinding \item to work transparently with this as if there was genuinely a title
%
% Arguments: {Description Title}

\newenvironment{TitleDescription}[1]                    %
{                                                       %
	\begin{description}                                 %
		\item [#1]                                      %
		\let\realitem\item                              % rebind \item for first usage in environment
		\renewcommand{\item}[1]{\let\item\realitem ##1} % after first usage, reset it to normal
}{                                                      %
	\end{description}                                   %
}

%EdEntry - Formats a single "school"
%
% Arguments: {School Name}
%			 {Starting Month + Year}
%			 {Ending Month + Year}
%
% Uses \item for each line of description regarding the school.
% 
% NOTE: Due to tabularx, this doesn't seem like it can be nested in further \newenvironment commands
%       Furthermore, environments can't span table cells so we have one table per entry

\newenvironment{EdEntry}[3]                 %
{                                           %
	\newcommand{\DateLine}{#2 \\ to \\ #3}  % stores the date since args aren't present at end
	\tabularx{\textwidth}[c]{E Y}           % fixed width date column
		\begin{multicols}{2}                % 2 columns for education description
			\begin{TitleDescription}{#1}    %
}{                                          %
			\end{TitleDescription}          %
		\end{multicols}                     %
		&                                   % swaps to the date column
		\begin{center}\DateLine\end{center} %
		\\                                  %
	\endtabularx                            %
}

% ExpEntry - formats one experience/job
%
% Arguments: {Position Title}
%			 {Starting Month + Year}
%			 {Ending Month + Year}
%
% Uses \item for each line of description
%
% Very similar to EdEntry, minus the multicols
\newenvironment{ExpEntry}[3]               %
{                                          %
	\newcommand{\DateLine}{#2 \\ to \\ #3} %
	\tabularx{\textwidth}[c]{E Y}          %
		\begin{TitleDescription}{#1}       %
}{                                         %
		\end{TitleDescription}             %
	&                                      % swaps to the date column
	\begin{center} \DateLine \end{center}  %
	\\                                     %
	\endtabularx                           %
}
