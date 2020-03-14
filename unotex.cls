%%
%% Customizações do abnTeX2 (https://www.abntex.net.br/)
%% para a Universidade Federal da Fronteira Sul (UFFS).
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is the ccuffs team.
%%
%% This work consists of the file uffstex.cls.
%%
%% Further information about abnTeX2 is available on https://www.abntex.net.br/.
%% Further information about ccuffs is available on https://ccuffs.github.io/.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unotex}[2018/12/01 v0.10.5]

% ==============================================================================
% Carregando pacotes necessários
% ==============================================================================
\RequirePackage{xparse}
\RequirePackage{xpatch}
\RequirePackage{nomencl}
\RequirePackage{graphicx}

\usepackage{threeparttable}%
\usepackage{lipsum}
\RequirePackage{lastpage}
\RequirePackage{textcase}
% pacote indentfirst certifica que sempre haverá
% identação de parágrafo na 1a linha de um novo parágrafo
\RequirePackage{indentfirst}

% ==============================================================================
% Opções padrão para o abntex2
% ==============================================================================
% para controlar onde um capítulo pode iniciar: openleft, openright, openany
% para indicar impressão apenas em anverso ou anverso e verso: oneside, twoside
\PassOptionsToClass{
    12pt,
    a4paper,
    openright,
    twoside,
    brazil,
    chapter=TITLE, % capitaliza títulos primários no texto
    section=TITLE % capitaliza títulos secundários no texto
}{abntex2}

% ==============================================================================
% Declaração das opções da classe
% ==============================================================================

% \AtEndOfClass é utilizado para adiar a execução
% do código até o final do processamento desta classe
% pois o comando \ABNTEXchapterfont é definido pelo
% abntex2, a qual não está carregada neste momento
%
% opção "serif" para redefinir o estilo dos variados
% títulos do abntex2 com família de fontes serifadas
\DeclareOption{serif}{
    \AtEndOfClass{\renewcommand{\ABNTEXchapterfont}{\rmfamily\bfseries}}
}

% \DeclareOption* lida com os comandos não explicitamente
% especificados nesta classe e então os repassa para a
% classe abntex2
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{abntex2}
}

\ProcessOptions\relax

\LoadClass{abntex2}

% ==============================================================================
% "Constantes"
% ==============================================================================
\providecommand*{\algoritmoext}{loalg}
\providecommand*{\equacaoext}{loequa}

% ==============================================================================
% Patches
% ==============================================================================
% patch pra deixar seções em caixa alta no sumário
% (cortesia de Lars Andersen, da classe Memoir)
\xpatchcmd{\H@old@sectm@m}{\fi#7}{%
    \fi\ifnum#2=1\relax\texorpdfstring{\MakeTextUppercase{#7}}{#7}\else#7\fi%
}{%
    \ClassInfo{uffstex}{patch para seções secundárias em caixa alta no
    sumário aplicado com sucesso}%
}{%
    \ClassWarning{uffstex}{patch para seções secundárias em caixa alta no
    sumário falhou}%
}

% patch para deixar apenas o número da página no cabeçalho
\xpatchcmd{\textual}{\pagestyle{abntheadings}}{\pagestyle{simple}}{%
  \ClassInfo{uffstex}{patch para cabeçalho simples de página
  aplicado com sucesso}%
}{%
  \ClassWarning{uffstex}{patch para cabeçalho simples de página falhou}%
}

% ==============================================================================
% Configurações de tamanhos e comprimentos
% ==============================================================================
% tamanho da indentação de novo parágrafo
\setlength{\parindent}{1.25cm}

% espaçamento entre títulos e texto (até seção quinária)
\setlength{\afterchapskip}{\baselineskip}
\setlength{\aftersecskip}{\baselineskip}
\setlength{\aftersubsecskip}{\baselineskip}
\setlength{\aftersubsubsecskip}{\baselineskip}
% (abnTeX2 define \subsubsubsection como \paragraph)
\setlength{\afterparaskip}{\baselineskip}

% remove espaço vertical que antecede uma seção primária no sumário
\setlength{\cftbeforechapterskip}{0cm}

