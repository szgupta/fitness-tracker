class Api::FoodHistoriesController < ApplicationController
  def index
    food_history = current_user.food_histories.order(created_at: desc)
    if food_history
      render json: {
        food_history: food_history
      }
    else
      render json: {
        status: 500,
        errors: ['no food history available']
      }
    end
  end

  def create
    food_history_item = current_user.food_history.new(food_history_params)
    if food_history_item.save
      render json: { food_history_item: food_history_item }
    else
      render json: { errors: food_history_item.errors }
    end
  end

  private

  def food_history_params 
    params.require(:food_history).permit(:food_id, :servings, :created_at) 
  end

end
