import java.util.Scanner;

public class Driver2 {
	
	private static Scanner in = new Scanner(System.in);

	public static void main(String[] args) throws Exception {
		String psql_url = "jdbc:postgresql://stampy.cs.wisc.edu/cs564instr?sslfactory=org.postgresql.ssl.NonValidatingFactory&ssl";
		long seed = System.nanoTime();
		int inc = 215;
		
		boolean cont = true;
		while(cont) {
			//get query from the user
			//if query is invalid exception will be thrown
			String[] user_query = getUserQuery();

			//ask the user for the sample size
			double k = getSampleSize();

			//ask the user if they want to save the table
			//otherwise table will be named PrintThenDeleteTable, and will be deleted after the query executes
			String new_table_name = "PrintThenDeleteTable";
			if (saveResults()) {
				new_table_name = "Sample" + inc;
				System.out.println("The created table will be named: " + new_table_name);
				inc++;
			}

			//reset seed if user wants
			if (resetSeed()) {
				seed = System.nanoTime();
				System.out.println("RNG seed has been reset");
			}

			//Connect to DB and select sample rows in RandomSample class
			RandomSample sample = new RandomSample(user_query, k, seed, new_table_name, psql_url);
			sample.execute();

			System.out.println("Would you like more samples: (y/n)");
			cont = in.nextLine().trim().equals("y");

			System.out.println("");
		}
		in.close();
	}

	public static String[] getUserQuery() {
		System.out.println("Would you like to sample from a table or query? (table/query)");
		boolean q = in.nextLine().trim().equals("query");

		String[] user_query = null;
		if (q) {
			System.out.println("Enter the query: ");
			user_query = in.nextLine().split(";");
		}
		else {
			System.out.println("Enter the table name: ");
			String table_name = in.nextLine().trim();
			user_query[0] = "SELECT * FROM " + table_name + ";";
		}
		
		return user_query;
	}

	public static double getSampleSize() {			
		System.out.println("Enter how many rows you would like to sample: ");
		double k = Double.valueOf(in.nextLine().trim());
		
		return k;
	}

	public static boolean resetSeed() {
		System.out.println("Would you like to reset the seed for the RNG: (y/n)");	
		boolean reset = in.nextLine().trim().equals("y");

		return reset;
	}

	public static boolean saveResults() {
		System.out.println("Would you like to save the sample rows to a table? (y/n)");
		boolean create_table = in.nextLine().trim().equals("y");

		return create_table;
	}
}