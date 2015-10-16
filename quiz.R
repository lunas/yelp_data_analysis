source('db.R')

# Question 5: Percentage of reviews with 5 stars

reviews.count = query.result('select count(*) from reviews')
reviews5stars.count = query.result('select count (*) from reviews where stars = 5')

round((reviews5stars.count / reviews.count) * 100, 2)

# Question 7: Proportion of free wifi:

buss.rs = query('select id, business_id, name, full_address, city, state, longitude, latitude, stars, review_counts, attribs::json, open from businesses')
buss = dbFetch(buss.rs, -1)

has.wifi.attr <- function(jsontext) {
  attr <- fromJSON(jsontext)
  'Wi-Fi' %in% names(attr)
}

has.wifi <- sapply(buss$attribs, has.wifi.attr)
num.has.wifi <- sum(has.wifi)

has.wifi.attr.free <- function(jsontext) {
  attr <- fromJSON(jsontext)
  if (is.null(attr['Wi-Fi'])){
    return(FALSE)
  }
  else {
    return(attr['Wi-Fi'] == "free")
  }
}
has.wifi.free <- sapply(buss$attribs, has.wifi.attr.free)
num.has.wifi.free <- sum(has.wifi.free)

# 
num.has.wifi.free / num.has.wifi



# Question 10: user with more then 10k 'funny' compliments

funny.guy <- query.result("select * from users where (compliments->'funny')::text::int > 10000")
funny.guy[1, 'name']

# Question 11: 

sql <- "SELECT user_id, name, fans, compliments->'funny' as funny,
          CASE WHEN fans > 1 THEN 1 ELSE 0 END as has_fans,
          CASE WHEN (compliments->'funny')::text::int > 1 THEN 1 ELSE 0 END as is_funny
        FROM users"
users <- query.result(sql)

ff.tab <- table(users$has_fans, users$is_funny)
fisher.test(ff.tab)