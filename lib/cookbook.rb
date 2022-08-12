require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_recipe
  end

  def find_index(index)
    @recipes[index]
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    store_recipe
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def store_recipe
    CSV.open(@csv_file, 'wb') do |row|
      @recipes.each { |recipe| row << [recipe.name, recipe.description, recipe.rating, recipe.prep_time] }
    end
  end
end
