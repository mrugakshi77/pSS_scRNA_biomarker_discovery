# Run this locally in your my-pss-app folder
# It re-saves app_data.rds with a sparse matrix instead of dense

library(Matrix)

message("Loading existing app_data.rds...")
app_data <- readRDS("app_data.rds")

message("Original expr size: ", format(object.size(app_data$expr), units = "MB"))

# Convert dense matrix to sparse (scRNA-seq is ~90% zeros — huge savings)
app_data$expr <- Matrix(app_data$expr, sparse = TRUE)

message("Sparse expr size: ", format(object.size(app_data$expr), units = "MB"))

# Also drop all_genes if it's a large vector — app can use rownames(expr) instead
app_data$all_genes <- NULL

message("Saving slim app_data.rds...")
saveRDS(app_data, "app_data.rds", compress = "xz")
message("Done. New file size: ", round(file.size("app_data.rds")/1e6, 1), " MB")