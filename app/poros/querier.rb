class Querier
  attr_reader :params, :model

  def initialize(params, model)
    @params = params
    @model = model
  end

  def self.call(params, model)
    new(params, model).query
  end
  def query
    scope = model.all
    params.each do |key, value|
      next unless model.column_names.include?(key) && value.present?

      # Customize this part to handle different types of filtering as needed
      if value.is_a?(Hash) && value.key?(:from) && value.key?(:to)
        scope = scope.where(key => value[:from]..value[:to])
      elsif value.is_a?(Array)
        scope = scope.where(key => value)
      elsif model.columns_hash[key].type == :integer
        scope = scope.where(key => value.to_i)
      else
        scope = scope.where(arel_table[key].matches("%#{value}%"))
      end
    end
    scope
  end


  private

  def arel_table
    @arel_table ||= model.arel_table
  end
end
