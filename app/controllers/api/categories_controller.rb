module Api
  class CategoriesController < Api::BaseController
    before_filter :get_category, except: [:index]

    def index
      # @categories = Category.first_level.order(name: :asc)
      # render json: @categories.to_json, status: 200
      decorator = CategoryDecorator.new(Category)
      categories = decorator.decorate
      render json: categories.to_json, status: 200
    end

    def get_second_level
      @categories = Category.second_level.where(:fq_id => @category.fq_id).all.order(name: :asc)
      render json: @categories.to_json, status: 200
    end

    def get_third_level
      @categories = Category.third_level.where(:fq_id => @category.fq_id).all.order(name: :asc)
      render json: @categories.to_json, status: 200
    end

    protected

      def get_category
        if params[:fq_id].nil?
          render json: {:message => "Categoria no encontrada."}, status: 404
        else
          @category = Category.where(:fq_id => params[:fq_id]).last
        end
      end

    private

      def category_params
        params.require(:category).permit(:name, :fq_id, :icon)
      end

      def query_params
        params.permit(:name, :fq_id, :icon)
      end

  end
end