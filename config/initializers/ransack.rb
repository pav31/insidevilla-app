Ransack.configure do |config|
  config.add_predicate 'gteq_price',
    arel_predicate: 'gteq',
    formatter: proc { |v| v * 100 },
    validator: proc { |v| v.present? }

  config.add_predicate 'lteq_price',
    arel_predicate: 'lteq',
    formatter: proc { |v| v * 100 },
    validator: proc { |v| v.present? }
end
