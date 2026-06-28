% ──────────────────────────────────────────────────────────────────────────────
% SPDX-FileCopyrightText: 2026 farawayisland
% SPDX-License-Identifier: GPL-3.0-or-later
% ──────────────────────────────────────────────────────────────────────────────
%
% This file is part of the "`frwyslnd` bundle". The development version of
% the bundle can be found at
%
%   https://codeberg.org/farawayisland/frwyslnd.latex
%   https://github.com/farawayisland/frwyslnd.latex
%
% for those people who are interested.
%
% ──────────────────────────────────────────────────────────────────────────────
\NeedsTeXFormat{LaTeX2e}[2026-06-01]
\ProvidesClass{frwyslnd-cheatsheet}[2026/06/29 The `cheatsheet` class of the
`frwyslnd` bundle]

% ENGINE
%% The `frwyslnd` bundle strictly requires LuaTeX as the author does not intend
%% to write checks for other TeX engines.

% BASE CLASS
\newcommand*{\@frwyslnd@cheatsheet@baseclass}{scrartcl}
\newcommand*{\@frwyslnd@cheatsheet@baseclass@options}{
  10pt,
  BCOR=0mm,
  headings=optiontoheadandtoc,
  headings=standardclasses,
  numbers=endperiod,
  oneside,
}

