## ClassRegApp Web
 - The  `RegistrationApiService`  class is calls the api to retrieve the data.    
	  -   The  `GetRegistrationsAsync`  method fetches class registrations from the specified API endpoint, deserializes the response using  `System.Text.Json`, and handles exceptions.
    -   It uses an  `HttpClient`  instance created via dependency injection.
	- It uses `GetFromJsonAsync`to retrieve and deserialise the data from the API.
- Home controller calls the service and returns the Home.cshtml to present the data with a simple table.

## ClassRegApp API
- The `ClassRegistrationController` handes api requests and database interaction using dbcontext.
- It interacts with the database context (`ClassRegDbContext`) to execute a SQL query to execute the stored procedure ClassRegistrationReport.

## Docker Setup

### Service Definitions:
- There are three services defined:  `classregapp.web`,  `classregapp.api`, and  `database`.
-   Dependencies are set for  `classregapp.web`  to wait for  `database`  and  `classregapp.api`  to be up before starting.
### Database Configuration
-  The `database` service is built from the docker file located at `/Docker/db.dockerfile`
-   The entry point runs  `/src/create-db.sh` which creates the database schema and stored procedure.
### Application Services
- `classregapp.web`  and  `classregapp.api`  are built from their dockerfile which exposes the ports, restores dependencies and starts the service.