% ==============================================================================
% Localização
% ==============================================================================
% português do Brasil
% por mais que especifiquemos "brazilian" como opção global,
% o abntex2 passa a opção "brazil" pro babel...
\addto\captionsbrazil{
  \providecommand*{\campusname}{campus de}
  \providecommand*{\cursoname}{curso de}
  \renewcommand*{\coorientadorname}{Coorientador}
  \providecommand*{\bacharelname}{Bacharel}
  \providecommand*{\licenciaturaname}{Licenciatura}
  \providecommand*{\bancaname}{banca avaliadora}
  \providecommand*{\declaracaoaprovacao}{Este trabalho de conclus\~ao de curso
    foi defendido e aprovado pela \bancaname\ em:}
  \providecommand*{\algoritmoname}{Algoritmo}
  \providecommand*{\equacaoname}{Equa\c{c}\~ao}
  \providecommand*{\listalgoritmoname}{Lista de \algoritmoname{}s}
  \providecommand*{\listequacoesnome}{Lista de Equa\c{c}\~oes}
  \providecommand*{\cipfolhas}{f}
  \providecommand*{\cipiii}{T\'itulo}
  \providecommand*{\notacopia}{Todos os direitos autorais reservados
  a \imprimirautor. A reprodu\c{c}\~ao de partes ou do todo deste trabalho s\'o
  poder\'a ser feita mediante a cita\c{c}\~ao da fonte.}
  % abntex2 já utiliza 'anexoname' e 'anexosname'...
  \providecommand*{\annexname}{Anexo}
  \providecommand*{\annexesname}{Anexos}
}

% ==============================================================================
% Comandos de dados
% ==============================================================================
% Versões com * das definições de comandos são recomendadas
% quando os parâmetros não são parágrafos inteiros
\newcommand*{\uffstex}{UFFS\TeX}

\providecommand*{\hoje}{\the\year-\the\month-\the\day}

\newcommand*{\imprimircampusRotulo}{\campusname}

\providecommand*{\imprimirgrau}{\bacharelname}
\providecommand*{\licenciatura}{\renewcommand*{\imprimirgrau}{\licenciaturaname}}
\newcommand*{\grau}[1]{\renewcommand*{\imprimirgrau}{#1}}

\newcommand*{\imprimircursoRotulo}{\cursoname}
\providecommand*{\imprimircurso}{}
\newcommand*{\curso}[1]{\renewcommand*{\imprimircurso}{#1}}

\providecommand*{\imprimirsubtitulo}{}
\newcommand*{\subtitulo}[1]{\renewcommand*{\imprimirsubtitulo}{#1}}
\providecommand*{\imprimirunochapeco}{\unochapeco}

\ExplSyntaxOn
\regex_const:Nn \g__dados_divnome_regex {(?:(.+)\ )?(.+)}
\cs_new_protected:Npn \dados_divnome:NNn #1#2#3
{
    \regex_extract_once:NnN \g__dados_divnome_regex {#3} \l_tmpa_rslt
    \seq_pop_right:NN \l_tmpa_rslt #2
    \seq_pop_right:NN \l_tmpa_rslt #1
    % se não há sobrenome na entrada, #1 está vazia e o nome foi parar em #2
    \ifthenelse{\equal{#1}{} \and \not\equal{#2}{}}
    {
        % então seta #1 = #2 e depois limpa #2
        \tl_gset_eq:NN #1 #2
        \tl_gclear:N #2
    }{}
}

\RenewDocumentCommand \autor { m }
{
    \author{#1}
    \dados_divnome:NNn\autorinicio\autorultnome{#1}
}


\RenewDocumentCommand \coorientador { O{\coorientadorname} m }
{
    \RenewDocumentCommand \imprimircoorientadorRotulo{}{#1:}
    \RenewDocumentCommand \imprimircoorientador{}{#2}
    \dados_divnome:NNn\coorientadorinicio\coorientadorultnome{#2}
}
\ExplSyntaxOff

\providecommand*{\imprimircidade}{}
\ProvideDocumentCommand \cidade { m }
{
    \renewcommand*{\imprimircidade}{#1}
}

\providecommand*{\imprimiruf}{}
\ProvideDocumentCommand \uf { m }
{
    \renewcommand*{\imprimiruf}{#1}
}

% =======================================
% Palavras-chave (funcionalidade baseada na classe mdtuffs)
% =======================================
\ExplSyntaxOn
\tl_const:Nn \c_kw_csprefix_tl {palavrach}
\int_const:Nn \c_kw_max_int {5}
\int_zero_new:N \g_kw_count_int

\cs_new:Npn \kw_add:n #1
{
    \cs_new:cpn {\c_kw_csprefix_tl\int_to_alph:n{\g_kw_count_int}} {#1}
}

\NewDocumentCommand \palavrachave { m }
{
    \int_compare:nTF {\g_kw_count_int < \c_kw_max_int}
    {
        \int_incr:N \g_kw_count_int
        \kw_add:n {#1}
    }
    {
        \ClassWarning{uffstex}{Voc\^e~excedeu~o~limite~de~
        \int_to_arabic:n {\c_kw_max_int}~palavras-chave.~Apenas~
        \int_to_arabic:n {\c_kw_max_int}~ser\~ao~exibidas}
    }
}

\NewDocumentCommand \imprimirpc { m }
{
    \int_compare:nTF {1 <= #1 <= \c_kw_max_int}
    {
        \use:c {\c_kw_csprefix_tl\int_to_alph:n{#1}}
    }
    {
        \ClassError{uffstex}{Palavra-chave~#1~n\~ao~existe}
            {Verifique~o~n\'umero~que~voc\^e~passou~como~par\^ametro~
            para~o~comando~\imprimirpc~e~quantas~palavras-chave~voc\^e~definiu.}
    }
}

\NewDocumentCommand \imprimirpcs { s O{\@.} }
{
    \int_zero_new:N \l_kw_count_int
    \int_while_do:nn {\l_kw_count_int < \g_kw_count_int}
    {
        \int_incr:N \l_kw_count_int
        % se usar comando com *, enumera as palavras-chave
        \IfBooleanT{#1}{\int_to_arabic:n {\l_kw_count_int}.\nobreakspace}
        \imprimirpc{\l_kw_count_int}#2

        % se o contador ainda é menor que o valor máximo, coloca um espaço
        % (ou seja, coloca um espaço entre as palavras-chave)
        \int_compare:nTF {\l_kw_count_int < \c_kw_max_int}{~}{}
    }
}
\ExplSyntaxOff

% ==============================================================================
% Fontes padrões dos títulos até seção quinária (texto e sumário)
% ==============================================================================
% controle de caixa alta é feito aparte
% capítulo no texto (negrito e caixa alta)
\renewcommand{\ABNTEXchapterfont}{\sffamily\bfseries}
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}
% capítulo no sumário
\renewcommand{\cftchapterfont}{\ABNTEXchapterfont}
\renewcommand{\cftchapterpagefont}{\cftchapterfont}

% seção no texto (normal e caixa alta)
\renewcommand{\ABNTEXsectionfont}{\ABNTEXchapterfont\mdseries}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}
% seção no sumário
\renewcommand{\cftsectionfont}{\ABNTEXsectionfont}
\renewcommand{\cftsectionpagefont}{\cftsectionfont}

% subseção no texto (negrito e caixa baixa; reutiliza fonte do capítulo)
\renewcommand{\ABNTEXsubsectionfont}{\ABNTEXchapterfont}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}
% subseção no sumário
\renewcommand{\cftsubsectionfont}{\ABNTEXsubsectionfont}
\renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

% sub-subseção no texto (normal e caixa baixa; reutiliza fonte da seção)
\renewcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsectionfont}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}
% sub-subseção no sumário
\renewcommand{\cftsubsubsectionfont}{\ABNTEXsubsubsectionfont}
\renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

% sub-sub-subseção no texto (itálico e caixa baixa; reutiliza fonte da seção)
\renewcommand{\ABNTEXsubsubsubsectionfont}{\ABNTEXsectionfont\itshape}
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}
% sub-sub-subseção no sumário
\renewcommand{\cftparagraphfont}{\ABNTEXsubsubsubsectionfont}
\renewcommand{\cftparagraphpagefont}{\cftparagraphfont}

% ==============================================================================
% Capa
% ==============================================================================
\renewcommand{\imprimircapa}{
    \begin{capa}
        \centering
        \ABNTEXchapterfont

        % a logo deveria ser 20mm x 20mm, mas
        % daí vai distorcer... colocando só
        % altura, o LaTeX escala a largura
        \includegraphics[height=15mm]{img/logo_unochapeco.png}
        
        \vspace{0.3cm}
        
        
        %\vspace{\baselineskip}

        \textbf{\MakeTextUppercase{\imprimirinstituicao}\\}
        \textbf{\MakeTextUppercase{\area}\\}
        \textbf{\MakeTextUppercase{\imprimircursoRotulo\ \imprimircurso}\\}
        \textbf{\MakeTextUppercase{(\textmd{\tipocurso})}\\}

        \vspace{4.5cm}

        \textbf{\MakeTextUppercase{\imprimirtitulo}}
        \abntex@ifnotempty{\imprimirsubtitulo}{
            \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
        }

        \vspace{3.5cm}

        \textbf{\MakeTextUppercase{\imprimirautor}}

        \vspace{\fill}

        \textbf{\MakeTextUppercase{\dataemeseano}}
        \vspace{1cm}
    \end{capa}
}

% ==============================================================================
% Folha de rosto
% ==============================================================================
\renewcommand{\folhaderostocontent}{
    \centering
    \ABNTEXchapterfont
    
    \vspace{1cm}
    
    \textbf{\MakeTextUppercase{\imprimirinstituicao}\\}
    \textbf{\MakeTextUppercase{Área de ciências exatas e ambientais}\\}
    \textbf{\MakeTextUppercase{\imprimircursoRotulo\ \imprimircurso}\\}
    \textbf{\MakeTextUppercase{(Bacharelado)}\\}

    \vspace{6.5cm}

    \textbf{\MakeTextUppercase{\imprimirtitulo}}
    \abntex@ifnotempty{\imprimirsubtitulo}{
        \\\textmd{\MakeTextUppercase{\imprimirsubtitulo}}
    }

    \vspace{3cm}

    \abntex@ifnotempty{\preambulo}{
        \hspace*{7cm}
        \begin{minipage}{0.5\textwidth}
            \bfseries
            % \footnotesize
            \SingleSpacing

            \preambulo
        \end{minipage}
    }

    \vspace{1cm}
    
    \textbf{\MakeTextUppercase{\imprimirautor}}
    
    \vspace{1cm}

    {
        \hspace*{7cm}
        \begin{minipage}{0.5\textwidth}
            \mdseries
            % \footnotesize
            \SingleSpacing

            Orientador: \textmd{\nomeorientador}
            \hspace*{2.3cm}\textmd{\tituloorientador}
        \end{minipage}
    }

    \vfill

    \textbf{\MakeTextUppercase{\dataemeseano}}
    \vspace{0,5cm}
}

% ==============================================================================
% Ficha catalográfica (funcionalidade baseada na classe mdtuffs)
% ==============================================================================
\ProvideDocumentEnvironment{cip}{}
{\thispagestyle{empty}\begin{SingleSpace}}
{\end{SingleSpace}}

\ProvideDocumentCommand
\imprimircip{ o }{
    \imprimircipframe
    \IfValueT{#1}{
        \vspace{4ex}
        \nominata{#1}
    }
    \clearpage%
}

\ProvideDocumentCommand \nominata{ m }{
\begin{SingleSpace}
    \hrule
    \vspace{6pt}
    \noindent\copyright\ \the\year\\
    \noindent\notacopia\\
    \noindent E-mail: {#1}
\end{SingleSpace}
}

% ==============================================================================
% Folha de aprovação
% ==============================================================================
% o regulamento de TCC de CC exige pelo menos 3 membros pra banca
% (orientador e mais dois). Este comando, portanto, exige dois membros
% (o orientador é impresso automaticamente) e suporta mais dois opcionais,
% totalizando 5 membros. O coorientador não é impresso automaticamente pois
% o manual de elaboração de TCC quer a sigla da instituição após o nome
% abaixo da linha da assinatura e o coorientador não é obrigado a ser da UFFS.
% O primeiro parâmetro, opcional, é a data da defesa.
% O valor padrão para a data de defesa é a data configurada no documento com
% a macro \data.
\ProvideDocumentCommand
\imprimirfolhadeaprovacao{}{
\begin{folhadeaprovacao}
    \OnehalfSpacing
    \begin{center}
        \ABNTEXchapterfont%

        \MakeTextUppercase{\imprimirtitulo}

        \vspace{\baselineskip}

        \MakeTextUppercase{\imprimirautor}

        \vspace{\baselineskip}

        \MakeTextUppercase{ESTE RELATÓRIO, DO TRABALHO DE CONCLUSÃO DE CURSO, FOI JULGADO ADEQUADO PARA OBTENÇÃO DO TÍTULO DE:}\\
        \vspace{1cm}
        \MakeTextUppercase{\titulodoautor}
        
        \vspace{3\baselineskip}

        \textmd{\nomeorientador, \tituloorientador}\\
        Orientador\\
    \end{center}

    \vspace{2\baselineskip}
    \noindent
    \textbf{BANCA EXAMINADORA:}\\
   
    \vspace{3\baselineskip}

    \noindent
    \begin{minipage}{0.5\textwidth}
        \mdseries
        \SingleSpacing
        \centering

        \textmd{\nomebancaum}, \textmd{\titulobancaum}\\
        \textbf{Membro da banca}
    \end{minipage}
    \hfill
    \begin{minipage}{0.5\textwidth}
        \mdseries
        \SingleSpacing
        \centering

        \textmd{\nomebancadois}, \textmd{\titulobancadois}\\
        \textbf{Membro da banca}
    \end{minipage}\\

    \vspace{3\baselineskip}
    \noindent
    \begin{minipage}{0.5\textwidth}
        \mdseries
        \SingleSpacing
        \centering

        \textmd{\nomesupervisor}, \textmd{\titulosupervisor}\\
        \textbf{Supervisor de TCC}
    \end{minipage}
    \hfill
    \begin{minipage}{0.5\textwidth}
        
            \mdseries
            % \footnotesize
            \SingleSpacing
            \centering

            \textmd{\nomecoord}, \textmd{\titulocoord}\\
            \textbf{Coordenadora de Curso}
    \end{minipage}

    \vfill
    \center{
        \textmd{\dataediaemeseano}
    }
    
    \vspace{0,5cm}
    
\end{folhadeaprovacao}
}

% MACROS 

\newcommand{\eq}[4]{%
\begin{equacao}[#1]
  \caption{#2}
  \label{eq:#3}
  \begin{align*}
     #4
  \end{align*}
\end{equacao}
}

\newcommand{\fig}[6]{%
\begin{figure}[#6]
  \caption{#1}
  \label{fig:#2}
  \captionsetup{singlelinecheck = false, format= hang, labelformat=empty, justification=raggedright, font=footnotesize, labelsep=space, labelfont=bf}
  \centering
  \begin{measuredfigure}
    \includegraphics[#3]{#4}
    \caption*{Fonte: #5}
  \end{measuredfigure}
\end{figure}
}

\newcommand{\tabela}[6]{%
\begin{table}[h]
  \centering
  \tiny
  \caption{#2}%
  \label{tab:#6}
  \captionsetup{singlelinecheck = false, format= hang, labelformat=empty, justification=raggedright, font=footnotesize, labelsep=space}
  % @{} remove o espaço nas laterais.
  
  \begin{measuredfigure}
    % \captionsetup{labelformat=empty}
    
    % \caption{"Fonte: "}{Chuck Jones – Pepe Le Pew in action}
  
    \begin{tabular}{#1}
     #3
    \end{tabular}
    \caption*{Fonte: #4}
    \abntex@ifnotempty{#5}{
        \nota{#5}
    }
      
  
  \end{measuredfigure}
  % Etiqueta para referenciar o elemento no texto.
\end{table}
}




% ==============================================================================
% Ambiente `algoritmo` e definição da lista de algoritmos
% ==============================================================================
\newfloat{algoritmo}{\algoritmoext}{\algoritmoname}

\newlistof{listofalgoritmos}{\algoritmoext}{\listalgoritmoname}
\newlistentry{algoritmo}{\algoritmoext}{0}
\renewcommand*{\cftalgoritmoname}{\algoritmoname\space}
\renewcommand*{\cftalgoritmoaftersnum}{\hfill\textendash\hfill}

\AtBeginDocument{
    \@ifpackageloaded{cleveref}{
        % \crefname é definido automaticamente com \MakeLowercase do \Crefname
        \Crefname{algoritmo}{\algoritmoname}{\algoritmoname{}s}
        \Crefname{anexo}{\annexname}{\annexesname}

        \if@cref@capitalise%
            \crefname{algoritmo}{\algoritmoname}{\algoritmoname{}s}%
        \fi%
    }{}
    \@ifpackageloaded{datetime2}{
        \renewcommand*{\imprimirdata}{\DTMdate{\thedate}}
    }{}
}

% ==============================================================================
% Ambiente `equação` e definição da lista de equações
% ==============================================================================
\newfloat{equacao}{\equacaoext}{\equacaoname}

\newlistof{listofequations}{\equacaoext}{\listequacoesnome}
\newlistentry{equacao}{\equacaoext}{0}
\renewcommand*{\cftequacaoname}{\equacaoname\space}
\renewcommand*{\cftequacaoaftersnum}{\hfill\textendash\hfill}

\AtBeginDocument{
    \@ifpackageloaded{cleveref}{
        % \crefname é definido automaticamente com \MakeLowercase do \Crefname
        \Crefname{equacao}{\equacaoname}{\equacaoname{}s}
        \Crefname{anexo}{\annexname}{\annexesname}

        \if@cref@capitalise%
            \crefname{equacao}{\equacaoname}{\equacaoname{}s}%
        \fi%
    }{}
    \@ifpackageloaded{datetime2}{
        \renewcommand*{\imprimirdata}{\DTMdate{\thedate}}
    }{}
}

% ==============================================================================
% Correção do título da seção das referências
% ==============================================================================
\AtBeginDocument{
  \@ifpackageloaded{biblatex}{
    % definição do título baseada no abnTeX2
    % (https://github.com/abntex/abntex2/blob/master/tex/latex/abntex2/abntex2.cls#L537,
    % que por sua vez é baseada na definição
    % padrão do Memoir), mas utilizando o
    % comando \defbibheading como recomendado
    % pela documentação do BibLaTeX quando
    % ele for carregado
    \defbibheading{abnt}[\refname]{
      \chapter*{#1}
      \bibmark
      \ifmemoirbibintoc{ % front-end do BibLaTeX
        \phantomsection
        \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{#1}}{#1}}
      }{}
      \prebibhook
    }
  }{}
}

% Novo list of (listings) para QUADROS

\newcommand{\quadroname}{Quadro}
\newcommand{\listofquadrosname}{Lista de quadros}

\newfloat[chapter]{quadro}{loq}{\quadroname}
\newlistof{listofquadros}{loq}{\listofquadrosname}
\newlistentry{quadro}{loq}{0}

\AtBeginDocument{
    \@ifpackageloaded{cleveref}{
        % \crefname é definido automaticamente com \MakeLowercase do \Crefname
        \Crefname{quadro}{\quadroname}{\quadroname{}s}
        \Crefname{anexo}{\annexname}{\annexesname}

        \if@cref@capitalise%
            \crefname{quadro}{\quadroname}{\quadroname{}s}%
        \fi%
    }{}
    \@ifpackageloaded{datetime2}{
        \renewcommand*{\imprimirdata}{\DTMdate{\thedate}}
    }{}
}

% configurações para atender às regras da ABNT
\setfloatadjustment{quadro}{\centering}
\counterwithout{quadro}{chapter}
\renewcommand{\cftquadroname}{\quadroname\space} 
\renewcommand*{\cftquadroaftersnum}{\hfill--\hfill}

% Configuração de posicionamento padrão:
\setfloatlocations{quadro}{H}

\ProvideDocumentCommand \nominata{ m }{
\begin{SingleSpace}
    \hrule
    \vspace{6pt}
    \noindent\copyright\ \the\year\\
    \noindent\notacopia\\
    \noindent E-mail: {#1}
\end{SingleSpace}
}
