class ChangeEstateTypeToStringForEstates < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE estate_type
        WHEN '0' THEN 'apartment'::varchar
        WHEN '1' THEN 'villa'::varchar
        WHEN '2' THEN 'house'::varchar
        WHEN '3' THEN 'land'::varchar
      END
    SQL
    change_column_default :estates, :estate_type, nil
    change_column :estates, :estate_type, sql, null: false, default: 'apartment'
  end

  def down
    sql = <<-SQL
      integer USING CASE estate_type
        WHEN 'apartment' THEN '0'::integer
        WHEN 'villa' THEN '1'::integer
        WHEN 'house' THEN '2'::integer
        WHEN 'land' THEN '3'::integer
      END
    SQL
    change_column_default :estates, :estate_type, nil
    change_column :estates, :estate_type, sql, null: false, default: 0
  end
end
