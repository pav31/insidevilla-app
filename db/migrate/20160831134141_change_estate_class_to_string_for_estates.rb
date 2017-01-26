class ChangeEstateClassToStringForEstates < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE estate_class
        WHEN '0' THEN 'economy'::varchar
        WHEN '1' THEN 'standard'::varchar
        WHEN '2' THEN 'premium'::varchar
        WHEN '3' THEN 'luxurious'::varchar
      END
    SQL
    change_column_default :estates, :estate_class, nil
    change_column :estates, :estate_class, sql
  end

  def down
    sql = <<-SQL
      integer USING CASE estate_class
        WHEN 'economy' THEN '0'::integer
        WHEN 'standard' THEN '1'::integer
        WHEN 'premium' THEN '2'::integer
        WHEN 'luxurious' THEN '3'::integer
      END
    SQL
    change_column_default :estates, :estate_class, nil
    change_column :estates, :estate_class, sql
  end
end
