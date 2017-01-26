module ActsAsEnum
  extend ActiveSupport::Concern

  # opts = { column_name: $w[str1 str2 str3] }
  module ClassMethods
    def acts_as_enum(**opts)
      opts.each do |column, values|
        # Defining pluralized methods
        # => []
        define_singleton_method column.to_s.pluralize do
          values
        end

        values.each do |value|
          # Defining scopes
          scope value, -> { where("#{column} = ?", value) }

          # Defining "!" methods
          define_method "#{value}!" do
            send("#{column}=", value)
            save
          end

          # Defining "?" methods
          define_method "#{value}?" do
            self.send(column) == value
          end
        end
      end
    end
  end
end