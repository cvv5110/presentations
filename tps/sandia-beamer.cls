\ProvidesClass{sandia-beamer}

% Make our output messages more easily searched
\newcommand{\SAND@typeout}[1]{\typeout{Class sandia-beamer: #1}}

\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{xkeyval}
\PassOptionsToPackage{x11names}{xcolor}
\RequirePackage{tikz}
\RequirePackage{calc}
\RequirePackage{xspace}
\RequirePackage{datetime}
\RequirePackage[normalem]{ulem}
\RequirePackage[T1]{fontenc}

\newtoggle{sandiabeamer@flag@CUI}

% set defaults for light theme and NM location
\newcommand\sandiabeamer@UX@SNLlogo{assets/snl-white.png}
\newcommand\sandiabeamer@UX@DOElogo{assets/doe-color.png}
\newcommand\sandiabeamer@UX@NNSAlogo{assets/nnsa-color.png}
\newcommand\sandiabeamer@UX@textfg{black}

\newcommand\sandiabeamer@img@aerial{assets/NM2.png}
\newcommand\sandiabeamer@img@cross{assets/meeting.png}
\newcommand\sandiabeamer@img@left{assets/fire.png}
\newcommand\sandiabeamer@img@center{assets/desk.png}
\newcommand\sandiabeamer@img@right{assets/b61.png}
\newcommand\sandiabeamer@img@sectionbg{assets/nm-blend.png}

\define@boolkeys[sandiabeamer]{UX}[sandiabeamer@UX@]{titledate,slidenumber}[true]
\define@boolkeys[sandiabeamer]{UX}[sandiabeamer@UX@]{slidedate}[false]

%THEME choices
%   Dark/Light/Angles
\newtoggle{sandiabeamer@flag@lighttheme}
\newtoggle{sandiabeamer@flag@darktheme}
\newtoggle{sandiabeamer@flag@anglestheme}
\define@choicekey*[sandiabeamer]{UX}{theme}[\sandiabeamer@UX@theme@val\nr]{light,dark,angles}[angles]{%
  \ifcase\nr%\sandiabeamer@UX@theme
  % light
  \renewcommand\sandiabeamer@UX@SNLlogo{assets/snl-white.png}
  \renewcommand\sandiabeamer@UX@DOElogo{assets/doe-color.png}
  \renewcommand\sandiabeamer@UX@NNSAlogo{assets/nnsa-color.png}
  \renewcommand\sandiabeamer@UX@textfg{black}
  \toggletrue{sandiabeamer@flag@lighttheme}
  \togglefalse{sandiabeamer@flag@darktheme} % to avoid false positives from presetkeys
  \or
  % dark
  \renewcommand\sandiabeamer@UX@SNLlogo{assets/snl-white.png}
  \renewcommand\sandiabeamer@UX@DOElogo{assets/doe-white.png}
  \renewcommand\sandiabeamer@UX@NNSAlogo{assets/nnsa-white.png}
  \renewcommand\sandiabeamer@UX@textfg{white}
  \toggletrue{sandiabeamer@flag@darktheme}
  \togglefalse{sandiabeamer@flag@lighttheme} % to avoid false positives from presetkeys
  \or
  %angles
  \renewcommand\sandiabeamer@UX@textfg{black}
  \renewcommand\sandiabeamer@UX@SNLlogo{assets/snl-white.png}
  \renewcommand\sandiabeamer@UX@DOElogo{assets/doe-black.png}
  \renewcommand\sandiabeamer@UX@NNSAlogo{assets/NNSA_Logo_Black.jpg}
  \toggletrue{sandiabeamer@flag@anglestheme}
  \togglefalse{sandiabeamer@flag@darktheme} % to avoid false positives from presetkeys
  \togglefalse{sandiabeamer@flag@lighttheme} % to avoid false positives from presetkeys
  \fi
}

%FONT choices:
%   `strictfont`
%       Gillius[Gill Sans MT](sans for headers and titles) with EB-Garamond (serif for body text)
%   `relaxedfont`
%       Helvetica (sans for headers and titles) with Times (serif for body text)
%   `sansfont`
%       Gillius[Gill Sans MT](sans for everything)
%
\newtoggle{sandiabeamer@flag@strictfont}
\newtoggle{sandiabeamer@flag@relaxedfont}
\newtoggle{sandiabeamer@flag@sansfont}
\newcommand\sandiabeamer@fonttheme{sansSandia}
\define@choicekey*[sandiabeamer]{UX}{font}[\sandiabeamer@UX@font@val\nr]{sansfont,strictfont,relaxedfont}[relaxedfont]{%
  \ifcase\nr %\sandiabeamer@UX@font
      % sans font (all sans)
      \toggletrue{sandiabeamer@flag@sansfont}
      \togglefalse{sandiabeamer@flag@relaxedfont}
      \togglefalse{sandiabeamer@flag@strictfont}
      \renewcommand\sandiabeamer@fonttheme{sansSandia}
      \SAND@typeout{setting sans font (sans-serif Gillius, Gill Sans-like)}
  \or
      % (nearly) strict font (sans Gillius (Gill Sans-like) and EB-Garamond serif, with ebgaramond-maths for math fonts)
      \toggletrue{sandiabeamer@flag@strictfont}
      \togglefalse{sandiabeamer@flag@relaxedfont}
      \togglefalse{sandiabeamer@flag@sansfont}
      \renewcommand\sandiabeamer@fonttheme{serifSandia}
      \SAND@typeout{setting strict font (sans-serif Gillius (Gill Sans-like)/serif EB-Garamond / math ebgaramond-maths)}
  \or
      % relaxed font (sans Helvetica and Times serif and math-ptmx math fonts)
      \toggletrue{sandiabeamer@flag@relaxedfont}
      \togglefalse{sandiabeamer@flag@strictfont}
      \togglefalse{sandiabeamer@flag@sansfont}
      \renewcommand\sandiabeamer@fonttheme{serifSandia}
      \SAND@typeout{setting strict font (sans-serif Helvetica/serif Times/ math math-ptmx)}
  \fi
}

\iftoggle{sandiabeamer@flag@strictfont}{%
    \RequirePackage{gillius}
    \usepackage[cmintegrals,cmbraces]{newtxmath}
    \usepackage{ebgaramond-maths}}{}
\iftoggle{sandiabeamer@flag@relaxedfont}{%
    \RequirePackage{helvet} 
    \RequirePackage{times}
    \RequirePackage{mathptmx}}{}

\newtoggle{sandiabeamer@flag@NM}
\newtoggle{sandiabeamer@flag@CA}
\define@choicekey*[sandiabeamer]{UX}{location}[\sandiabeamer@UX@location@val\nr]{NM,CA}[NM]{%
  \ifcase\nr
  % NM
  \renewcommand\sandiabeamer@img@aerial{assets/NM2.png}
  \renewcommand\sandiabeamer@img@cross{assets/meeting.png}
  \renewcommand\sandiabeamer@img@left{assets/fire.png}
  \renewcommand\sandiabeamer@img@center{assets/desk.png}
  \renewcommand\sandiabeamer@img@right{assets/b61.png}
  \renewcommand\sandiabeamer@img@sectionbg{assets/nm-blend.png}
  \toggletrue{sandiabeamer@flag@NM}
  \togglefalse{sandiabeamer@flag@CA}
  \SAND@typeout{setting NM}
  \or
  % CA
  \renewcommand\sandiabeamer@img@aerial{assets/CA.png}
  \renewcommand\sandiabeamer@img@cross{assets/ca-w80.png}
  \renewcommand\sandiabeamer@img@left{assets/ca-l.png}
  \renewcommand\sandiabeamer@img@center{assets/ca-m.png}
  \renewcommand\sandiabeamer@img@right{assets/ca-r.png}
  \renewcommand\sandiabeamer@img@sectionbg{assets/ca-blend.png}
  \toggletrue{sandiabeamer@flag@CA}
  \togglefalse{sandiabeamer@flag@NM}
  \SAND@typeout{setting CA}
  \fi
}

\presetkeys[sandiabeamer]{UX}{slidedate,titledate,slidenumber}{}

\define@cmdkey[sandiabeamer]{SAND}{number}[none]{}
\define@cmdkey[sandiabeamer]{SAND}{CUIstring}[none]{}


%
% scaffolding for the CUI markings
%
% markings.tex has most of the literal text definitions, to make it a little bit easier to
% maintain both them and this logic. In order, we do:
% - include the markings here
% - define toggles that can be set by the choice keys
% - define the choice keys
% - set other options up
% - call ProcessOptionsX to actually run the options and set the toggles
% - branch through the toggles to figure out what markings to activate for the beamer theme
% this takes us down through the "end of marking definitions" comment below

\input{markings.tex}

\newtoggle{SAND@UUR}
\newtoggle{SAND@CUI}
\newtoggle{SAND@CUI@CUI}
\newtoggle{SAND@CUI@UCNI}

\newtoggle{SAND@CAVEAT@ECDOE}
\newtoggle{SAND@CAVEAT@CRADA}
\newtoggle{SAND@CAVEAT@ECEAR}
\newtoggle{SAND@CAVEAT@ECITAR}
\newtoggle{SAND@CAVEAT@PATENT}

\newtoggle{SAND@CLASS}
\newtoggle{SAND@CLASS@CONFIDENTIAL}
\newtoggle{SAND@CLASS@SECRET}
\newtoggle{SAND@CLASS@TOPSECRET}
\newtoggle{SAND@CLASS@NSI}
\newtoggle{SAND@CLASS@FRD}
\newtoggle{SAND@CLASS@RD}
\newtoggle{SAND@CLASS@NF}
\newtoggle{SAND@CLASS@S15}

\newtoggle{SAND@CUIorCLASS}

\DeclareOptionX[sandiabeamer]<SAND>{UUR}{\toggletrue{SAND@UUR}}

\define@choicekey*[sandiabeamer]{SAND}{CUI}[\val\nr]{no,none,CUI,UCNI}[CUI]{%
  \SAND@typeout{Unclassified sensitivity: \val}
  \ifcase\nr\togglefalse{SAND@CUI}\toggletrue{SAND@UUR}\togglefalse{sandiabeamer@flag@CUI}
  \or\togglefalse{SAND@CUI}\toggletrue{SAND@UUR}\togglefalse{sandiabeamer@flag@CUI}
  \or\toggletrue{SAND@CUI}\toggletrue{sandiabeamer@flag@CUI}\toggletrue{SAND@CUI@CUI}
  \or\toggletrue{SAND@CUI}\toggletrue{sandiabeamer@flag@CUI}\toggletrue{SAND@CUI@UCNI}
  \else\togglefalse{SAND@CUI}\togglefalse{sandiabeamer@flag@CUI}
  \fi
}

\define@choicekey*[sandiabeamer]{SAND}{CAVEAT}[\val\nr]{no,none,ECDOE,CRADA,ECEAR,ECITAR,PATENT}[none]{%
  \SAND@typeout{Distribution CAVEAT: \val}
  \ifcase\nr\relax %no
  \or\relax %none
  \or\toggletrue{SAND@CAVEAT@ECDOE}
  \or\toggletrue{SAND@CAVEAT@CRADA}
  \or\toggletrue{SAND@CAVEAT@ECEAR}
  \or\toggletrue{SAND@CAVEAT@ECITAR}
  \or\toggletrue{SAND@CAVEAT@PATENT}
  \fi
}

\define@choicekey*[sandiabeamer]{SAND}{ClassLevel}[\val\nr]{U,C,S,TS}[U]{%
  \ifcase\nr\relax % U
  \or\toggletrue{SAND@CLASS}\toggletrue{SAND@CLASS@CONFIDENTIAL}
  \or\toggletrue{SAND@CLASS}\toggletrue{SAND@CLASS@SECRET}
  \or\toggletrue{SAND@CLASS}\toggletrue{SAND@CLASS@TOPSECRET}
  \else\togglefalse{SAND@CLASS}
  \fi
}

\define@choicekey*[sandiabeamer]{SAND}{ClassCat}[\val\nr]{U,NSI,FRD,RD}[U]{%
  \ifcase\nr
  \togglefalse{SAND@CLASS@NSI}
  \or\toggletrue{SAND@CLASS@NSI}
  \or\toggletrue{SAND@CLASS@FRD}
  \or\toggletrue{SAND@CLASS@RD}
  \fi
}

\define@choicekey*[sandiabeamer]{SAND}{ClassCaveat}[\val\nr]{none,NF,S15}[none]{%
  \ifcase\nr
  \togglefalse{SAND@CLASS@NF}
  \or\toggletrue{SAND@CLASS@NF}
  \or\toggletrue{SAND@CLASS@S15}
  \fi
}


\DeclareOptionX[sandiabeamer]<UX>{NM}{\setkeys[sandiabeamer]{UX}{location=NM}}
\DeclareOptionX[sandiabeamer]<UX>{CA}{\setkeys[sandiabeamer]{UX}{location=CA}}
\DeclareOptionX[sandiabeamer]<UX>{relaxedfont}{\setkeys[sandiabeamer]{UX}{font=relaxedfont}}
\DeclareOptionX[sandiabeamer]<UX>{sansfont}{\setkeys[sandiabeamer]{UX}{font=sansfont}}
\DeclareOptionX[sandiabeamer]<UX>{strictfont}{\setkeys[sandiabeamer]{UX}{font=strictfont}}
%\DeclareOptionX[sandiabeamer]<UX>{light}{\setkeys[sandiabeamer]{UX}{theme=light}}
%\DeclareOptionX[sandiabeamer]<UX>{dark}{\setkeys[sandiabeamer]{UX}{theme=dark}}
%\DeclareOptionX[sandiabeamer]<UX>{angles}{\setkeys[sandiabeamer]{UX}{theme=angles}}
\DeclareOptionX*{\ClassWarning{sandia-beamer}{'\CurrentOption' ignored}}

\ProcessOptionsX*[sandiabeamer]<SAND,UX>\relax

\iftoggle{SAND@CUI}{\toggletrue{SAND@CUIorCLASS}}{}
\iftoggle{SAND@CLASS}{\toggletrue{SAND@CUIorCLASS}}{}

% Determine which "admonishment" boxes to apply to the cover page
% \newtoggle{SAND@CAVEAT@ECDOE}
% \newtoggle{SAND@CAVEAT@CRADA}
% \newtoggle{SAND@CAVEAT@ECEAR}
% \newtoggle{SAND@CAVEAT@ECITAR}
% \newtoggle{SAND@CAVEAT@PATENT}

% This is not the most efficient "programming" practice here, since
% we'll always do a few comparisons that could be short-circuited (all of the
% options are mutually exclusive). I'm doing it this way for
% readability since LaTeX makes an if-then cascade kind of ugly, and I'd
% rather optimize for maintainability vs. compile time.
\newcommand\sandiabeamer@UCNI@whichBox{}
\newcommand\sandiabeamer@CUI@whichBonusBox{}
\newcommand\sandiabeamer@CUI@whichExtraBox{}
\newcommand{\sandiabeamer@ClassWhichDCBox}{}
\newcommand{\sandiabeamer@ClassWhichWarningBox}{}
\newcommand{\sandiabeamer@ClassWhichExtraBox}{}
\newcommand{\SAND@mark@headfoot}{\relax}

\iftoggle{SAND@CUI@CUI}{
  \renewcommand{\SAND@mark@headfoot}{\SAND@mark@CUI}
  % three possibilities for an extra box 
  \iftoggle{SAND@CAVEAT@ECDOE}{
    \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\SAND@mark@CAVEAT@ECDOEextraBox}}
  }{}
  \iftoggle{SAND@CAVEAT@CRADA}{
    \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\SAND@mark@CAVEAT@CRADAextraBox}}
  }{}
  \iftoggle{SAND@CAVEAT@PATENT}{
    \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\SAND@mark@CAVEAT@PATENTextraBox}}
  }{}
  \iftoggle{SAND@CAVEAT@ECEAR}{
    \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\SAND@mark@CAVEAT@ECEARextraBox}}
  }{}
  \iftoggle{SAND@CAVEAT@ECITAR}{
    \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\SAND@mark@CAVEAT@ITARextraBox}}
  }{}
