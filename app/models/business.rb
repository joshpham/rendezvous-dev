class Business < ActiveRecord::Base
			before_validation :generate_slug			

   validates :user_id, presence: true
			validates :name, presence: true, length: { maximum: 24 }


   belongs_to :user
			has_one :phone_list, :dependent => :destroy

			def to_param
			  "#{slug}".parameterize
			end
   
 private

  def generate_slug
    self.slug = self.name.parameterize
  end

		def self.search(query)
  where("slug || name like ?", "%#{query}%") 
  end


end
