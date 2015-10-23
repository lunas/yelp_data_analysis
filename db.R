require("RPostgreSQL")

# See https://github.com/rstats-db/RPostgres

make.connect <- function() {
  connection <- NULL
  connect <- function() {
    if (is.null(connection)) {
      connection <- dbConnect(RPostgres::Postgres(), dbname="yelp_production", 
                              host = "localhost", port = 5432, 
                              user = "yelp", password = "yelp")
    }
    return( connection )
  }
  return( connect )
}

connect <- make.connect()


query.result <- function(sql) {
  return( dbGetQuery(connect(), sql) )
}
query <- function(sql) {
  return ( dbSendQuery(connect(), sql) )
}

db.write.table <- function(dataframe, tablename) {
  dbWriteTable(connect(), name=tablename, value=dataframe, overwrite=TRUE, row.names=FALSE)
}
