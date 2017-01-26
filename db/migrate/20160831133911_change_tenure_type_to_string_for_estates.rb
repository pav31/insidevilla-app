class ChangeTenureTypeToStringForEstates < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE tenure_type
        WHEN '0' THEN 'rent'::varchar
        WHEN '1' THEN 'sale'::varchar
      END
    SQL
    change_column_default :estates, :tenure_type, nil
    change_column :estates, :tenure_type, sql, null: false, default: 'rent'
  end

  def down
    sql = <<-SQL
      integer USING CASE tenure_type
        WHEN 'rent' THEN '0'::integer
        WHEN 'sale' THEN '1'::integer
      END
    SQL
    change_column_default :estates, :tenure_type, nil
    change_column :estates, :tenure_type, sql, null: false, default: 0
  end
end
