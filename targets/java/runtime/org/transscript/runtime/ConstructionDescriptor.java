// Copyright (c) 2014-2016 IBM Corporation.

package org.transscript.runtime;

import java.lang.reflect.Method;
import java.util.Arrays;

/**
 * Represent a construction type.
 * 
 * @author villardl
 */
public interface ConstructionDescriptor
{
	/**
	 * @return A construction instance
	 */
	public Construction make();

	/**
	 * @return Construction symbol.
	 */
	public String symbol();

	/**
	 * @return Whether this construction represents a Function.
	 */
	public boolean isFunction();

	/**
	 * Evaluates function and send result to sink.
	 * 
	 * @param sink send the result to
	 * @param term thunk to evaluate. The reference is consumed only  when evaluation succeed.
	 * 
	 * @return true is evaluation succeeded, false otherwise. 
	 */
	public boolean step(Sink sink, Term term);

	/**
	 * @return The number of subterms
	 */
	public int arity();

	// Static helpers

	/**
	 * Make a generic data descriptor
	 */
	public static ConstructionDescriptor makeData(String symbol)
	{
		return new DataDescriptor(symbol);
	}
	
	/**
	 * Make a typed data descriptor
	 * @param symbol Global data symbol
	 */
	public static ConstructionDescriptor makeData(String symbol, int arity, Class<? extends Construction> clss)
	{
		return new DynamicDataDescriptor(symbol, arity, clss);
	}

	//	/**
	//	 * Make a generic function descriptor 
	//	 */
	//	public static ConstructionDescriptor makeFunction(String symbol, Step step)
	//	{
	//		return new FunctionDescriptor(symbol, step);
	//	}

	/**
	 * Make a function type.
	 */
	public static DynamicFunctionDescriptor makeFunction(String symbol, Class<?> cls, String methodName)
	{
		return new DynamicFunctionDescriptor(symbol, cls, methodName);
	}

	/**
	 * Generic Data construction.
	 */
	public static class DataDescriptor implements ConstructionDescriptor
	{
		/** Data symbol */
		protected String symbol;

		/** Data arity */
		protected int arity;

		public DataDescriptor(String symbol)
		{
			this.symbol = symbol.intern();
		}

		public DataDescriptor(String symbol, int arity)
		{
			this.symbol = symbol.intern();
			this.arity = arity;
		}

		@Override
		public String symbol()
		{
			return symbol;
		}

		@Override
		public boolean isFunction()
		{
			return false;
		}

		@Override
		public boolean step(Sink sink, Term data)
		{
			throw new RuntimeException("Data term does not have a step function");
		}

		@Override
		public Construction make()
		{
			return new GenericConstruction(this, null);
		}

		@Override
		public int arity()
		{
			return arity;
		}

	}

	/**
	 * Dynamic data construction using Java reflection API to creat new instances.
	 */
	public static class DynamicDataDescriptor extends DataDescriptor
	{
		/** The class representing value of this descriptor */
		protected Class<? extends Construction> clss;

		public DynamicDataDescriptor(String symbol, int arity, Class<? extends Construction> clss)
		{
			super(symbol, arity);

			this.clss = clss;
		}

		@Override
		public Construction make()
		{
			try
			{
				return clss.newInstance();
			}
			catch (Exception e)
			{
				throw new RuntimeException(e); // Just propagate as it's a symptom a bad code generation.
			}
		}

	}

	/**
	 * Generic Function construction.
	 */
	//	public static class FunctionDescriptor implements ConstructionDescriptor
	//	{
	//		/** Function symbol */
	//		public String symbol;
	//
	//		/** The step function */
	//		public Step step;
	//		
	//		/** Arity */
	//		protected int arity;
	//		
	//		public FunctionDescriptor(String symbol, Step step)
	//		{
	//			this.symbol = symbol.intern();
	//			this.step = step;
	//		}
	//
	//		@Override
	//		public String symbol()
	//		{
	//			return symbol;
	//		}
	//
	//		@Override
	//		public boolean isFunction()
	//		{
	//			return true;
	//		}
	//
	//		@Override
	//		public boolean step(Sink sink, Term term)
	//		{
	//			return step.run(sink, term);
	//		}
	//
	//		@Override
	//		public Construction make()
	//		{
	//			return new FixedConstruction(this, null);
	//		}
	//		
	//		@Override
	//		public int arity()
	//		{
	//			return arity;
	//		}
	//	}
	//
	/**
	 * Represent a function construction relying an Java reflection API to unwrap term arguments.
	 */
	public static class DynamicFunctionDescriptor implements ConstructionDescriptor
	{
		/** Function symbol */
		protected String symbol;

