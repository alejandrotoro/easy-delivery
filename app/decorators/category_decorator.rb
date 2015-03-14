class CategoryDecorator < Draper::Decorator
  delegate_all

  def decorate
    categories = object.first_level.order(name: :asc)
    category_response = []
    categories.each do |category|
      category_hash = Hash.new
      category_hash.merge!(category.attributes.slice("id", "name", "fq_id", "icon", "created_at", "level", "parent"))
      category_hash[:subcategories] = Category.second_level.where(:fq_id => category.fq_id).count
      category_response << category_hash
    end
    return category_response
  end

end
