class ChangeRegionToStringForEstates < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE region
        WHEN '0' THEN 'phuket_town'::varchar
        WHEN '1' THEN 'kathu'::varchar
        WHEN '2' THEN 'panwa'::varchar
        WHEN '3' THEN 'chalong'::varchar
        WHEN '4' THEN 'rawai'::varchar
        WHEN '5' THEN 'nai_harn'::varchar
        WHEN '6' THEN 'kata'::varchar
        WHEN '7' THEN 'karon'::varchar
        WHEN '8' THEN 'patong'::varchar
        WHEN '9' THEN 'kalim'::varchar
        WHEN '10' THEN 'kamala'::varchar
        WHEN '11' THEN 'bang_tao'::varchar
        WHEN '12' THEN 'surin'::varchar
        ELSE 'phuket_town'::varchar
      END
    SQL
    change_column_default :estates, :region, nil
    change_column :estates, :region, sql
  end

  def down
    sql = <<-SQL
      integer USING CASE region
        WHEN 'phuket_town' THEN '0'::integer
        WHEN 'kathu' THEN '1'::integer
        WHEN 'panwa' THEN '2'::integer
        WHEN 'chalong' THEN '3'::integer
        WHEN 'rawai' THEN '4'::integer
        WHEN 'nai_harn' THEN '5'::integer
        WHEN 'kata' THEN '6'::integer
        WHEN 'karon' THEN '7'::integer
        WHEN 'patong' THEN '8'::integer
        WHEN 'kalim' THEN '9'::integer
        WHEN 'kamala' THEN '10'::integer
        WHEN 'bang_tao' THEN '11'::integer
        WHEN 'surin' THEN '12'::integer
        ELSE '0'::integer
      END
    SQL
    change_column_default :estates, :region, nil
    change_column :estates, :region, sql, null: false, default: 0
  end
end
