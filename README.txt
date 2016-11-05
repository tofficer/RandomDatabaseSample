Name: Tyler Officer
Student ID: 906-624-8296
CS login: officer@cs.wisc.edu

Name: Ben Chylla
Student ID: 906-841-1264
CS login: chylla@cs.wisc.edu

The Driver2.java file interacts with the user through the terminal. Thus, the user will only have to run "//usr/lib/jvm/default-java/bin/java-Djava.security.auth.login.config=login.config -classpath ./postgresql -8.4-703.jdbc4.jar:Driver2" to interact with the app. Moreover, RandomSample.java accepts user input, and will either print out the requested rows or store them in a new table.

Furthermore, we are assuming that all queries will be placed on a single line. 
The app can take multiple sub queries at once (i.e. if you are creating a view that you will use later in an answer) and will display the results of the last query, but remember that all the queries must be place on a single line and all include semicolons. If you are just putting a table name, only put the table name without a semicolon.