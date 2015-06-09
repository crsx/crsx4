parser grammar CrsxMetaParser;

options {
    tokenVocab = CrsxMetaLexer;
}

@header {
import org.crsx.pg.SinkAntlrListener;
import static org.crsx.pg.SinkAntlrListener.fireEnterZOM;
import static org.crsx.pg.SinkAntlrListener.fireExitZOM;
import static org.crsx.pg.SinkAntlrListener.fireEnterOPT;
import static org.crsx.pg.SinkAntlrListener.fireExitOPT;
import static org.crsx.pg.SinkAntlrListener.fireEnterAlt;
import static org.crsx.pg.SinkAntlrListener.fireExitAlt;
import static org.crsx.pg.SinkAntlrListener.fireHide;
import static org.crsx.pg.SinkAntlrListener.fireTail;
import static org.crsx.pg.SinkAntlrListener.fireTerm;
import static org.crsx.pg.SinkAntlrListener.fireEmbed;
}

@parser::members {
public CrsxMetaParser() {}
protected Lexer newLexer(CharStream stream)
{

return new CrsxMetaLexer(stream);
}

protected void initATN()
{    _interp = new ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
}protected String _prefix() { return "Crsx_"; }
protected void _enterZOM() { fireEnterZOM(_parseListeners, _ctx); }
protected void _exitZOM()  { fireExitZOM(_parseListeners, _ctx); }
protected void _enterOOM() { _enterZOM(); }
protected void _exitOOM()  { _exitZOM(); }
protected void _enterOPT() { fireEnterOPT(_parseListeners, _ctx); }
protected void _exitOPT()  { fireExitOPT(_parseListeners, _ctx); }
protected void _enterAlt(String name) { fireEnterAlt(_parseListeners, _ctx, name); }
protected void _enterAlt() { fireEnterAlt(_parseListeners, _ctx); }
protected void _exitAlt()  { fireExitAlt(_parseListeners, _ctx); }
protected void _hide()     { fireHide(_parseListeners, _ctx); }
protected void _embed()    { fireEmbed(_parseListeners, _ctx); }
protected void _tail()     { fireTail(_parseListeners, _ctx); }
protected void _term()     { fireTerm(_parseListeners, _ctx); }
}

crsx
:
    {_enterAlt();}

    declarations
    {_exitAlt();}

    |
    {_term();}

    MT_crsx
    |
    {_embed();}

    ET_crsx EMBED_END
;

crsx_EOF
:
    crsx EOF
;

declarations
:
    {_enterAlt();}

    declaration declarations_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_declarations
    |
    {_embed();}

    ET_declarations EMBED_END
;

declarations_EOF
:
    declarations EOF
;

declarations_S1_ZOM
:
    {}

    {_enterZOM();}

    declarations_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_declarations_S1_ZOM
            |
            {_embed();}

            ET_declarations_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_declarations_S1_ZOM
    |
    {_embed();}

    ET_declarations_S1_ZOM EMBED_END
;

declarations_S1_ZOM_EOF
:
    declarations_S1_ZOM EOF
;

declarations_S1
:
    {_enterAlt();}

    semi_TOK declaration_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_declarations_S1
    |
    {_embed();}

    ET_declarations_S1 EMBED_END
;

declarations_S1_EOF
:
    declarations_S1 EOF
;

semi_TOK
:
    {}

    SEMI
    {}

    |
    {_term();}

    MT_semi_TOK
    |
    {_embed();}

    ET_semi_TOK EMBED_END
;

semi_TOK_EOF
:
    semi_TOK EOF
;