% OPTIONS
%% Declarations.
%%% `columns`=<positive_integer>.
\newcommand*{\@frwyslnd@cheatsheet@columns}{4}
\DeclareKeys[frwyslnd-cheatsheet]{
  columns.code  = \renewcommand*{\@frwyslnd@cheatsheet@columns}{#1},
  columns.usage = load,
}

%% Processing.
\PassOptionsToClass{\@frwyslnd@cheatsheet@baseclass@options}{\@frwyslnd@cheatsheet@baseclass}
\DeclareUnknownKeyHandler{\PassOptionsToClass{\CurrentOption}{\@frwyslnd@cheatsheet@baseclass}}
\ProcessKeyOptions

% DEPENDENCIES
%% `scrartcl`: KOMA-Script 'article' class.
\LoadClass{\@frwyslnd@cheatsheet@baseclass}

%% `frwyslnd-math`: The `math` package of the `frwyslnd` bundle.
\RequirePackage{frwyslnd-math}

%% `geometry`: Flexible and complete interface to document dimensions.
\RequirePackage[a4paper,landscape]{geometry}

%% `multicol`: Intermix single and multiple columns.
\RequirePackage{multicol}

% CONFIGURATIONS
%% `geometry`.
\geometry{
  bottom=1cm,
  headheight=0pt,
  headsep=0pt,
  hmarginratio={1:1},
  left=1cm,
  top=1cm,
}

%% `hyperref`
\colorlet{hyperlinkcolor}{CustomPink01}
\AtEndPreamble{
  \hypersetup{
    filecolor=hyperlinkcolor,
    linkcolor=hyperlinkcolor,
    pdfauthor={\@author@unformatted},
    pdfkeywords={\@keywords},
    pdfsubject={\@subject},
    pdftitle={\@title@unformatted},
    urlcolor=hyperlinkcolor,
  }
}

%% `bookmark`
\AtEndPreamble{
  \bookmarksetup{
    addtohook={%
      \ifnum\bookmarkget{level}<2%
      \bookmarksetup{bold}%
      \fi
    },
    numbered,
    open,
  }
}

%% Title box.
%%% Format configurations.
%%%% Colors and lengths.
\colorlet{titleboxcolorfill}{CustomPink03}
\definelength{titleboxoffset}{3pt}
\definelength{titleboxroundedcorners}{5pt}
\definelength{titleboxtabcolsep}{2em}

%%%% Entries.
%%%%% Private.
\newcommand*{\@author@unformatted}{}
\newcommand*{\authorunformatted}[1]{\renewcommand*{\@author@unformatted}{#1}}
\newcommand*{\@title@unformatted}{}
\newcommand*{\titleunformatted}[1]{\renewcommand*{\@title@unformatted}{#1}}
\newcommand*{\@webpage}{}
\newcommand*{\@webpage@url}{}
\newcommand*{\webpage}[2]{
  \renewcommand*{\@webpage@url}{#1}
  \renewcommand*{\@webpage}{#2}
}

%%%% Public.
\newcommand*{\theauthor}{\@author}
\newcommand*{\thedate}{\@date}
\newcommand*{\thetitle}{\@title@unformatted}
\newcommand*{\thewebpage}{\@webpage}
\newcommand*{\thewebpageurl}{\@webpage@url}

%%%% Custom \newlineinauthor and \newlineintitle macros.
\NewDocumentCommand{\newlineinauthor}{O{1ex}}{\\[#1]\authorformat}
\NewDocumentCommand{\newlineintitle}{O{1ex}}{\\[#1]\titleformat}

%%%% Custom \author and \title redefinitions.
\NewCommandCopy{\oldauthor}{\author}
\NewCommandCopy{\oldtitle}{\title}
\RenewDocumentCommand{\author}{m}{
  \oldauthor{\replaceall{#1}{;}{\newlineinauthor}}
  \authorunformatted{#1}
}
\NewCommandCopy{\authors}{\author}
\RenewDocumentCommand{\title}{m}{\oldtitle{\replaceall{#1}{;}{\newlineintitle}}}

%%% Font configurations.
\newcommand*{\authorformat}{\large}
\setkomafont{author}{\authorformat}
\setkomafont{date}{\large}
\newcommand*{\titleformat}{\Large\bfseries}
\setkomafont{title}{\titleformat}

%%% Structure.
\renewcommand{\maketitle}{%
  \begingroup
  \definelength{titleboxsepgeneral}{1.5ex}
  \definelength{titleboxseptitle}{2.25ex}
  \setlength{\tabcolsep}{\titleboxtabcolsep}
  \centering
  \begin{NiceTabular}{c}[corners]
    \CodeBefore
    \TikzEveryCell{fill=titleboxcolorfill,offset=\titleboxoffset,rounded
    corners=\titleboxroundedcorners}
    \Body
    \Block{}{
      \\[\titleboxsepgeneral]
      \titleformat\@title \\[\titleboxseptitle]
      \authorformat\@author \\[\titleboxsepgeneral]
      \href{\@webpage@url}{\usekomafont{author}{\texttt{\@webpage}}}
      \\[\titleboxsepgeneral]
      {\usekomafont{date}{\@date}} \\[\titleboxsepgeneral]
      {}
    }
  \end{NiceTabular}
  \endgroup
  \bigskip
}

%% Additional document information.
%%% Private.
\newcommand*{\@keywords}{}
\newcommand*{\keywords}[1]{\renewcommand*{\@keywords}{#1}}

%%% Public.
\newcommand*{\thekeywords}{\@keywords}
\newcommand*{\thesubject}{\@subject}

%% Table of contents.
%% Structure.
\renewcommand{\tableofcontents}{%
  \pdfbookmark[-1]{\contentsname}{toc}
  \begingroup
  \let\if@dynlist\if@tocleft
  \expandafter\listoftoc\expandafter{\ext@toc}%
  \endgroup
  \bigskip
}

%%% Indentation of entries.
\RedeclareSectionCommand[tocindent=0em]{section}
\RedeclareSectionCommand[tocindent=1.5em]{subsection}

%%% Entry styles.
\CloneTOCEntryStyle{subsection}{subsubsection}

%%% Format configurations of entries.
%%%% Source:
%%%% https://tex.stackexchange.com/a/510236
\newcommand*{\dotlessentrynumberformatpart}[1]{\partname~\def\autodot{}#1}
\DeclareTOCStyleEntry[
  entrynumberformat=\dotlessentrynumberformatpart,
]{part}{part}

%%% Font configurations of entries.
\DeclareTOCStyleEntry[
  entryformat=\small\bfseries,
  linefill=\hfill,
  pagenumberformat=\small\bfseries,
]{part}{part}
\DeclareTOCStyleEntry[
  entryformat=\footnotesize\bfseries,
  linefill=\hfill,
  pagenumberformat=\footnotesize,
]{section}{section}
\DeclareTOCStyleEntry[
  entryformat=\footnotesize,
  linefill=\hfill,
  pagenumberformat=\footnotesize,
]{subsection}{subsection}
\DeclareTOCStyleEntry[
  entryformat=\footnotesize,
  linefill=\hfill,
  pagenumberformat=\footnotesize,
]{subsubsection}{subsubsection}

%%% Page numbering of entries.
\newcommand*{\emptypagenumberbox}[1]{}
\DeclareTOCStyleEntry[
  pagenumberbox=\emptypagenumberbox,
]{part}{part}

%%% Spacing of entries.
\definelength{tocnumwidthpart}{3.75em}
\definelength{tocnumwidthsection}{1.25em}
\definelength{tocnumwidthsubsection}{\dimexpr\tocnumwidthsection+0.5\tocnumwidthsection\relax}
\definelength{tocnumwidthsubsubsection}{\dimexpr\tocnumwidthsubsection+0.5\tocnumwidthsection\relax}
\definelength{tocindentpart}{0em}
\definelength{tocindentsection}{\tocindentpart}
\definelength{tocindentsubsection}{\dimexpr\tocindentsection+\tocnumwidthsection\relax}
\definelength{tocindentsubsubsection}{\dimexpr\tocindentsubsection+\tocnumwidthsubsection\relax}
\definelength{tocsepabove}{1ex}

\CloneTOCEntryStyle{subsection}{subsubsection}
\DeclareTOCStyleEntry[
  beforeskip=\tocsepabove,
  indent=\tocindentpart,
  numwidth=\tocnumwidthpart,
]{part}{part}
\DeclareTOCStyleEntry[
  beforeskip=\tocsepabove,
  indent=\tocindentsection,
  numwidth=\tocnumwidthsection,
]{section}{section}
\DeclareTOCStyleEntry[
  beforeskip=\tocsepabove,
  indent=\tocindentsubsection,
  numwidth=\tocnumwidthsubsection,
]{subsection}{subsection}
\DeclareTOCStyleEntry[
  beforeskip=\tocsepabove,
  indent=\tocindentsubsubsection,
  numwidth=\tocnumwidthsubsubsection,
]{subsubsection}{subsubsection}

%%% Spacing of leaders.
\renewcommand*{\@dotsep}{2.5}

%% Page styles.
\pagestyle{empty}

%% Section headings.
%%% Format configurations.
%%%% Source:
%%%% https://tex.stackexchange.com/a/102305
\colorlet{sectionheadingcolor}{hyperlinkcolor}
\renewcommand*{\partformat}{\color{sectionheadingcolor}\large\partname~\thepart}

%%% Font configurations.
%%%% \contentsname uses `section` font styling in `scrartcl`.
\setkomafont{part}{\color{sectionheadingcolor}\Large}
\setkomafont{section}{\color{sectionheadingcolor}\large}
\setkomafont{subsection}{\color{sectionheadingcolor}\normalsize}
\setkomafont{subsubsection}{\color{sectionheadingcolor}\normalsize}
\setkomafont{paragraph}{\color{sectionheadingcolor}\normalsize}
\setkomafont{subparagraph}{\color{sectionheadingcolor}\normalsize}

%%% Spacing.
\definelength{sectionheadingsepabove}{-0.875ex plus -0.25ex minus -0.05ex}
\definelength{sectionheadingsepbelow}{0.575ex plus 0.05ex}
\RedeclareSectionCommands[
  afterskip=\sectionheadingsepbelow,
  beforeskip=\sectionheadingsepabove,
]{paragraph,part,section,subparagraph,subsection,subsubsection}

%% Section contents.
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt plus 0.5ex}

%% Document structure.
\AfterEndPreamble{%
\begin{multicols}{\@frwyslnd@cheatsheet@columns}\raggedright}
  \AtEndDocument{%
\end{multicols}}

\endinput
