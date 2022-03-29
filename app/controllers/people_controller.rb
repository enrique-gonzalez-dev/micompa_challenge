
class PeopleController < ApplicationController  
  before_action :set_person, only: [:show, :update, :destroy]
  before_action :data_valid, only: [:create]
  def index
    @people = Person.all
    render json: @people
  end

  def show
    render json: @person
  end

  def create
    @person = Person.new()
    if @data_valid
      data = params["data"]
      @person.dna_string = JSON.generate(data)
      @person.save
    else
      return render status: :bad_request, json: { error: "Invalid DNA string" }
    end

    if !@person.errors&.present?
      render status: :ok, json: { is_mutant: true } if @person.is_mutant?
      render status: :forbidden, json: { is_mutant: false } if !@person.is_mutant?
    else
      render status: :bad_request, json: {message: @person.errors.full_messages}
    end
  end
  
  def stats
    stats = {
      count_mutant_dna: get_mutants,
      count_human_dna: get_humans,
      ratio: get_ratio
    }
    render status: :ok, json: stats.to_json
  end

  def update
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy
  end

  def data_valid
    @data_valid = false
    if params["data"]
      data = params["data"]
      if data.class == Array && data.length == 6 && check_data(data)
        @data_valid = true
      end
    end
  end

  def check_data(data)
    check_data = true
    data&.each { |datum| check_data = false if datum.length != 6 }
    check_data
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:dna_string, :is_mutant)
    end

    def get_mutants
      Person.where(is_mutant: true)&.count
    end

    def get_humans
      Person.all&.count
    end

    def get_ratio
      get_mutants.to_f / get_humans.to_f if get_humans > 0
    end
end
