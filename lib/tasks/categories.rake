desc "Get all the Foursquare categories and subcategories"
task :get_fq_categories => :environment do
	client = Foursquare2::Client.new(:client_id => Figaro.env.fq_key, :client_secret => Figaro.env.fq_secret, :api_version => Figaro.env.fq_api_version, :locale => 'es')
	response = client.venue_categories

	response.each do |cat_level_1|
		icon = cat_level_1.icon.prefix + cat_level_1.icon.suffix
		c = Category.new(:name => cat_level_1.name, :fq_id => cat_level_1.id, :icon => icon, :level => 1, :parent => nil) if Category.where(:fq_id => cat_level_1.id).last.nil?
		if c.save
			puts "Categoría de primer nivel #{c.name} guardada"
		else
			puts "Categoría de primer nivel #{c.name} no se pudo guardar"
		end

		if cat_level_1.categories.count > 0
			cat_level_1.categories.each do |cat_level_2|
				icon = cat_level_2.icon.prefix + cat_level_2.icon.suffix
				c = Category.new(:name => cat_level_2.name, :fq_id => cat_level_2.id, :icon => icon, :level => 2, :parent => cat_level_1.id) if Category.where(:fq_id => cat_level_2.id).last.nil?
				if c.save
					puts "Categoría de segundo nivel #{c.name} guardada"
				else
					puts "Categoría de segundo nivel #{c.name} no se pudo guardar"
				end

				if cat_level_2.categories.count > 0
					cat_level_2.categories.each do |cat_level_3|
						icon = cat_level_3.icon.prefix + cat_level_3.icon.suffix
						c = Category.new(:name => cat_level_3.name, :fq_id => cat_level_3.id, :icon => icon, :level => 3, :parent => cat_level_2.id) if Category.where(:fq_id => cat_level_3.id).last.nil?
						if c.save
							puts "Categoría de tercer nivel #{c.name} guardada"
						else
							puts "Categoría de tercer nivel #{c.name} no se pudo guardar"
						end
					end
				end
			end
		end
	end
end

