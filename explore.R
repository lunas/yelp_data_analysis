source('db.R')

query.result('select count(*) from users')

# Get the 12 users with the most friends, including there number of friends
sql = "SELECT user_id, count(friend_id) 
       FROM friendships
       GROUP BY user_id
       ORDER BY count(friend_id) DESC
       LIMIT 12"

popular.users <- query.result(sql)
rs <- query(sql)

dbFetch(rs, n = 10)

buss <- query.result('sele')