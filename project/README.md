# Final Project
## CompuStore sales by region

### Ángeles Hernández 
### Yair Camacho

###### Language: Elixir 

#### Project description

###### The program reads a csv file and returns a new csv file with the sum of the total sales per region

#### Problem description

###### Why program the solution instead of using an excel spreadsheet? 
###### Excel offers a friendly and intuitive interface that automates many processes throughout its default functions; it is a powerful tool for data analysis. However, it shows some disadvantages when comparing it to programming languages.
- ###### The program does not allow automatic and systematic validation of the data obtained.
- ###### How the information is presented makes it extremely difficult for third parties to discover errors.
- ###### It encourages mechanical behaviors. Sometimes, to save time, people tents to copy and paste formulas that need to be modified.

###### Advantages of using elixir over excel
###### When errors appear in excel, such as (#N/A; #VALUE!; #REF!; etc.), many times it is not obvious where the error is. Elixir lets us know exactly where the problems lie.

#### Proposed solution

###### The program reads a csv file and saves it as a matrix (a list of lists).
###### The function separates the first element of the list or row; It separates it by the different columns of the original file (store number, region, item, unit cost, quantity and month). The tail of the list is the rest of the lines and since it is a recursive function (which calls itself many times, until it reads the entire file), the entire base is analyzed. Another function adds the quantity multiplied by the price per region. And finally, it creates another csv file with the totals per region.

#### How to use the program

###### The program works specifically for CompuStore sales, which has three regions.

###### The store records the data month by month, so, each month, they must feed the program with a CSV file.

###### To run it, you must open the terminal, open the Elixir interactive interface with the iex command and then load the file containing the program, in this case, iex> c "Project.ex". Then the function main iex> "Project.main("Sales-data-CompuStore.csv", "Salesperregion_month.csv") must be called; where "Sales-data-CompuStore.csv" contains the sales for the month and, "Salesperregion_month.csv" is the new file containing the sum of sales organized by region.
