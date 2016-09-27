run_iris_boot <- function(...) {
  iris_boot_sample <- iris[sample(1:nrow(iris), replace = TRUE),]
  lm(Sepal.Length ~ Sepal.Width + Petal.Length,
     data = iris_boot_sample)
}

set.seed(20160927)
system.time(lapply(1:1000, run_iris_boot))

# ------------------------------------------------------------------------------

library(parallel)
cores <- detectCores()
cluster <- makeCluster(cores)
clusterSetRNGStream(cluster, 20160927)
system.time(parLapply(cluster, 1:1000, run_iris_boot))
stopCluster(cluster)

system.time({
  library(parallel)
  cores <- detectCores()
  cluster <- makeCluster(cores)
  clusterSetRNGStream(cluster, 20160927)
  parLapply(cluster, 1:1000, run_iris_boot)
  stopCluster(cluster)
})

# ------------------------------------------------------------------------------

library(parallel)
cores <- detectCores()
cluster <- makeCluster(cores)
clusterSetRNGStream(cluster, 20160927)

library(MASS)
nrow(anorexia)
clusterEvalQ(cluster, nrow(anorexia))

clusterEvalQ(cluster, library(MASS))
node_results <- parSapply(cluster, 2:6, function(n_centers) {
  kmeans(anorexia[2:3], centers = n_centers, nstart = 200)$betweenss
})
final_results <- by(node_results, test_centers, median)

stopCluster(cluster)

# ------------------------------------------------------------------------------



library(parallel)
cores <- detectCores()
cluster <- makeCluster(2)

db_user <- "elizabeth"
db_user
clusterEvalQ(cluster, db_user)
clusterExport(cluster, c("db_user"))
clusterEvalQ(cluster, db_user)


clusterExport(cluster, c("db_user", "db_password", "db_host"))
clusterEvalQ(cluster, {
  db_conn <- dbConnect(pg, user=db_user, password=db_password,
                       host=db_host)
})

parLapply(cluster, raw_data_files, function(file_path) {
  df <- read.csv(file_path)
  df$y <- toupper(df$y)
  dbWriteTable(db_conn, df, )
})

stopCluster(cluster)

##   user  system elapsed
##   0.25    0.08    5.46

lapply(list.files(pattern = "^[0-9]{1,5}.csv$"), file.remove)


