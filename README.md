# course-advanced-mysql-for-analysis-and-bi
This is a repository dedicated to the [Advanced MySQL for Analysis and BI course](https://www.udemy.com/course/advanced-sql-mysql-for-analytics-business-intelligence/).

The course is focused on advanced SQL for analysis and business intelligence, as its name suggests, **but I chose to create its own structure to maintain the portability of the course, and can run the queries at any time and even create some dashboards. Thus, outside the scope of the course, a docker application was created to**:

- **MySQL Instance**: performs the creation of the MySQL database used in the course.
- **Metabase + Postgres Instances**: I can run the queries created during the course on Metabase, and thus maintain views and insights. Postgres is the Metabase metadata database.

![containers-up](./.img/containers.png)

The entire Docker application is structured in the [compose.yaml](compose.yaml) file.
Just to streamline the container management process, the script [GO](go.sh) was created where:

- `./go.sh setup`:  
- `./go.sh start`: 
- `./go.sh stop` :
- `./go.sh down` : 
- `./go.sh bash` :  