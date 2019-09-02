namespace :calculate_user_age do
	task :task => :environment do
		now = Date.today
		User.all.each do |u|
			if u.birth_date.present?
    		u.update(age_time: now.year - u.birth_date.year - ((now.month > u.birth_date.month || (now.month == u.birth_date.month && now.day >= u.birth_date.day)) ? 0 : 1))
				puts "#{u.age_time} age "
			else
				puts "no se pudo "
			end
		end
  end
end
