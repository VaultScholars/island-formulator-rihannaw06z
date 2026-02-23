class RecipesController < ApplicationController
  before_action :require_authentication
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy ]

  # GET /recipes or /recipes.json for the current user
  def index
    @recipes = current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
    # five blank ingredients for the form
    5.times { @recipe.recipe_ingredients.build }
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

      if @recipe.save
        redirect_to @recipe, notice: "Recipe was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!
    redirect_to recipes_url, notice: "Recipe was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end

    # Ingredient attributes are nested in the recipe form, so we need to permit them here as well.
    def recipe_params
      params.require(:recipe).permit(
      :title,
      :product_type,
      :method,
      :photo,
      recipe_ingredients_attributes: [ :id, :ingredient_id, :quantity, :_destroy ]
      )
    end
end
