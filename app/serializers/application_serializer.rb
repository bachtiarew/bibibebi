class ApplicationSerializer < ActiveModel::Serializer
	def initialize(object, options = {})
		options.delete(:only) if options[:only].blank?
		super
	end

	def include_attribute?(key, default: true)
		if default == true
			options[:include].nil? || options[:includes].include?(key)
		else
			options_has_key?(:includes) && options[:includes].include?(key)
		end
	end
end