json.categories @categories do |category|
  json.name          category.name
  json.fq_id         category.fq_id
  json.icon          category.icon
  json.subcategories Category.where(:fq_id => category.fq_id).all.count
end