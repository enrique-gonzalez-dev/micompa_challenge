# README


* Ruby version '2.6.6'
* Rails version '~> 6.0.4', '>= 6.0.4.7'

* Configuration

run ``` bundle install ```

* Database creation

  run ``` bundle exec rails db:create ```

  run ``` bundle exec rails db:migrate ```

* Deployment

  run ``` bundle exec rails s ```

**Using API**

* **POST /mutant**

  Requirements:
    Body: { "data" : [ "TATAAA", "TTTAAC", "TAGGAA", "TAGGCA", "AGACCA", "TACCAG" ] }
    
    Headers: { "Authorization" : "API_KEY" }
    
    Format: JSON
    
    **Responses**
    * 200 : Is mutant
    * 403 : Is not mutant
    * 400 : Invalid DNA String

* **GET /stats**

  Requirements:
  
    Headers: { "Authorization" : "API_KEY" }
    
    Format: JSON
    
    **Responses**
    * 200 : ok
 
    body: { "count_mutant_dna": 6, "count_human_dna": 11, "ratio": 0.5454545454545454 }
    
    
    
**To get API_KEY go to: /get_api_key?duration="add_duration_days"**
