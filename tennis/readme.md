# Tennis Data

- Download the tennis data from <https://archive.ics.uci.edu/ml/machine-learning-databases/00300/Tennis-Major-Tournaments-Match-Statistics.zip>.  Details at <https://archive.ics.uci.edu/ml/datasets/Tennis+Major+Tournament+Match+Statistics>.

- Modify `BASE_DIR` in `preprocessing.py` to where the unzipped tennis data is stored on your local machine.

- Run `preprocessing.py` to clean up the missing values in the CSV files (the SQL import chokes on the "NA"s in integer columns).

- Change the paths in `import.sql` to where the sanitized tennis data is stored on your local machine.

- Run `import.sql` to create table schemas and import the CSV files.

- Run `aggregate.sql` to combine the tournament data into aggregate table views.

```bash
# create a new database
createdb tennis
# import data into the tennis database
psql -f import.sql tennis
# create aggregate table views
psql -f aggregate.sql tennis
```
