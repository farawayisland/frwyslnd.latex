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
\ProvidesClass{frwyslnd-cheatsheet}[2026/07/06 The `cheatsheet` class of the
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
%%% `colorscheme`=<string>.
\ExplSyntaxOn
\newcommand*{\@frwyslnd@cheatsheet@colorscheme}{purple}

\NewDocumentCommand{\@process@frwyslnd@cheatsheet@colorscheme}{m}{
  \str_case:nnTF { #1 }
  {
    {pink}{}
    {purple}{}
  }
  {
    \renewcommand*{\@frwyslnd@cheatsheet@colorscheme}{#1}
  }
  {
    \msg_error:nnn { frwyslnd-cheatsheet } { colorscheme~bad~value } { #1 }
  }
}

\msg_new:nnnn { frwyslnd-cheatsheet } { colorscheme~bad~value }
{ Bad~`colorscheme`~option~value:~`#1` }
{
  You~can~only~use~`pink`~or~`purple,~you~used~`#1`
}
\ExplSyntaxOff

\DeclareKeys[frwyslnd-cheatsheet]{
  colorscheme.code  =
  \@process@frwyslnd@cheatsheet@colorscheme{#1},
  colorscheme.usage = load,
}

%%% `columns`=<positive_integer>.
\newcommand*{\@frwyslnd@cheatsheet@columns}{4}
\DeclareKeys[frwyslnd-cheatsheet]{
  columns.code  = \renewcommand*{\@frwyslnd@cheatsheet@columns}{#1},
  columns.usage = load,
}

%% Processing.
\PassOptionsToClass{\@frwyslnd@cheatsheet@baseclass@options}{
  \@frwyslnd@cheatsheet@baseclass
}
\DeclareUnknownKeyHandler{
  \PassOptionsToClass{\CurrentOption}{\@frwyslnd@cheatsheet@baseclass}
}
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
%% Color schemes.
\colorlet{hyperlinkcolor}{%
  \StrCase{\@frwyslnd@cheatsheet@colorscheme}{%
    {pink}{CustomPink01}%
    {purple}{CustomPurple01}%
  }%
}
\colorlet{sectionheadingcolor}{hyperlinkcolor}
\colorlet{titleboxcolorfill}{%
  \StrCase{\@frwyslnd@cheatsheet@colorscheme}{%
    {pink}{CustomPink04}%
    {purple}{CustomPurple06}%
  }%
}

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
%%%% Lengths.
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
  \hspace*{\fill}
  \begin{NiceTabular}{c}[corners]
    \CodeBefore
    \TikzEveryCell{fill=titleboxcolorfill,offset=\titleboxoffset,rounded
    corners=\titleboxroundedcorners}
    \Body
    \Block{}{
      \\[\titleboxsepgeneral]
      \titleformat\@title \\[\titleboxseptitle]
      \authorformat\@author \\[\titleboxsepgeneral]
      \href{\@webpage@url}{\usekomafont{author}{\@webpage}}
      \\[\titleboxsepgeneral]
      {\usekomafont{date}{\@date}} \\[\titleboxsepgeneral]
      {}
    }
  \end{NiceTabular}
  \hspace*{\fill}
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
\RenewDocumentCommand{\tableofcontents}{s}{%
  \pdfbookmark[-1]{\contentsname}{toc}
  \begingroup
  \let\if@dynlist\if@tocleft
  \expandafter\listoftoc\expandafter{\ext@toc}%
  \endgroup
  \IfBooleanTF{#1}{\vspace*{\fill}}{}
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
\definelength{tocnumwidthsubsection}{
  \dimeval{\tocnumwidthsection+0.5\tocnumwidthsection}
}
\definelength{tocnumwidthsubsubsection}{
  \dimeval{\tocnumwidthsubsection+0.5\tocnumwidthsection}
}
\definelength{tocindentpart}{0em}
\definelength{tocindentsection}{\tocindentpart}
\definelength{tocindentsubsection}{
  \dimeval{\tocindentsection+\tocnumwidthsection}
}
\definelength{tocindentsubsubsection}{
  \dimeval{\tocindentsubsection+\tocnumwidthsubsection}
}
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
\definelength{nonpartsectionheadingsepabove}{
  -0.875ex plus -0.25ex minus -0.05ex
}
\definelength{nonpartsectionheadingsepbelow}{0.575ex plus 0.05ex}
\definelength{partheadingsepabove}{1.15ex plus 0.1ex}
\definelength{partheadingsepbelow}{\nonpartsectionheadingsepbelow}
\RedeclareSectionCommand[
  afterskip=\partheadingsepbelow,
  beforeskip=\partheadingsepabove,
]{part}
\RedeclareSectionCommands[
  afterskip=\nonpartsectionheadingsepbelow,
  beforeskip=\nonpartsectionheadingsepabove,
]{paragraph,section,subparagraph,subsection,subsubsection}

%% Document structure.
\AfterEndPreamble{%
\begin{multicols}{\@frwyslnd@cheatsheet@columns}\RaggedRight}
  \AtEndDocument{%
\end{multicols}}

%% Section contents.
%%% Spacing.
\definelength{defaultparindent}{\parindent}
\AfterEndPreamble{\setlength{\parindent}{\defaultparindent}}

\endinput
