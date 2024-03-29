# README

**Require**
* Ruby version '2.6.6'
* Rails version '~> 6.0.4', '>= 6.0.4.7'
* Postgres '14.2'

**Configuration**
Create application.yml in /config/application.yml and add enviroment variables

```
  DATABASE_NAME: "micompa_db"
  DATABASE_USERNAME: "user_postgres"
  DATABASE_PASSWORD: "pasword_postgres"
  DATABASE_HOST: "localhost"
```

run ``` bundle install ```

**Database creation**

  run ``` bundle exec rails db:create ```

  run ``` bundle exec rails db:migrate ```

**Deployment**

  run ``` bundle exec rails s ```

**Using API**

* **POST /mutant**

  Requirements:
    Body: { "dna" : [ "TATAAA", "TTTAAC", "TAGGAA", "TAGGCA", "AGACCA", "TACCAG" ] }
    
    Format: JSON
    
    **Responses**
    * 200 : Is mutant
    * 403 : Is not mutant
    * 400 : Invalid DNA String

* **GET /stats**
    
    **Responses**
    * 200 : ok
 
    body: { "count_mutant_dna": 6, "count_human_dna": 11, "ratio": 0.5454545454545454 }
    
* **Production URL**

    **[Heroku](https://micompa-challenge.herokuapp.com/)**
    