declaration_OPT
:
    {}

    {_enterOPT();}

    declaration?
    (
        {_tail();}

        (
            {_term();}

            MT_declaration_OPT
            |
            {_embed();}

            ET_declaration_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_declaration_OPT
    |
    {_embed();}

    ET_declaration_OPT EMBED_END
;

declaration_OPT_EOF
:
    declaration_OPT EOF
;

declaration
:
    {_enterAlt("1");}

    moduleDeclaration
    {_exitAlt();}

    |
    {_enterAlt("2");}

    ruleDeclaration
    {_exitAlt();}

    |
    {_enterAlt("3");}

    sortDeclaration
    {_exitAlt();}

    |
    {_enterAlt("4");}

    directive
    {_exitAlt();}

    |
    {_term();}

    MT_declaration
    |
    {_embed();}

    ET_declaration EMBED_END
;

declaration_EOF
:
    declaration EOF
;

moduleDeclaration
:
    {_enterAlt();}

    module_TOK constructor_TOK lbrace_TOK declarations rbrace_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_moduleDeclaration
    |
    {_embed();}

    ET_moduleDeclaration EMBED_END
;

moduleDeclaration_EOF
:
    moduleDeclaration EOF
;

module_TOK
:
    {}

    MODULE
    {}

    |
    {_term();}

    MT_module_TOK
    |
    {_embed();}

    ET_module_TOK EMBED_END
;

module_TOK_EOF
:
    module_TOK EOF
;

constructor_TOK
:
    {}

    CONSTRUCTOR
    {}

    |
    {_term();}

    MT_constructor_TOK
    |
    {_embed();}

    ET_constructor_TOK EMBED_END
;

constructor_TOK_EOF
:
    constructor_TOK EOF
;

lbrace_TOK
:
    {}

    LBRACE
    {}

    |
    {_term();}

    MT_lbrace_TOK
    |
    {_embed();}

    ET_lbrace_TOK EMBED_END
;

lbrace_TOK_EOF
:
    lbrace_TOK EOF
;

rbrace_TOK
:
    {}

    RBRACE
    {}

    |
    {_term();}

    MT_rbrace_TOK
    |
    {_embed();}

    ET_rbrace_TOK EMBED_END
;

rbrace_TOK_EOF
:
    rbrace_TOK EOF
;

ruleDeclaration
:
    {_enterAlt();}

    option_OPT pattern arrow_TOK contractum
    {_exitAlt();}

    |
    {_term();}

    MT_ruleDeclaration
    |
    {_embed();}

    ET_ruleDeclaration EMBED_END
;

ruleDeclaration_EOF
:
    ruleDeclaration EOF
;

option_OPT
:
    {}

    {_enterOPT();}

    option?
    (
        {_tail();}

        (
            {_term();}

            MT_option_OPT
            |
            {_embed();}

            ET_option_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_option_OPT
    |
    {_embed();}

    ET_option_OPT EMBED_END
;

option_OPT_EOF
:
    option_OPT EOF
;

arrow_TOK
:
    {}

    ARROW
    {}

    |
    {_term();}

    MT_arrow_TOK
    |
    {_embed();}

    ET_arrow_TOK EMBED_END
;

arrow_TOK_EOF
:
    arrow_TOK EOF
;

option
:
    {_enterAlt("1");}

    constructor arguments_OPT colon_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    annotations
    {_exitAlt();}

    |
    {_term();}

    MT_option
    |
    {_embed();}

    ET_option EMBED_END
;

option_EOF
:
    option EOF
;

arguments_OPT
:
    {}

    {_enterOPT();}

    arguments?
    (
        {_tail();}

        (
            {_term();}

            MT_arguments_OPT
            |
            {_embed();}

            ET_arguments_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_arguments_OPT
    |
    {_embed();}

    ET_arguments_OPT EMBED_END
;

arguments_OPT_EOF
:
    arguments_OPT EOF
;

colon_TOK
:
    {}

    COLON
    {}

    |
    {_term();}

    MT_colon_TOK
    |
    {_embed();}

    ET_colon_TOK EMBED_END
;

colon_TOK_EOF
:
    colon_TOK EOF
;

pattern
:
    {_enterAlt();}

    properties_OPT constructor arguments_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_pattern
    |
    {_embed();}

    ET_pattern EMBED_END
;

pattern_EOF
:
    pattern EOF
;

properties_OPT
:
    {}

    {_enterOPT();}

    properties?
    (
        {_tail();}

        (
            {_term();}

            MT_properties_OPT
            |
            {_embed();}

            ET_properties_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_properties_OPT
    |
    {_embed();}

    ET_properties_OPT EMBED_END
;

properties_OPT_EOF
:
    properties_OPT EOF
;

contractum
:
    {_enterAlt();}

    freeTerm
    {_exitAlt();}

    |
    {_term();}

    MT_contractum
    |
    {_embed();}

    ET_contractum EMBED_END
;

contractum_EOF
:
    contractum EOF
;

annotations
:
    {_enterAlt();}

    annotation_OOM
    {_exitAlt();}

    |
    {_term();}

    MT_annotations
    |
    {_embed();}

    ET_annotations EMBED_END
;

annotations_EOF
:
    annotations EOF
;

annotation_OOM
:
    {}

    {_enterOOM();}

    annotation+
    (
        {_tail();}

        (
            {_term();}

            MT_annotation_OOM
            |
            {_embed();}

            ET_annotation_OOM EMBED_END
        )
    )?
    {_exitOOM();}

    {}

    |
    {_term();}

    MT_annotation_OOM
    |
    {_embed();}

    ET_annotation_OOM EMBED_END
;

annotation_OOM_EOF
:
    annotation_OOM EOF
;

annotation
:
    {_enterAlt();}

    at_TOK constructor arguments_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_annotation
    |
    {_embed();}

    ET_annotation EMBED_END
;

annotation_EOF
:
    annotation EOF
;

at_TOK
:
    {}

    AT
    {}

    |
    {_term();}

    MT_at_TOK
    |
    {_embed();}

    ET_at_TOK EMBED_END
;

at_TOK_EOF
:
    at_TOK EOF
;

term
:
    {_enterAlt("1");}

    freeTerm
    {_exitAlt();}

    |
    {_enterAlt("2");}

    boundTerm
    {_exitAlt();}

    |
    {_term();}

    MT_term
    |
    {_embed();}

    ET_term EMBED_END
;

term_EOF
:
    term EOF
;

freeTerm
:
    {_enterAlt("1");}

    annotations_OPT properties_OPT constructor arguments_OPT
    {_exitAlt();}

    |
    {_enterAlt("2");}

    annotations_OPT properties_OPT constructor term
    {_exitAlt();}

    |
    {_enterAlt("3");}

    annotations_OPT properties_OPT literal
    {_exitAlt();}

    |
    {_enterAlt("4");}

    annotations_OPT list
    {_exitAlt();}

    |
    {_enterAlt("5");}

    annotations_OPT variable
    {_exitAlt();}

    |
    {_enterAlt("6");}

    annotations_OPT properties
    {_exitAlt();}

    |
    {_enterAlt("7");}

    annotations_OPT properties_OPT metavar_TOK freeArguments_OPT
    {_exitAlt();}

    |
    {_enterAlt("8");}

    annotations_OPT concrete
    {_exitAlt();}

    |
    {_enterAlt("9");}

    annotations_OPT properties_OPT expression
    {_exitAlt();}

    |
    {_term();}

    MT_freeTerm
    |
    {_embed();}

    ET_freeTerm EMBED_END
;

freeTerm_EOF
:
    freeTerm EOF
;

annotations_OPT
:
    {}

    {_enterOPT();}

    annotations?
    (
        {_tail();}

        (
            {_term();}

            MT_annotations_OPT
            |
            {_embed();}

            ET_annotations_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_annotations_OPT
    |
    {_embed();}

    ET_annotations_OPT EMBED_END
;

annotations_OPT_EOF
:
    annotations_OPT EOF
;

metavar_TOK
:
    {}

    METAVAR
    {}

    |
    {_term();}

    MT_metavar_TOK
    |
    {_embed();}

    ET_metavar_TOK EMBED_END
;

metavar_TOK_EOF
:
    metavar_TOK EOF
;

freeArguments_OPT
:
    {}

    {_enterOPT();}

    freeArguments?
    (
        {_tail();}

        (
            {_term();}

            MT_freeArguments_OPT
            |
            {_embed();}

            ET_freeArguments_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_freeArguments_OPT
    |
    {_embed();}

    ET_freeArguments_OPT EMBED_END
;

freeArguments_OPT_EOF
:
    freeArguments_OPT EOF
;

boundTerm
:
    {_enterAlt();}

    binder nextBinder
    {_exitAlt();}

    |
    {_term();}

    MT_boundTerm
    |
    {_embed();}

    ET_boundTerm EMBED_END
;

boundTerm_EOF
:
    boundTerm EOF
;

nextBinder
:
    {_enterAlt("1");}

    binder nextBinder
    {_exitAlt();}

    |
    {_enterAlt("2");}

    dot_TOK freeTerm
    {_exitAlt();}

    |
    {_term();}

    MT_nextBinder
    |
    {_embed();}

    ET_nextBinder EMBED_END
;

nextBinder_EOF
:
    nextBinder EOF
;

dot_TOK
:
    {}

    DOT
    {}

    |
    {_term();}

    MT_dot_TOK
    |
    {_embed();}

    ET_dot_TOK EMBED_END
;

dot_TOK_EOF
:
    dot_TOK EOF
;

arguments
:
    {_enterAlt();}

    lsquare_TOK terms_OPT rsquare_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_arguments
    |
    {_embed();}

    ET_arguments EMBED_END
;

arguments_EOF
:
    arguments EOF
;

lsquare_TOK
:
    {}

    LSQUARE
    {}

    |
    {_term();}

    MT_lsquare_TOK
    |
    {_embed();}

    ET_lsquare_TOK EMBED_END
;

lsquare_TOK_EOF
:
    lsquare_TOK EOF
;

terms_OPT
:
    {}

    {_enterOPT();}

    terms?
    (
        {_tail();}

        (
            {_term();}

            MT_terms_OPT
            |
            {_embed();}

            ET_terms_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_terms_OPT
    |
    {_embed();}

    ET_terms_OPT EMBED_END
;

terms_OPT_EOF
:
    terms_OPT EOF
;

rsquare_TOK
:
    {}

    RSQUARE
    {}

    |
    {_term();}

    MT_rsquare_TOK
    |
    {_embed();}

    ET_rsquare_TOK EMBED_END
;

rsquare_TOK_EOF
:
    rsquare_TOK EOF
;

terms
:
    {_enterAlt();}

    term terms_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_terms
    |
    {_embed();}

    ET_terms EMBED_END
;

terms_EOF
:
    terms EOF
;

terms_S1_ZOM
:
    {}

    {_enterZOM();}

    terms_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_terms_S1_ZOM
            |
            {_embed();}

            ET_terms_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_terms_S1_ZOM
    |
    {_embed();}

    ET_terms_S1_ZOM EMBED_END
;

terms_S1_ZOM_EOF
:
    terms_S1_ZOM EOF
;

terms_S1
:
    {_enterAlt();}

    comma_TOK term
    {_exitAlt();}

    |
    {_term();}

    MT_terms_S1
    |
    {_embed();}

    ET_terms_S1 EMBED_END
;

terms_S1_EOF
:
    terms_S1 EOF
;

comma_TOK
:
    {}

    COMMA
    {}

    |
    {_term();}

    MT_comma_TOK
    |
    {_embed();}

    ET_comma_TOK EMBED_END
;

comma_TOK_EOF
:
    comma_TOK EOF
;

freeArguments
:
    {_enterAlt();}

    lsquare_TOK freeTerms_OPT rsquare_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_freeArguments
    |
    {_embed();}

    ET_freeArguments EMBED_END
;

freeArguments_EOF
:
    freeArguments EOF
;

freeTerms_OPT
:
    {}

    {_enterOPT();}

    freeTerms?
    (
        {_tail();}

        (
            {_term();}

            MT_freeTerms_OPT
            |
            {_embed();}

            ET_freeTerms_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_freeTerms_OPT
    |
    {_embed();}

    ET_freeTerms_OPT EMBED_END
;

freeTerms_OPT_EOF
:
    freeTerms_OPT EOF
;

freeTerms
:
    {_enterAlt();}

    freeTerm freeTerms_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_freeTerms
    |
    {_embed();}

    ET_freeTerms EMBED_END
;

freeTerms_EOF
:
    freeTerms EOF
;

freeTerms_S1_ZOM
:
    {}

    {_enterZOM();}

    freeTerms_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_freeTerms_S1_ZOM
            |
            {_embed();}

            ET_freeTerms_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_freeTerms_S1_ZOM
    |
    {_embed();}

    ET_freeTerms_S1_ZOM EMBED_END
;

freeTerms_S1_ZOM_EOF
:
    freeTerms_S1_ZOM EOF
;

freeTerms_S1
:
    {_enterAlt();}

    comma_TOK freeTerm
    {_exitAlt();}

    |
    {_term();}

    MT_freeTerms_S1
    |
    {_embed();}

    ET_freeTerms_S1 EMBED_END
;

freeTerms_S1_EOF
:
    freeTerms_S1 EOF
;

list
:
    {_enterAlt();}

    lpar_TOK termList_OPT rpar_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_list
    |
    {_embed();}

    ET_list EMBED_END
;

list_EOF
:
    list EOF
;

lpar_TOK
:
    {}

    LPAR
    {}

    |
    {_term();}

    MT_lpar_TOK
    |
    {_embed();}

    ET_lpar_TOK EMBED_END
;

lpar_TOK_EOF
:
    lpar_TOK EOF
;

termList_OPT
:
    {}

    {_enterOPT();}

    termList?
    (
        {_tail();}

        (
            {_term();}

            MT_termList_OPT
            |
            {_embed();}

            ET_termList_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_termList_OPT
    |
    {_embed();}

    ET_termList_OPT EMBED_END
;

termList_OPT_EOF
:
    termList_OPT EOF
;

rpar_TOK
:
    {}

    RPAR
    {}

    |
    {_term();}

    MT_rpar_TOK
    |
    {_embed();}

    ET_rpar_TOK EMBED_END
;

rpar_TOK_EOF
:
    rpar_TOK EOF
;

termList
:
    {_enterAlt();}

    term termList_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_termList
    |
    {_embed();}

    ET_termList EMBED_END
;

termList_EOF
:
    termList EOF
;

termList_S1_ZOM
:
    {}

    {_enterZOM();}

    termList_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_termList_S1_ZOM
            |
            {_embed();}

            ET_termList_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_termList_S1_ZOM
    |
    {_embed();}

    ET_termList_S1_ZOM EMBED_END
;

termList_S1_ZOM_EOF
:
    termList_S1_ZOM EOF
;

termList_S1
:
    {_enterAlt();}

    semi_TOK term_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_termList_S1
    |
    {_embed();}

    ET_termList_S1 EMBED_END
;

termList_S1_EOF
:
    termList_S1 EOF
;

term_OPT
:
    {}

    {_enterOPT();}

    term?
    (
        {_tail();}

        (
            {_term();}

            MT_term_OPT
            |
            {_embed();}

            ET_term_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_term_OPT
    |
    {_embed();}

    ET_term_OPT EMBED_END
;

term_OPT_EOF
:
    term_OPT EOF
;

variable
:
    {_enterAlt();}

    variable_TOK linear_OPT functional_OPT varsort_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_variable
    |
    {_embed();}

    ET_variable EMBED_END
;

variable_EOF
:
    variable EOF
;

variable_TOK
:
    {}

    VARIABLE
    {}

    |
    {_term();}

    MT_variable_TOK
    |
    {_embed();}

    ET_variable_TOK EMBED_END
;

variable_TOK_EOF
:
    variable_TOK EOF
;

linear_OPT
:
    {}

    {_enterOPT();}

    linear?
    (
        {_tail();}

        (
            {_term();}

            MT_linear_OPT
            |
            {_embed();}

            ET_linear_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_linear_OPT
    |
    {_embed();}

    ET_linear_OPT EMBED_END
;

linear_OPT_EOF
:
    linear_OPT EOF
;

functional_OPT
:
    {}

    {_enterOPT();}

    functional?
    (
        {_tail();}

        (
            {_term();}

            MT_functional_OPT
            |
            {_embed();}

            ET_functional_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_functional_OPT
    |
    {_embed();}

    ET_functional_OPT EMBED_END
;

functional_OPT_EOF
:
    functional_OPT EOF
;

varsort_OPT
:
    {}

    {_enterOPT();}

    varsort?
    (
        {_tail();}

        (
            {_term();}

            MT_varsort_OPT
            |
            {_embed();}

            ET_varsort_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_varsort_OPT
    |
    {_embed();}

    ET_varsort_OPT EMBED_END
;

varsort_OPT_EOF
:
    varsort_OPT EOF
;

linear
:
    {_enterAlt();}

    linear_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_linear
    |
    {_embed();}

    ET_linear EMBED_END
;

linear_EOF
:
    linear EOF
;

linear_TOK
:
    {}

    LINEAR
    {}

    |
    {_term();}

    MT_linear_TOK
    |
    {_embed();}

    ET_linear_TOK EMBED_END
;

linear_TOK_EOF
:
    linear_TOK EOF
;

functional
:
    {_enterAlt();}

    functional_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_functional
    |
    {_embed();}

    ET_functional EMBED_END
;

functional_EOF
:
    functional EOF
;

functional_TOK
:
    {}

    FUNCTIONAL
    {}

    |
    {_term();}

    MT_functional_TOK
    |
    {_embed();}

    ET_functional_TOK EMBED_END
;

functional_TOK_EOF
:
    functional_TOK EOF
;

literal
:
    {_enterAlt("1");}

    string_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    number_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_literal
    |
    {_embed();}

    ET_literal EMBED_END
;

literal_EOF
:
    literal EOF
;

string_TOK
:
    {}

    STRING
    {}

    |
    {_term();}

    MT_string_TOK
    |
    {_embed();}

    ET_string_TOK EMBED_END
;

string_TOK_EOF
:
    string_TOK EOF
;

number_TOK
:
    {}

    NUMBER
    {}

    |
    {_term();}

    MT_number_TOK
    |
    {_embed();}

    ET_number_TOK EMBED_END
;

number_TOK_EOF
:
    number_TOK EOF
;

binder
:
    {_enterAlt();}

    annotations_OPT variable
    {_exitAlt();}

    |
    {_term();}

    MT_binder
    |
    {_embed();}

    ET_binder EMBED_END
;

binder_EOF
:
    binder EOF
;

varsort
:
    {_enterAlt();}

    coloncolon_TOK sortname
    {_exitAlt();}

    |
    {_term();}

    MT_varsort
    |
    {_embed();}

    ET_varsort EMBED_END
;

varsort_EOF
:
    varsort EOF
;

coloncolon_TOK
:
    {}

    COLONCOLON
    {}

    |
    {_term();}

    MT_coloncolon_TOK
    |
    {_embed();}

    ET_coloncolon_TOK EMBED_END
;

coloncolon_TOK_EOF
:
    coloncolon_TOK EOF
;

concrete
:
    {_enterAlt("1");}

    category_TOK concrete_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    category_TOK concrete2_TOK
    {_exitAlt();}

    |
    {_enterAlt("3");}

    category_TOK concrete3_TOK
    {_exitAlt();}

    |
    {_enterAlt("4");}

    category_TOK concrete4_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_concrete
    |
    {_embed();}

    ET_concrete EMBED_END
;

concrete_EOF
:
    concrete EOF
;

category_TOK
:
    {}

    CATEGORY
    {}

    |
    {_term();}

    MT_category_TOK
    |
    {_embed();}

    ET_category_TOK EMBED_END
;

category_TOK_EOF
:
    category_TOK EOF
;

concrete_TOK
:
    {}

    CONCRETE
    {}

    |
    {_term();}

    MT_concrete_TOK
    |
    {_embed();}

    ET_concrete_TOK EMBED_END
;

concrete_TOK_EOF
:
    concrete_TOK EOF
;

concrete2_TOK
:
    {}

    CONCRETE2
    {}

    |
    {_term();}

    MT_concrete2_TOK
    |
    {_embed();}

    ET_concrete2_TOK EMBED_END
;

concrete2_TOK_EOF
:
    concrete2_TOK EOF
;

concrete3_TOK
:
    {}

    CONCRETE3
    {}

    |
    {_term();}

    MT_concrete3_TOK
    |
    {_embed();}

    ET_concrete3_TOK EMBED_END
;

concrete3_TOK_EOF
:
    concrete3_TOK EOF
;

concrete4_TOK
:
    {}

    CONCRETE4
    {}

    |
    {_term();}

    MT_concrete4_TOK
    |
    {_embed();}

    ET_concrete4_TOK EMBED_END
;

concrete4_TOK_EOF
:
    concrete4_TOK EOF
;

dispatch
:
    {_enterAlt();}

    dispatch_TOK dispatchTerm dispatchCases delayCase_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_dispatch
    |
    {_embed();}

    ET_dispatch EMBED_END
;

dispatch_EOF
:
    dispatch EOF
;

dispatch_TOK
:
    {}

    DISPATCH
    {}

    |
    {_term();}

    MT_dispatch_TOK
    |
    {_embed();}

    ET_dispatch_TOK EMBED_END
;

dispatch_TOK_EOF
:
    dispatch_TOK EOF
;

delayCase_OPT
:
    {}

    {_enterOPT();}

    delayCase?
    (
        {_tail();}

        (
            {_term();}

            MT_delayCase_OPT
            |
            {_embed();}

            ET_delayCase_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_delayCase_OPT
    |
    {_embed();}

    ET_delayCase_OPT EMBED_END
;

delayCase_OPT_EOF
:
    delayCase_OPT EOF
;

dispatchTerm
:
    {_enterAlt();}

    freeTerm
    {_exitAlt();}

    |
    {_term();}

    MT_dispatchTerm
    |
    {_embed();}

    ET_dispatchTerm EMBED_END
;

dispatchTerm_EOF
:
    dispatchTerm EOF
;

dispatchCases
:
    {_enterAlt();}

    dispatchCase dispatchCases_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_dispatchCases
    |
    {_embed();}

    ET_dispatchCases EMBED_END
;

dispatchCases_EOF
:
    dispatchCases EOF
;

dispatchCases_S1_ZOM
:
    {}

    {_enterZOM();}

    dispatchCases_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_dispatchCases_S1_ZOM
            |
            {_embed();}

            ET_dispatchCases_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_dispatchCases_S1_ZOM
    |
    {_embed();}

    ET_dispatchCases_S1_ZOM EMBED_END
;

dispatchCases_S1_ZOM_EOF
:
    dispatchCases_S1_ZOM EOF
;

dispatchCases_S1
:
    {_enterAlt();}

    semi_TOK dispatchCase
    {_exitAlt();}

    |
    {_term();}

    MT_dispatchCases_S1
    |
    {_embed();}

    ET_dispatchCases_S1 EMBED_END
;

dispatchCases_S1_EOF
:
    dispatchCases_S1 EOF
;

dispatchCase
:
    {_enterAlt();}

    ruleDeclaration
    {_exitAlt();}

    |
    {_term();}

    MT_dispatchCase
    |
    {_embed();}

    ET_dispatchCase EMBED_END
;

dispatchCase_EOF
:
    dispatchCase EOF
;

delayCase
:
    {_enterAlt();}

    delay_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_delayCase
    |
    {_embed();}

    ET_delayCase EMBED_END
;

delayCase_EOF
:
    delayCase EOF
;

delay_TOK
:
    {}

    DELAY
    {}

    |
    {_term();}

    MT_delay_TOK
    |
    {_embed();}

    ET_delay_TOK EMBED_END
;

delay_TOK_EOF
:
    delay_TOK EOF
;

properties
:
    {_enterAlt();}

    lbrace_TOK propertyList_OPT rbrace_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_properties
    |
    {_embed();}

    ET_properties EMBED_END
;

properties_EOF
:
    properties EOF
;

propertyList_OPT
:
    {}

    {_enterOPT();}

    propertyList?
    (
        {_tail();}

        (
            {_term();}

            MT_propertyList_OPT
            |
            {_embed();}

            ET_propertyList_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_propertyList_OPT
    |
    {_embed();}

    ET_propertyList_OPT EMBED_END
;

propertyList_OPT_EOF
:
    propertyList_OPT EOF
;

propertyList
:
    {_enterAlt();}

    property propertyList_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_propertyList
    |
    {_embed();}

    ET_propertyList EMBED_END
;

propertyList_EOF
:
    propertyList EOF
;

propertyList_S1_ZOM
:
    {}

    {_enterZOM();}

    propertyList_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_propertyList_S1_ZOM
            |
            {_embed();}

            ET_propertyList_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_propertyList_S1_ZOM
    |
    {_embed();}

    ET_propertyList_S1_ZOM EMBED_END
;

propertyList_S1_ZOM_EOF
:
    propertyList_S1_ZOM EOF
;

propertyList_S1
:
    {_enterAlt();}

    semi_TOK property_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_propertyList_S1
    |
    {_embed();}

    ET_propertyList_S1 EMBED_END
;

propertyList_S1_EOF
:
    propertyList_S1 EOF
;

property_OPT
:
    {}

    {_enterOPT();}

    property?
    (
        {_tail();}

        (
            {_term();}

            MT_property_OPT
            |
            {_embed();}

            ET_property_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_property_OPT
    |
    {_embed();}

    ET_property_OPT EMBED_END
;

property_OPT_EOF
:
    property_OPT EOF
;

property
:
    {_enterAlt("1");}

    metavar_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    not_TOK metavar_TOK
    {_exitAlt();}

    |
    {_enterAlt("3");}

    metavar_TOK colon_TOK freeTerm
    {_exitAlt();}

    |
    {_enterAlt("4");}

    variable_TOK
    {_exitAlt();}

    |
    {_enterAlt("5");}

    not_TOK variable_TOK
    {_exitAlt();}

    |
    {_enterAlt("6");}

    variable_TOK colon_TOK freeTerm
    {_exitAlt();}

    |
    {_enterAlt("7");}

    string_TOK
    {_exitAlt();}

    |
    {_enterAlt("8");}

    not_TOK string_TOK
    {_exitAlt();}

    |
    {_enterAlt("9");}

    string_TOK colon_TOK freeTerm
    {_exitAlt();}

    |
    {_enterAlt("10");}

    constructor colon_TOK freeTerm
    {_exitAlt();}

    |
    {_term();}

    MT_property
    |
    {_embed();}

    ET_property EMBED_END
;

property_EOF
:
    property EOF
;

not_TOK
:
    {}

    NOT
    {}

    |
    {_term();}

    MT_not_TOK
    |
    {_embed();}

    ET_not_TOK EMBED_END
;

not_TOK_EOF
:
    not_TOK EOF
;

expression
:
    {_enterAlt();}

    dispatch
    {_exitAlt();}

    |
    {_term();}

    MT_expression
    |
    {_embed();}

    ET_expression EMBED_END
;

expression_EOF
:
    expression EOF
;

sortDeclaration
:
    {_enterAlt("1");}

    sortparams_OPT sortset sortname datasort_TOK lpar_TOK forms rpar_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    sortparams_OPT sortset form coloncolon_TOK sortname
    {_exitAlt();}

    |
    {_term();}

    MT_sortDeclaration
    |
    {_embed();}

    ET_sortDeclaration EMBED_END
;

sortDeclaration_EOF
:
    sortDeclaration EOF
;

sortparams_OPT
:
    {}

    {_enterOPT();}

    sortparams?
    (
        {_tail();}

        (
            {_term();}

            MT_sortparams_OPT
            |
            {_embed();}

            ET_sortparams_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_sortparams_OPT
    |
    {_embed();}

    ET_sortparams_OPT EMBED_END
;

sortparams_OPT_EOF
:
    sortparams_OPT EOF
;

datasort_TOK
:
    {}

    DATASORT
    {}

    |
    {_term();}

    MT_datasort_TOK
    |
    {_embed();}

    ET_datasort_TOK EMBED_END
;

datasort_TOK_EOF
:
    datasort_TOK EOF
;

sortparams
:
    {_enterAlt();}

    forall_TOK variable_OOM dot_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_sortparams
    |
    {_embed();}

    ET_sortparams EMBED_END
;

sortparams_EOF
:
    sortparams EOF
;

forall_TOK
:
    {}

    FORALL
    {}

    |
    {_term();}

    MT_forall_TOK
    |
    {_embed();}

    ET_forall_TOK EMBED_END
;

forall_TOK_EOF
:
    forall_TOK EOF
;

variable_OOM
:
    {}

    {_enterOOM();}

    variable+
    (
        {_tail();}

        (
            {_term();}

            MT_variable_OOM
            |
            {_embed();}

            ET_variable_OOM EMBED_END
        )
    )?
    {_exitOOM();}

    {}

    |
    {_term();}

    MT_variable_OOM
    |
    {_embed();}

    ET_variable_OOM EMBED_END
;

variable_OOM_EOF
:
    variable_OOM EOF
;

sortset
:
    {_enterAlt();}

    properties_OPT
    {_exitAlt();}

    |
    {_term();}

    MT_sortset
    |
    {_embed();}

    ET_sortset EMBED_END
;

sortset_EOF
:
    sortset EOF
;

sortnames
:
    {_enterAlt();}

    sortname sortnames_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_sortnames
    |
    {_embed();}

    ET_sortnames EMBED_END
;

sortnames_EOF
:
    sortnames EOF
;

sortnames_S1_ZOM
:
    {}

    {_enterZOM();}

    sortnames_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_sortnames_S1_ZOM
            |
            {_embed();}

            ET_sortnames_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_sortnames_S1_ZOM
    |
    {_embed();}

    ET_sortnames_S1_ZOM EMBED_END
;

sortnames_S1_ZOM_EOF
:
    sortnames_S1_ZOM EOF
;

sortnames_S1
:
    {_enterAlt();}

    comma_TOK sortname
    {_exitAlt();}

    |
    {_term();}

    MT_sortnames_S1
    |
    {_embed();}

    ET_sortnames_S1 EMBED_END
;

sortnames_S1_EOF
:
    sortnames_S1 EOF
;

sortname
:
    {_enterAlt("1");}

    constructor sortarguments_OPT
    {_exitAlt();}

    |
    {_enterAlt("2");}

    variable
    {_exitAlt();}

    |
    {_term();}

    MT_sortname
    |
    {_embed();}

    ET_sortname EMBED_END
;

sortname_EOF
:
    sortname EOF
;

sortarguments_OPT
:
    {}

    {_enterOPT();}

    sortarguments?
    (
        {_tail();}

        (
            {_term();}

            MT_sortarguments_OPT
            |
            {_embed();}

            ET_sortarguments_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_sortarguments_OPT
    |
    {_embed();}

    ET_sortarguments_OPT EMBED_END
;

sortarguments_OPT_EOF
:
    sortarguments_OPT EOF
;

sortarguments
:
    {_enterAlt();}

    lsquare_TOK sortnames_OPT rsquare_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_sortarguments
    |
    {_embed();}

    ET_sortarguments EMBED_END
;

sortarguments_EOF
:
    sortarguments EOF
;

sortnames_OPT
:
    {}

    {_enterOPT();}

    sortnames?
    (
        {_tail();}

        (
            {_term();}

            MT_sortnames_OPT
            |
            {_embed();}

            ET_sortnames_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_sortnames_OPT
    |
    {_embed();}

    ET_sortnames_OPT EMBED_END
;

sortnames_OPT_EOF
:
    sortnames_OPT EOF
;

forms
:
    {_enterAlt();}

    forms_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_forms
    |
    {_embed();}

    ET_forms EMBED_END
;

forms_EOF
:
    forms EOF
;

forms_S1_ZOM
:
    {}

    {_enterZOM();}

    forms_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_forms_S1_ZOM
            |
            {_embed();}

            ET_forms_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_forms_S1_ZOM
    |
    {_embed();}

    ET_forms_S1_ZOM EMBED_END
;

forms_S1_ZOM_EOF
:
    forms_S1_ZOM EOF
;

forms_S1
:
    {_enterAlt();}

    form semi_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_forms_S1
    |
    {_embed();}

    ET_forms_S1 EMBED_END
;

forms_S1_EOF
:
    forms_S1 EOF
;

form
:
    {_enterAlt("1");}

    constructor arguments_OPT
    {_exitAlt();}

    |
    {_enterAlt("2");}

    variable
    {_exitAlt();}

    |
    {_term();}

    MT_form
    |
    {_embed();}

    ET_form EMBED_END
;

form_EOF
:
    form EOF
;

constructor
:
    {_enterAlt("1");}

    qualifier constructor_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    reserved
    {_exitAlt();}

    |
    {_term();}

    MT_constructor
    |
    {_embed();}

    ET_constructor EMBED_END
;

constructor_EOF
:
    constructor EOF
;

qualifier
:
    {_enterAlt("1");}

    constructor_TOK dot_TOK qualifier
    {_exitAlt();}

    |
    {_enterAlt("2");}

    {_exitAlt();}

    |
    {_term();}

    MT_qualifier
    |
    {_embed();}

    ET_qualifier EMBED_END
;

qualifier_EOF
:
    qualifier EOF
;

reserved
:
    {_enterAlt("1");}

    colon_TOK
    {_exitAlt();}

    |
    {_enterAlt("2");}

    at_TOK
    {_exitAlt();}

    |
    {_enterAlt("3");}

    dot_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_reserved
    |
    {_embed();}

    ET_reserved EMBED_END
;

reserved_EOF
:
    reserved EOF
;

directive
:
    {_enterAlt("1");}

    constructor directiveArguments_OPT
    {_exitAlt();}

    |
    {_enterAlt("2");}

    directiveList
    {_exitAlt();}

    |
    {_enterAlt("3");}

    literal
    {_exitAlt();}

    |
    {_enterAlt("4");}

    concrete
    {_exitAlt();}

    |
    {_term();}

    MT_directive
    |
    {_embed();}

    ET_directive EMBED_END
;

directive_EOF
:
    directive EOF
;

directiveArguments_OPT
:
    {}

    {_enterOPT();}

    directiveArguments?
    (
        {_tail();}

        (
            {_term();}

            MT_directiveArguments_OPT
            |
            {_embed();}

            ET_directiveArguments_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_directiveArguments_OPT
    |
    {_embed();}

    ET_directiveArguments_OPT EMBED_END
;

directiveArguments_OPT_EOF
:
    directiveArguments_OPT EOF
;

directiveArguments
:
    {_enterAlt();}

    lsquare_TOK directives_OPT rsquare_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_directiveArguments
    |
    {_embed();}

    ET_directiveArguments EMBED_END
;

directiveArguments_EOF
:
    directiveArguments EOF
;

directives_OPT
:
    {}

    {_enterOPT();}

    directives?
    (
        {_tail();}

        (
            {_term();}

            MT_directives_OPT
            |
            {_embed();}

            ET_directives_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_directives_OPT
    |
    {_embed();}

    ET_directives_OPT EMBED_END
;

directives_OPT_EOF
:
    directives_OPT EOF
;

directives
:
    {_enterAlt();}

    directive directives_S1_ZOM
    {_exitAlt();}

    |
    {_term();}

    MT_directives
    |
    {_embed();}

    ET_directives EMBED_END
;

directives_EOF
:
    directives EOF
;

directives_S1_ZOM
:
    {}

    {_enterZOM();}

    directives_S1*
    (
        {_tail();}

        (
            {_term();}

            MT_directives_S1_ZOM
            |
            {_embed();}

            ET_directives_S1_ZOM EMBED_END
        )
    )?
    {_exitZOM();}

    {}

    |
    {_term();}

    MT_directives_S1_ZOM
    |
    {_embed();}

    ET_directives_S1_ZOM EMBED_END
;

directives_S1_ZOM_EOF
:
    directives_S1_ZOM EOF
;

directives_S1
:
    {_enterAlt();}

    comma_TOK directive
    {_exitAlt();}

    |
    {_term();}

    MT_directives_S1
    |
    {_embed();}

    ET_directives_S1 EMBED_END
;

directives_S1_EOF
:
    directives_S1 EOF
;

directiveList
:
    {_enterAlt();}

    lpar_TOK declarations_OPT rpar_TOK
    {_exitAlt();}

    |
    {_term();}

    MT_directiveList
    |
    {_embed();}

    ET_directiveList EMBED_END
;

directiveList_EOF
:
    directiveList EOF
;

declarations_OPT
:
    {}

    {_enterOPT();}

    declarations?
    (
        {_tail();}

        (
            {_term();}

            MT_declarations_OPT
            |
            {_embed();}

            ET_declarations_OPT EMBED_END
        )
    )?
    {_exitOPT();}

    {}

    |
    {_term();}

    MT_declarations_OPT
    |
    {_embed();}

    ET_declarations_OPT EMBED_END
;

declarations_OPT_EOF
:
    declarations_OPT EOF
;    