%
}{} % CUI

\iftoggle{SAND@CUI@UCNI}{
  \renewcommand{\sandiabeamer@CUI@whichExtraBox}{\sandiabeamer@makeCUIextraBox{\sandiabeamer@UCNIbox}}
  \renewcommand{\SAND@mark@headfoot}{\SAND@mark@CUI}
  \iftoggle{SAND@CAVEAT@ECDOE}{
    \renewcommand{\sandiabeamer@CUI@whichBonusBox}{\sandiabeamer@makeUCNIbonusBox{\SAND@mark@UCNI@CAVEAT@DOEbottomBox}}
  }{}
  \iftoggle{SAND@CAVEAT@CRADA}{
    \renewcommand{\sandiabeamer@CUI@whichBonusBox}{\sandiabeamer@makeUCNIbonusBox{\SAND@mark@UCNI@CAVEAT@CRADAbottomBox}}
  }{}
  \iftoggle{SAND@CAVEAT@PATENT}{
    \renewcommand{\sandiabeamer@CUI@whichBonusBox}{\sandiabeamer@makeUCNIbonusBox{\SAND@mark@UCNI@CAVEAT@PATENTbottomBox}}
  }{}
  \iftoggle{SAND@CAVEAT@ECEAR}{
    \renewcommand{\sandiabeamer@CUI@whichBonusBox}{\sandiabeamer@makeUCNIbonusBox{\SAND@mark@UCNI@CAVEAT@EARbottomBox}}
  }{}
  \iftoggle{SAND@CAVEAT@ECITAR}{
    \renewcommand{\sandiabeamer@CUI@whichBonusBox}{\sandiabeamer@makeUCNIbonusBox{\SAND@mark@UCNI@CAVEAT@ITARbottomBox}}
  }{}%
} % UCNI

