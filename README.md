# RandomDatabaseSample

The Driver class interacts with the user through the terminal. Thus, the user will only have to run "//usr/lib/jvm/default-java/bin/java-Djava.security.auth.login.config=login.config -classpath ./postgresql -8.4-703.jdbc4.jar:. Driver" to interact with the app. 

The RandomSample class accepts user input, and will either print out the requested rows or store them in a new table.

The application can randomly sample from a table already in the database or fom a query the user inputs. If sampling from a table just put the table name by itself. If sampling from a query must place the query on a single line and include semicolons.

The app can take multiple sub queries at once (i.e. if you are creating a view that you will use in a later subquery) and will display the results of the last query. Remember to place all sub queries on a single line and include semicolons for all of them.
