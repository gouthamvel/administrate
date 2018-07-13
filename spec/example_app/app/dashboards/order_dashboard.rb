require "administrate/base_dashboard"

class OrderDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(searchable: true),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    address_line_one: Field::String,
    address_line_two: Field::String,
    address_city: Field::String,
    address_state: Field::String,
    address_zip: Field::String,
    seller: Field::BelongsTo.with_options(searchable: true, searchable_field: 'name', class_name: 'Customer'),
    customer: Field::BelongsTo.with_options(searchable: true,searchable_field: 'name'),

    line_items: Field::HasMany,
    total_price: Field::Number.with_options(prefix: "$", decimals: 2),
    shipped_at: Field::DateTime,
    payments: Field::HasMany,
  }

  READ_ONLY_ATTRIBUTES = [
    :id,
    :total_price,
    :created_at,
    :updated_at,
  ]

  COLLECTION_ATTRIBUTES = [
    :id,
    :customer,
    :seller,
    :address_state,
    :total_price,
    :line_items,
    :shipped_at,
  ]

  FORM_ATTRIBUTES = ATTRIBUTE_TYPES.keys - READ_ONLY_ATTRIBUTES
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys
end