\iftoggle{SAND@CLASS@CONFIDENTIAL}{
	\renewcommand{\SAND@mark@headfoot}{CONFIDENTIAL}
}{}
\iftoggle{SAND@CLASS@SECRET}{
	\renewcommand{\SAND@mark@headfoot}{SECRET}
}{}
\iftoggle{SAND@CLASS@TOPSECRET}{
	\renewcommand{\SAND@mark@headfoot}{TOP SECRET}
}{}

\iftoggle{SAND@CLASS@NSI}{
    \renewcommand{\sandiabeamer@ClassWhichWarningBox}{\sandiabeamer@makeClassWarningBoxEmpty}
}{}

\iftoggle{SAND@CLASS@FRD}{
  \let\classlevelhead\SAND@mark@headfoot
	\renewcommand{\SAND@mark@headfoot}{\classlevelhead{} FORMERLY RESTRICTED DATA}
    \renewcommand{\sandiabeamer@ClassWhichWarningBox}{\sandiabeamer@makeClassWarningBox{\SAND@mark@Class@WarningFRD}}
}{}
\iftoggle{SAND@CLASS@RD}{
	\let\classlevelhead\SAND@mark@headfoot
	\renewcommand{\SAND@mark@headfoot}{\classlevelhead{} RESTRICTED DATA}
    \renewcommand{\sandiabeamer@ClassWhichWarningBox}{\sandiabeamer@makeClassWarningBox{\SAND@mark@Class@WarningRD}}
}{}

