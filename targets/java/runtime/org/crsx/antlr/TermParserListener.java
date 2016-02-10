// Copyright (c) 2016 IBM Corporation.

package org.crsx.antlr;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Optional;

import org.antlr.v4.runtime.tree.TerminalNode;
import org.crsx.parser.CrsxMetaParser.BindersContext;
import org.crsx.parser.CrsxMetaParser.ConcreteContext;
import org.crsx.parser.CrsxMetaParser.ConsContext;
import org.crsx.parser.CrsxMetaParser.LiteralContext;
import org.crsx.parser.CrsxMetaParser.MetappContext;
import org.crsx.parser.CrsxMetaParser.ScopeContext;
import org.crsx.parser.CrsxMetaParser.VariableContext;
import org.crsx.parser.CrsxMetaParserBaseListener;

import net.sf.crsx.CRS;
import net.sf.crsx.CRSException;
import net.sf.crsx.Sink;
import net.sf.crsx.Variable;
import net.sf.crsx.generic.GenericFactory;
import net.sf.crsx.util.ExtensibleMap;
import net.sf.crsx.util.LinkedExtensibleMap;

/**
 * Antlr listener producing Crsx4 term compatible with Crsx3 internal term model.
 *  
 * @author Lionel Villard
 */
public class TermParserListener extends CrsxMetaParserBaseListener
{
	// Variable stack marker
	final static private Object MARKER = new Object();

	enum State {
		SKIP, CONS, LITERAL, VAR, BINDER, METAVAR, CONCRETE
	};

	public Sink sink3;

	State state;

	/** In scope variables. */
	private ArrayDeque<Object> bounds = new ArrayDeque<>();

	private ArrayList<Variable> binders;

	private GenericFactory factory;

	public TermParserListener(GenericFactory factory, Sink sink3)
	{
		this.sink3 = sink3;
		this.factory = factory;
		this.state = State.SKIP;
	}

	@Override
	public void enterMetapp(MetappContext ctx)
	{
		state = State.METAVAR;
	}

	@Override
	public void exitMetapp(MetappContext ctx)
	{
		sink3 = sink3.endMetaApplication();
	}

	@Override
	public void enterLiteral(LiteralContext ctx)
	{
		state = State.LITERAL;
	}

	@Override
	public void exitLiteral(LiteralContext ctx)
	{
		sink3 = sink3.end();
		state = State.SKIP;
	}

	@Override
	public void enterCons(ConsContext ctx)
	{
		state = State.CONS;
	}

	@Override
	public void exitCons(ConsContext ctx)
	{
		sink3 = sink3.end();
		state = State.SKIP;
	}

	@Override
	public void enterScope(ScopeContext ctx)
	{
		bounds.push(MARKER);

		binders = new ArrayList<>();
	}

	@Override
	public void exitScope(ScopeContext ctx)
	{
		while (bounds.peek() != MARKER)
			bounds.pop();
	}

	@Override
	public void enterBinders(BindersContext ctx)
	{
		state = State.BINDER;
	}

	@Override
	public void exitBinders(BindersContext ctx)
	{}

	@Override
	public void enterVariable(VariableContext ctx)
	{
		state = State.VAR;
	}

	@Override
	public void exitVariable(VariableContext ctx)
	{
		state = State.SKIP;
	}

	@Override
	public void enterConcrete(ConcreteContext ctx)
	{
		state = State.CONCRETE;
	}

	@Override
	public void exitConcrete(ConcreteContext ctx)
	{
		// TODO Auto-generated method stub
		super.exitConcrete(ctx);
	}

	@Override
	public void visitTerminal(TerminalNode node)
	{
		switch (state)
		{
			case BINDER :
				if (node.getText().equals("]"))
				{
					if (binders.size() > 0)
					{
						net.sf.crsx.Variable[] bs = new net.sf.crsx.Variable[binders.size()];
						binders.toArray(bs);
						sink3 = sink3.binds(bs);
					}
				}
				else
				{
					net.sf.crsx.Variable binder = sink3.makeVariable(node.getText(), false);
					bounds.push(binder);
					binders.add(binder);
				}
				break;
			case CONS :
				sink3 = sink3.start(sink3.makeConstructor(node.getText()));
				break;
			case SKIP :
				break;
			case METAVAR :
				sink3 = sink3.startMetaApplication(node.getText());
				break;
			case LITERAL :
				sink3 = sink3.start(sink3.makeLiteral(node.getText(), CRS.STRING_SORT));
				break;
			case VAR :
				final String varname = node.getText();
				// This is a binder occurrence. Resolve and emit
				Optional<Object> variable = bounds.stream().filter(var -> {
					if (var == MARKER)
						return false;

					return ((net.sf.crsx.Variable) var).name().equals(varname);
				}).findFirst();

				if (variable.isPresent())
				{
					// Binder exists -> emit variable use

					sink3 = sink3.use((net.sf.crsx.Variable) variable.get());
				}
				else
				{
					// Binder does not exists: emit fresh variable.

					sink3 = sink3.use(sink3.makeVariable(varname, false));
				}
				break;
			case CONCRETE :

				String text = node.getText();
				if (text.length() > 1)
				{
					// Text is of the form category⟦ concrete text ⟧
					int i = text.indexOf("⟦");
					String category = text.substring(0, i);
					text = text.substring(i + 1, text.length() - 1);

					Reader reader = new StringReader(text);

					//if (sink3 != null)
					{

						try
						{
							sink3 = factory.parser(factory).parse(
									sink3, category, reader, "", node.getSymbol().getLine(),
									node.getSymbol().getCharPositionInLine(), toCrsx3Bound());
						}
						catch (CRSException | IOException e)
						{
							throw new RuntimeException(e);
						}
					}

				}
				break;

			default :
				assert false : "Unreachable";
				break;

		}
		state = State.SKIP;
	}

	/**
	 * Convert bound variable structure to one compatible with crsx3
	 * @return
	 */
	private ExtensibleMap<String, net.sf.crsx.Variable> toCrsx3Bound()
	{
		ExtensibleMap<String, net.sf.crsx.Variable> map = new LinkedExtensibleMap<>();
		for (Object v : bounds)
		{
			if (v instanceof net.sf.crsx.Variable)
				map = map.extend(((net.sf.crsx.Variable) v).name(), (net.sf.crsx.Variable) v);
		};
		return map;
	}

}