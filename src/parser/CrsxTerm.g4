    grammar  CrsxTerm ;    @   header {
import org.crsx.pg.SinkAntlrListener;
import static org.crsx.pg.SinkAntlrListener.fireEnterZOM;
import static org.crsx.pg.SinkAntlrListener.fireExitZOM;
import static org.crsx.pg.SinkAntlrListener.fireEnterOPT;
import static org.crsx.pg.SinkAntlrListener.fireExitOPT;
import static org.crsx.pg.SinkAntlrListener.fireEnterAlt;
import static org.crsx.pg.SinkAntlrListener.fireExitAlt;
import static org.crsx.pg.SinkAntlrListener.fireHide;
}   @    parser ::  members {
protected String _prefix() { return "Crsx_"; }
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
}       crsx      :        {_enterAlt();}     declarations     {_exitAlt();}    ;        declarations      :        {_enterAlt();}     declaration     {_enterZOM();}     declarations_S1     *   {_exitZOM();}   {_exitAlt();}    ;        declarations_S1      :        {_enterAlt();}     SEMI    {_enterOPT();}     declaration     ?   {_exitOPT();}   {_exitAlt();}    ;        declaration      :        {_enterAlt("1");}     moduleDeclaration     {_exitAlt();}     |      {_enterAlt("2");}     ruleDeclaration     {_exitAlt();}    |      {_enterAlt("3");}     sortDeclaration     {_exitAlt();}    |      {_enterAlt("4");}     directive     {_exitAlt();}   ;        moduleDeclaration      :        {_enterAlt();}     MODULE      CONSTRUCTOR      LBRACE      declarations       RBRACE    {_exitAlt();}    ;        ruleDeclaration      :        {_enterAlt();}   {_enterOPT();}     option     ?   {_exitOPT();}     pattern       ARROW      contractum     {_exitAlt();}    ;        option      :        {_enterAlt("1");}     constructor     {_enterOPT();}     arguments     ?   {_exitOPT();}     COLON    {_exitAlt();}     |      {_enterAlt("2");}     annotations     {_exitAlt();}   ;        pattern      :        {_enterAlt();}   {_enterOPT();}     properties     ?   {_exitOPT();}     constructor     {_enterOPT();}     arguments     ?   {_exitOPT();}   {_exitAlt();}    ;        contractum      :        {_enterAlt();}     freeTerm     {_exitAlt();}    ;        annotations      :        {_enterAlt();}   {_enterOOM();}     annotation     +   {_exitOOM();}   {_exitAlt();}    ;        annotation      :        {_enterAlt();}     AT      constructor     {_enterOPT();}     arguments     ?   {_exitOPT();}   {_exitAlt();}    ;        term      :        {_enterAlt("1");}     freeTerm     {_exitAlt();}     |      {_enterAlt("2");}     boundTerm     {_exitAlt();}   ;        freeTerm      :        {_enterAlt("1");}   {_enterOPT();}     annotations     ?   {_exitOPT();}   {_enterOPT();}     properties     ?   {_exitOPT();}     constructor     {_enterOPT();}     arguments     ?   {_exitOPT();}   {_exitAlt();}     |      {_enterAlt("2");}   {_enterOPT();}     annotations     ?   {_exitOPT();}   {_enterOPT();}     properties     ?   {_exitOPT();}     constructor       term     {_exitAlt();}    |      {_enterAlt("3");}   {_enterOPT();}     annotations     ?   {_exitOPT();}   {_enterOPT();}     properties     ?   {_exitOPT();}     literal     {_exitAlt();}    |      {_enterAlt("4");}   {_enterOPT();}     annotations     ?   {_exitOPT();}     list     {_exitAlt();}    |      {_enterAlt("5");}   {_enterOPT();}     annotations     ?   {_exitOPT();}     variable     {_exitAlt();}    |      {_enterAlt("6");}   {_enterOPT();}     annotations     ?   {_exitOPT();}     properties     {_exitAlt();}    |      {_enterAlt("7");}   {_enterOPT();}     annotations     ?   {_exitOPT();}   {_enterOPT();}     properties     ?   {_exitOPT();}     METAVAR    {_enterOPT();}     freeArguments     ?   {_exitOPT();}   {_exitAlt();}    |      {_enterAlt("8");}   {_enterOPT();}     annotations     ?   {_exitOPT();}     concrete     {_exitAlt();}    |      {_enterAlt("9");}   {_enterOPT();}     annotations     ?   {_exitOPT();}   {_enterOPT();}     properties     ?   {_exitOPT();}     expression     {_exitAlt();}   ;        boundTerm      :        {_enterAlt();}     binder       nextBinder     {_exitAlt();}    ;        nextBinder      :        {_enterAlt("1");}     binder       nextBinder     {_exitAlt();}     |      {_enterAlt("2");}     DOT      freeTerm     {_exitAlt();}   ;        arguments      :        {_enterAlt();}     LSQUARE    {_enterOPT();}     terms     ?   {_exitOPT();}     RSQUARE    {_exitAlt();}    ;        terms      :        {_enterAlt();}     term     {_enterZOM();}     terms_S1     *   {_exitZOM();}   {_exitAlt();}    ;        terms_S1      :        {_enterAlt();}     COMMA      term     {_exitAlt();}    ;        freeArguments      :        {_enterAlt();}     LSQUARE    {_enterOPT();}     freeTerms     ?   {_exitOPT();}     RSQUARE    {_exitAlt();}    ;        freeTerms      :        {_enterAlt();}     freeTerm     {_enterZOM();}     freeTerms_S1     *   {_exitZOM();}   {_exitAlt();}    ;        freeTerms_S1      :        {_enterAlt();}     COMMA      freeTerm     {_exitAlt();}    ;        list      :        {_enterAlt();}     LPAR    {_enterOPT();}     termList     ?   {_exitOPT();}     RPAR    {_exitAlt();}    ;        termList      :        {_enterAlt();}     term     {_enterZOM();}     termList_S1     *   {_exitZOM();}   {_exitAlt();}    ;        termList_S1      :        {_enterAlt();}     SEMI    {_enterOPT();}     term     ?   {_exitOPT();}   {_exitAlt();}    ;        variable      :        {_enterAlt();}     VARIABLE    {_enterOPT();}     linear     ?   {_exitOPT();}   {_enterOPT();}     functional     ?   {_exitOPT();}   {_enterOPT();}     varsort     ?   {_exitOPT();}   {_exitAlt();}    ;        linear      :        {_enterAlt();}     LINEAR    {_exitAlt();}    ;        functional      :        {_enterAlt();}     FUNCTIONAL    {_exitAlt();}    ;        literal      :        {_enterAlt("1");}     STRING    {_exitAlt();}     |      {_enterAlt("2");}     NUMBER    {_exitAlt();}   ;        binder      :        {_enterAlt();}   {_enterOPT();}     annotations     ?   {_exitOPT();}     variable     {_exitAlt();}    ;        varsort      :        {_enterAlt();}     COLONCOLON      sortname     {_exitAlt();}    ;        concrete      :        {_enterAlt("1");}     CATEGORY      CONCRETE    {_exitAlt();}     |      {_enterAlt("2");}     CATEGORY      CONCRETE2    {_exitAlt();}    |      {_enterAlt("3");}     CATEGORY      CONCRETE3    {_exitAlt();}    |      {_enterAlt("4");}     CATEGORY      CONCRETE4    {_exitAlt();}   ;        dispatch      :        {_enterAlt();}     DISPATCH      dispatchTerm       dispatchCases     {_enterOPT();}     delayCase     ?   {_exitOPT();}   {_exitAlt();}    ;        dispatchTerm      :        {_enterAlt();}     freeTerm     {_exitAlt();}    ;        dispatchCases      :        {_enterAlt();}     dispatchCase     {_enterZOM();}     dispatchCases_S1     *   {_exitZOM();}   {_exitAlt();}    ;        dispatchCases_S1      :        {_enterAlt();}     SEMI      dispatchCase     {_exitAlt();}    ;        dispatchCase      :        {_enterAlt();}     ruleDeclaration     {_exitAlt();}    ;        delayCase      :        {_enterAlt();}     DELAY    {_exitAlt();}    ;        properties      :        {_enterAlt();}     LBRACE    {_enterOPT();}     propertyList     ?   {_exitOPT();}     RBRACE    {_exitAlt();}    ;        propertyList      :        {_enterAlt();}     property     {_enterZOM();}     propertyList_S1     *   {_exitZOM();}   {_exitAlt();}    ;        propertyList_S1      :        {_enterAlt();}     SEMI    {_enterOPT();}     property     ?   {_exitOPT();}   {_exitAlt();}    ;        property      :        {_enterAlt("1");}     METAVAR    {_exitAlt();}     |      {_enterAlt("2");}     NOT      METAVAR    {_exitAlt();}    |      {_enterAlt("3");}     METAVAR      COLON      freeTerm     {_exitAlt();}    |      {_enterAlt("4");}     VARIABLE    {_exitAlt();}    |      {_enterAlt("5");}     NOT      VARIABLE    {_exitAlt();}    |      {_enterAlt("6");}     VARIABLE      COLON      freeTerm     {_exitAlt();}    |      {_enterAlt("7");}     STRING    {_exitAlt();}    |      {_enterAlt("8");}     NOT      STRING    {_exitAlt();}    |      {_enterAlt("9");}     STRING      COLON      freeTerm     {_exitAlt();}    |      {_enterAlt("10");}     constructor       COLON      freeTerm     {_exitAlt();}   ;        expression      :        {_enterAlt();}     dispatch     {_exitAlt();}    ;        sortDeclaration      :        {_enterAlt("1");}   {_enterOPT();}     sortparams     ?   {_exitOPT();}     sortset       sortname       DATASORT      LPAR      forms       RPAR    {_exitAlt();}     |      {_enterAlt("2");}   {_enterOPT();}     sortparams     ?   {_exitOPT();}     sortset       form       COLONCOLON      sortname     {_exitAlt();}   ;        sortparams      :        {_enterAlt();}     FORALL    {_enterOOM();}     variable     +   {_exitOOM();}     DOT    {_exitAlt();}    ;        sortset      :        {_enterAlt();}   {_enterOPT();}     properties     ?   {_exitOPT();}   {_exitAlt();}    ;        sortnames      :        {_enterAlt();}     sortname     {_enterZOM();}     sortnames_S1     *   {_exitZOM();}   {_exitAlt();}    ;        sortnames_S1      :        {_enterAlt();}     COMMA      sortname     {_exitAlt();}    ;        sortname      :        {_enterAlt("1");}     constructor     {_enterOPT();}     sortarguments     ?   {_exitOPT();}   {_exitAlt();}     |      {_enterAlt("2");}     variable     {_exitAlt();}   ;        sortarguments      :        {_enterAlt();}     LSQUARE    {_enterOPT();}     sortnames     ?   {_exitOPT();}     RSQUARE    {_exitAlt();}    ;        forms      :        {_enterAlt();}   {_enterZOM();}     forms_S1     *   {_exitZOM();}   {_exitAlt();}    ;        forms_S1      :        {_enterAlt();}     form       SEMI    {_exitAlt();}    ;        form      :        {_enterAlt("1");}     constructor     {_enterOPT();}     arguments     ?   {_exitOPT();}   {_exitAlt();}     |      {_enterAlt("2");}     variable     {_exitAlt();}   ;        constructor      :        {_enterAlt("1");}     qualifier       CONSTRUCTOR    {_exitAlt();}     |      {_enterAlt("2");}     reserved     {_exitAlt();}   ;        qualifier      :        {_enterAlt("1");}     CONSTRUCTOR      DOT      qualifier     {_exitAlt();}     |      {_enterAlt("2");}   {_exitAlt();}   ;        reserved      :        {_enterAlt("1");}     COLON    {_exitAlt();}     |      {_enterAlt("2");}     AT    {_exitAlt();}    |      {_enterAlt("3");}     DOT    {_exitAlt();}   ;        directive      :        {_enterAlt("1");}     constructor     {_enterOPT();}     directiveArguments     ?   {_exitOPT();}   {_exitAlt();}     |      {_enterAlt("2");}     directiveList     {_exitAlt();}    |      {_enterAlt("3");}     literal     {_exitAlt();}    |      {_enterAlt("4");}     concrete     {_exitAlt();}   ;        directiveArguments      :        {_enterAlt();}     LSQUARE    {_enterOPT();}     directives     ?   {_exitOPT();}     RSQUARE    {_exitAlt();}    ;        directives      :        {_enterAlt();}     directive     {_enterZOM();}     directives_S1     *   {_exitZOM();}   {_exitAlt();}    ;        directives_S1      :        {_enterAlt();}     COMMA      directive     {_exitAlt();}    ;        directiveList      :        {_enterAlt();}     LPAR    {_enterOPT();}     declarations     ?   {_exitOPT();}     RPAR    {_exitAlt();}    ;        MODULE :         'module'     ;     DISPATCH :         'dispatch'     ;     DELAY :         'delay'     ;     COLON :         ':'     ;     ARROW :         '→'     ;     FORALL :         '∀'     ;     LPAR :         '('     ;     RPAR :         ')'     ;     LBRACE :         '{'     ;     RBRACE :         '}'     ;     LSQUARE :         '['     ;     RSQUARE :         ']'     ;     SEMI :         ';'     ;     COMMA :         ','     ;     DATASORT :         '::='     ;     COLONCOLON :         '::'     ;     DOT :         '.'     ;     NOT :         '¬'     ;     LINEAR :         '¹'     ;     FUNCTIONAL :         'ᵇ'     ;     AND :         '&'     ;     AT :         '@'     ;     CATEGORY :         '%'     (        Alpha      |       Digit    )   +    (        '*'      |       '+'     |       '?'    )   ?    ;     CONCRETE :         '\u27e6'     (        CONCRETE      |      .    )   *  ?    '\u27e7'     ;     CONCRETE2 :         '⟪'     (        CONCRETE2      |      .    )   *  ?    '⟫'     ;     CONCRETE3 :         '\u27EA'     (        CONCRETE3      |      .    )   *  ?    '\u27EB'     ;     CONCRETE4 :         '\u2983'     (        CONCRETE4      |      .    )   *  ?    '\u2984'     ;     CONSTRUCTOR :         StartConstructorChar      ConstructorChar    *    ;     VARIABLE :         Lower     (        Lower      |       Digit     |       '-'    )   *    ;     METAVAR :         '#'     (        Alpha      |       Digit     |       Symbol     |       Unicode    )   *    ;     STRING :         '\"'     (        '""'      |       ~  '"'    )   *     '\"'     ;     NUMBER :         Decimal     ;     fragment StartConstructorChar :         Upper      |       Symbol     |       Unicode    ;     fragment ConstructorChar :         Alpha      |       Digit     |       Symbol     |       Unicode    ;     fragment Digit :        [0-9]    ;     fragment Upper :        [A-Z]    ;     fragment Lower :        [a-z]    ;     fragment Alpha :        [a-zA-Z]    ;     fragment Decimal :        [0-9]   +    (        '.'     [0-9]   +    )   ?     |       '.'     [0-9]   +   ;     fragment Symbol :        [+\-~`!*\^|?$_@]    ;     fragment Unicode :         ~  [\u0000-\u00FF\uD800-\uDBFF]     |      [\uD800-\uDBFF]    [\uDC00-\uDFFF]   ;     WS :        [ \t\r\n\f]   +    ->    channel (   HIDDEN )   ;     BLOCK_COMMENT :         '/*'     .    *  ?   (        '*/'      |       EOF    )    ->    channel (   HIDDEN )   ;     LINE_COMMENT :         '//'      ~  [\r\n]   *    ->    channel (   HIDDEN )   ;     XML_COMMENT :         '<!--'     .    *  ?   (        '-->'      |       EOF    )    ->    channel (   HIDDEN )   ; 