\iftoggle{SAND@CLASS}{
    \renewcommand{\sandiabeamer@ClassWhichDCBox}{\makeClassDCBox}
}{}

\iftoggle{SAND@CLASS@NF}{
	\let\classhead\SAND@mark@headfoot
	\renewcommand{\SAND@mark@headfoot}{\classhead{} // NOFORN}
    \renewcommand{\SANDClassWhichExtraBox}{\sandiabeamer@makeClassExtraBox{No Foreign Dissemination}}
}{}
\iftoggle{SAND@CLASS@S15}{
	\let\classhead\SAND@mark@headfoot
	\renewcommand{\SAND@mark@headfoot}{\classhead{} // SIGMA 15}
    \renewcommand{\SANDClassWhichExtraBox}{\sandiabeamer@makeClassExtraBox{SIGMA 15}}
}{}

\newcommand{\SANDThirdPartyProprietary}[1]{
  \newcommand{\SAND@mark@thirdPartyProprietaryName}{#1}
}

%%
%%
%% end of marking definitions
%%
%%%%%%%%%%%%%%


%
%
% now we can actually load beamer
%
%
\LoadClass[t,aspectratio=169]{beamer}

\ClassInfo{sandia-beamer}{location is \sandiabeamer@UX@location@val}
\ClassInfo{sandia-beamer}{theme is \sandiabeamer@UX@theme@val}

\AtBeginDocument{
  \providecommand\tikzexternaldisable{\relax}
  \providecommand\tikzexternalenable{\relax}
}

\newcommand\sandiabeamer@UURmark{UNCLASSIFIED UNLIMITED RELEASE}
\newcommand\sandiabeamer@text@SANDphrase{%
	\ifthenelse{\equal{\cmdsandiabeamer@SAND@number}{none}}
	{}
	{SAND NO. \cmdsandiabeamer@SAND@number}%
}

%
% Macros for text that users might want to redefine or relax away
% Don't use @ in names so they can mention these in their documents
\newcommand\sandiabeamerPresentedBy{Presented by:}


\mode<presentation>
{
    \iftoggle{sandiabeamer@flag@anglestheme}{
      \usetheme{Angles}
    }{
      \usetheme{Sandia}
    }
}

