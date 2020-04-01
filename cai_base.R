## Set your libpaths as required

library(broom)
library(openxlsx)
# Make a list of predictors
predictors = as.list(names(train))
# Naming the "rownames" column of the coefficients so that we can use the column properly
model_coeffs <- coef(model)
model_coeffs <- data.frame(model_coeffs)
model_coeffs <- cbind(Row.Names = rownames(model_coeffs), model_coeffs)
rownames(model_coeffs) <- NULL
names(model_coeffs) <- c("term","estimate")
# Create an empty list for loop output to go into
output <- list()
# 'selected_vars1' must be a list of your predictors
# here we make 1 table per predictor by looping a filer(where) function
for (i in selected_vars1) {
  tmp <- filter(trimmed, grepl(i, term, fixed = TRUE))
  output[[i]] <- tmp
}
# create a blank workbook
wb <- createWorkbook()
# create 1 sheet per variable, each sheet is named after a variable.
lapply(seq_along(output), function(i){
  addWorksheet(wb=wb, sheetName = names(output[i]))
  writeData(wb, sheet = i, output[i][-length(output[[i]])])
})
#Save Workbook
saveWorkbook(wb, "test.xlsx", overwrite = TRUE)
