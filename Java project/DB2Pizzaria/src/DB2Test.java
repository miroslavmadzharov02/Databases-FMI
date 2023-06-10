import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB2Test
{
private Connection connection;
private Statement statement;
private ResultSet resultSet;

public void openConnection()
{
// Step 1: Load IBM DB2 JDBC driver
	try
	{
		DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
	}
	catch(Exception cnfex)
	{
		System.out.println("Problem in loading or registering IBM DB2 JDBC driver");
		cnfex.printStackTrace();
	}

// Step 2: Opening database connection
	try
	{
	connection = DriverManager.getConnection("jdbc:db2://62.44.108.24:50000/SAMPLE", "db2admin", "db2admin");
	statement = connection.createStatement();
	}
	catch(SQLException s)
	{
		s.printStackTrace();
	}
}

public void closeConnection()
{
	try
	{
		if(null != connection)
		{
			// cleanup resources, once after processing
			resultSet.close();
			statement.close();
			// and then finally close connection
			connection.close();
		}
	}
	catch (SQLException s)
	{
	s.printStackTrace();
	}
}

public void select(String stmnt, int column)
{
    try
	{
        resultSet = statement.executeQuery(stmnt);
        String result = "";
        while(resultSet.next())
		{
        	for (int i = 1; i <= column; i++)
			{
        		result += resultSet.getString(i);
        		if (i == column) result += " \n";
        		else             result += ", ";
        	}
        }
        
        System.out.println("Executing query: " + stmnt + "\n");
        System.out.println("Result output \n");
        System.out.println("---------------------------------- \n");
        System.out.println(result);
    }
    catch (SQLException s)
    {
        s.printStackTrace();
    }
}

public void insert(String stmnt)
{
	try
	{
		statement.executeUpdate(stmnt);
	}
	catch (SQLException s)
	{
		s.printStackTrace();
	}
	
	System.out.println("Successfully inserted!");
}

  
public void delete(String stmnt)
{
   try
   {
	   statement.executeUpdate(stmnt);
   }
   catch (SQLException s)
   {
	   s.printStackTrace();
   }
   
   System.out.println("Successfully deleted!");
}

public static void main(String[] args)
{
	DB2Test db2Obj = new DB2Test();
	String stmnt = "";
	int columnsToPrint = 10;
    
	db2Obj.openConnection();
	
	stmnt = "SELECT * FROM FN3MI0700050.PIZZAORDERSVIEW ORDER BY ORDER_ID";
	db2Obj.select(stmnt, columnsToPrint);

	String nameDrink = "Java";
	double weightDrink = 0.4;
	double priceDrink = 4.99;
	stmnt = "INSERT INTO FN3MI0700050.DRINK(NAME, WEIGHT, PRICE)"
     	  + " VALUES ('" + nameDrink + "','" + weightDrink + "','" + priceDrink + "')";
	db2Obj.insert(stmnt);

	String pizzaNameToDelete = "Olives";
	stmnt = "DELETE FROM FN3MI0700050.PIZZAPRODUCT WHERE NAME = " + "'" + pizzaNameToDelete + "' ";
	db2Obj.delete(stmnt);
	
	db2Obj.closeConnection();
}
}