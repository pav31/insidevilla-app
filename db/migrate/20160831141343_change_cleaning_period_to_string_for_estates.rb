class ChangeCleaningPeriodToStringForEstates < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE cleaning_period
        WHEN '0' THEN 'every_day'::varchar
        WHEN '1' THEN 'every_week'::varchar
        WHEN '2' THEN 'every_month'::varchar
        WHEN '3' THEN '2_times_a_week'::varchar
        WHEN '4' THEN '3_times_a_week'::varchar
        WHEN '5' THEN '4_times_a_week'::varchar
        WHEN '6' THEN '5_times_a_week'::varchar
        WHEN '7' THEN '6_times_a_week'::varchar
        WHEN '8' THEN '2_times_a_month'::varchar
        WHEN '9' THEN '3_times_a_month'::varchar
      END
    SQL
    change_column_default :estates, :cleaning_period, nil
    change_column :estates, :cleaning_period, sql
  end

  def down
    sql = <<-SQL
      integer USING CASE cleaning_period
        WHEN 'every_day' THEN '0'::integer
        WHEN 'every_week' THEN '1'::integer
        WHEN 'every_month' THEN '2'::integer
        WHEN '2_times_a_week' THEN '3'::integer
        WHEN '3_times_a_week' THEN '4'::integer
        WHEN '4_times_a_week' THEN '5'::integer
        WHEN '5_times_a_week' THEN '6'::integer
        WHEN '6_times_a_week' THEN '7'::integer
        WHEN '2_times_a_month' THEN '8'::integer
        WHEN '3_times_a_month' THEN '9'::integer
      END
    SQL
    change_column_default :estates, :cleaning_period, nil
    change_column :estates, :cleaning_period, sql
  end
end