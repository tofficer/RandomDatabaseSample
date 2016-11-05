import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Random;
import java.lang.StringBuilder;

public class RandomSample {

	String[] user_query;
	double k;
	String new_table_name;
	long seed;
	Connection conn;
	Statement st;

	public RandomSample(String[] user_query, double k, long seed, String new_table_name, String psql_url) {
		this.user_query = user_query;
		this.k = k;
		this.new_table_name = new_table_name;
		this.seed = seed;
		this.conn = DriverManager.getConnection(psql_url);
		this.st = conn.createStatement();
	}
	
	public void execute() throws SQLException {
		//create new table on query that is numbered by rows --> most expensive part of program
		for (int i = 0; i <= user_query.length-2; i++) st.executeUpdate(user_query[i]);
		st.executeUpdate("CREATE TABLE " + new_table_name + " AS (SELECT row_number() over () as rownum, * FROM (" + user_query[user_query.length-1] + ") AS sq1);");
		
		int n = getCount();
		getRandomRows(n);
		
		st.executeUpdate("ALTER TABLE " + new_table_name + " DROP COLUMN rownum;");
		
		if (new_table_name.equals("PrintThenDeleteTable")) printResults();
		
		st.close();
		conn.close();
	}
	
	public int getCount() {
		int n = 0;
		ResultSet rs = st.executeQuery("SELECT count(*) FROM " + new_table_name + ";");
		while (rs.next()) n = rs.getInt(1);
		
		return n;
	}
	
	//choose k from n
	public void getRandomRows(double n) {
		if (k >= n) {
			System.out.println("The sample size you chose is >= the size of the table/query you requested");
			return;
		}
		
		double m = 0; //number selected so far
		double t = 0; //number seen so far
		Random rand = new Random(seed);
		
		StringBuilder sb = new StringBuilder("(");
		while (m < k) {
			double u = rand.nextDouble();

			if ((n-t)*u < (k-m)) {
				m++;
				int row = (int) t+1;
				sb.append(row);
				if (m != k) sb.append(",");
			}
			t++;
		}
		sb.append(")");
		
		st.executeUpdate("DELETE FROM " + new_table_name + " WHERE rownum NOT IN " + sb.toString() + ";");
	}

	public void printResults() throws SQLException {
		ResultSet rs = st.executeQuery("SELECT * FROM PrintThenDeleteTable;");
		st.executeUpdate("DROP TABLE IF EXISTS PrintThenDeleteTable;");
		ResultSetMetaData rsmd = rs.getMetaData();
		int col_count = rsmd.getColumnCount(); 

		while (rs.next()) {
			for (int i = 1; i <= col_count; i++) {
				if (i > 1) System.out.print(", ");
				System.out.print(rsmd.getColumnName(i) + " " + rs.getString(i));
			}
			System.out.println("");
		}
		
		rs.close();
	}
}
