# Load the RSQLite Library
library(RSQLite)
#ref: https://www.datacamp.com/community/tutorials/sqlite-in-r?utm_source=adwords_ppc&utm_campaignid=1455363063&utm_adgroupid=65083631748&utm_device=c&utm_keyword=&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=332602034358&utm_targetid=aud-392016246653:dsa-429603003980&utm_loc_interest_ms=&utm_loc_physical_ms=1000073&gclid=EAIaIQobChMIm6Oe-8rL8AIViRCRCh01HghXEAAYASAAEgIP0vD_BwE

#~/Documents/SIG/uba-gis-tp2-grupal/images/results/samples.sqlite 

# Create a connection to our new database, CarsDB.db
# you can check that the .db file has been created on your working directory
conn <- dbConnect(RSQLite::SQLite(), "~/Documents/SIG/uba-gis-tp2-grupal/images/results/samples.sqlite")

# Gather the first 10 rows in the cars_data table
dbGetQuery(conn, "SELECT * FROM output LIMIT 10")

verdad <- dbGetQuery(conn, "SELECT * FROM output")

summary(verdad$id3)

# Write the  dataset into a table names 
dbWriteTable(conn, "resultado", verdad)
# List all the tables available in the database
dbListTables(conn)


# Lets assume that there is some user input that asks us to look only into cars that have over 18 miles per gallon (mpg)
# and more than 6 cylinders
#mpg <-  18
#cyl <- 6
#Result <- dbGetQuery(conn, 'SELECT car_names, mpg, cyl FROM cars_data WHERE mpg >= ? AND cyl >= ?', params = c(mpg,cyl))
#Result
# Delete the column belonging to the Mazda RX4. You will see a 1 as the output.
#dbExecute(conn, "DELETE FROM cars_data WHERE car_names = 'Mazda RX4'")

# Close the database connection
dbDisconnect(conn)