		/** The static method to invoke */
		protected Method method;

		public DynamicFunctionDescriptor(String symbol, Class<?> cls, String methodName)
		{
			this.symbol = symbol;

			// Search the static method
			method = Arrays.stream(cls.getMethods()).filter(m -> {
				return m.getName().equals(methodName);
			}).findFirst().orElse(null);

			if (method == null)
			{
				// This is a declared sort without actual rules.
				// Output a warning
				System.out.println("Warning: Function sort " + symbol + " is declared but has no rules. Ignored");
			}
			else
			{}
		}

		/**
		 * Send thunk to sink. Always return false indicating the normalizer the step failed.
		 */
		public boolean thunk(Sink sink, Object... args)
		{
			int i = 0;

			sink.start(this);

			while (i < args.length)
			{
				if (args[i] instanceof Variable)
				{
					int end = i + 1;
					while (args[end] instanceof Variable)
						end++;

					Variable[] binders = new Variable[end - i];
					for (int j = 0; j <= end - i; j++)
						binders[j] = (Variable) args[i++];

					sink.binds(binders);
				}
				else
				{
					sink.copy((Term) args[i++]);
				}
			}

			sink.end();
			return false;
		}

		@Override
		public String symbol()
		{
			return symbol;
		}

		@Override
		public boolean isFunction()
		{
			return true;
		}

		@Override
		public int arity()
		{
			return method.getParameterCount() - 1; // First arg is sink
		}

		@Override
		public boolean step(Sink sink, Term term)
		{
			assert method != null : "No method found for function " + symbol();
			Object[] args = new Object[method.getParameterCount()];

			args[0] = sink; // sink
			int argp = 1;

			for (int i = 0; i < term.arity(); i++)
			{
				Variable[] binders = term.binders(i);
				if (binders != null)
				{
					for (int j = 0; j < binders.length; j++)
						args[argp++] = binders[j];
				}
				assert argp < args.length : "Too many arguments for function " + symbol();
				args[argp++] = term.sub(i).ref();
			}

			// Remaining argument will be set to null.
			//assert argp == method.getParameterCount() : method.getName() + " not fully bound.";

			term.release(); // done with the thunk

			try
			{
				return (boolean) method.invoke(this, args);
			}
			catch (Exception e)
			{
				throw new RuntimeException(e);
			}
		}

		@Override
		public Construction make()
		{
			return new GenericConstruction(this, null);
		}
	}

	/**
	 * Represent a map construction.
	 */
	public static class MapDescriptor implements ConstructionDescriptor
	{
		protected static MapDescriptor singleton = new MapDescriptor();

		private MapDescriptor()
		{}

		@Override
		public String symbol()
		{
			return "Map";
		}

		@Override
		public boolean isFunction()
		{
			return false;
		}

		@Override
		public boolean step(Sink sink, Term data)
		{
			throw new RuntimeException("Maps do not  have step function");
		}

		@Override
		public Construction make()
		{
			return new GenericConstruction(this, null);
		}

		@Override
		public int arity()
		{
			return 0;
		}
	}

	/**
	 * Represents a step function
	 */
	//	@FunctionalInterface
	//	public interface Step
	//	{
	//		/**
	//		 * Evaluate the function term within the given context.
	//		 * 
	//		 * <p>
	//		 * When the evaluation succeeds, the function term reference has been
	//		 * consumed by the step function. Otherwise it is left untouched.
	//		 *
	//		 * @param sink send the result to
	//		 * @param term thunk to evaluate. The reference is always consumed 
	//		 * 
	//		 * @return true is evaluation succeeded, false otherwise. 
	//		 */
	//		public abstract boolean run(Sink sink, Term term);
	//	}
	//

}