
class PeopleController < ApplicationController
  include Response

  def create
    @person = Person.new()
    data = params["dna"]
    if validate_data(data)
      @person.dna_string = JSON.generate(data)
      @person.save
      unless @person.errors&.present?
        if @person.is_mutant?
          json_response({ is_mutant: true }, :ok)
        else
          json_response({ is_mutant: false }, :forbidden)
        end
      else
        json_error_response(@person.errors.full_messages, :bad_request) 
      end
    else
      json_error_response("Invalid data", :unprocessable_entity)
    end
  end
  
  def stats
    stats = {
      count_mutant_dna: get_mutants,
      count_human_dna: get_humans,
      ratio: get_ratio
    }
    json_response(stats, :ok)
  end

  private

    def get_mutants
      Person.where(is_mutant: true)&.count
    end

    def get_humans
      Person.all&.count
    end

    def get_ratio
      get_mutants / get_humans if get_humans > 0
    end

    def validate_data(data)
      data_valid = false
      if data
        data = data
        if data.class == Array && data.length == 6 && check_data(data)
          data_valid = true
        end
      end
      data_valid
    end
  
    def check_data(data)
      check_data = true
      data&.each { |datum| check_data = false if datum.length != 6 }
      check_data
    end
end
