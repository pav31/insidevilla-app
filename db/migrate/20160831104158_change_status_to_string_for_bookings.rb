class ChangeStatusToStringForBookings < ActiveRecord::Migration
  def up
    sql = <<-SQL
      varchar USING CASE status
        WHEN '0' THEN 'pending'::varchar
        WHEN '1' THEN 'approved'::varchar
        WHEN '2' THEN 'completed'::varchar
        WHEN '3' THEN 'canceled'::varchar
      END
    SQL
    change_column_default :bookings, :status, nil
    change_column :bookings, :status, sql, null: false, default: 'pending'
  end

  def down
    sql = <<-SQL
      integer USING CASE status
        WHEN 'pending' THEN '0'::integer
        WHEN 'approved' THEN '1'::integer
        WHEN 'completed' THEN '2'::integer
        WHEN 'canceled' THEN '3'::integer
      END
    SQL
    change_column_default :bookings, :status, nil
    change_column :bookings, :status, sql, null: false, default: 0
  end
end
