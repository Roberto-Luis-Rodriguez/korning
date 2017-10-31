# Use this file to import the sales information into the
# the database.

require "pg"
require "csv"

def db_connection
  begin
    connection = PG.connect(dbname: "korning")
    yield(connection)
  ensure
    connection.close
  end
end

db_connection do |conn|
  csv_records = CSV.readlines('sales.csv', headers: true)
  customer_and_account_no = csv_records.map { |record| record["customer_and_account_no"] }.uniq  # get all zoning_types
  # customer_and_account_no.uniq!

customer_and_account_no.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
  'SELECT name FROM customer_and_account_no WHERE name=$1',
  [type]
  )

  if result.to_a.empty?
  sql = "INSERT INTO customer_and_account_no (name) VALUES ($1)"
  conn.exec_params(sql, [type])
    end
  end
end

product_name = csv_records.map { |record| record["product_name"] }.uniq

product_name.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM product_name WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO product_name (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

sale_date = csv_records.map { |record| record["sale_date"] }.uniq

sale_date.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM sale_date WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO sale_date (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

sale_amount = csv_records.map { |record| record["sale_amount"] }.uniq

sale_amount.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM sale_amount WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO sale_amount (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

units_sold = csv_records.map { |record| record["units_sold"] }.uniq

units_sold.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM units_sold  WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO units_sold (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

invoice_no = csv_records.map { |record| record["invoice_no"] }.uniq

invoice_no.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM invoice_no WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO invoice_no (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

invoice_frequency = csv_records.map { |record| record["invoice_frequency"] }.uniq

invoice_frequency.each do |type|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT name FROM invoice_frequency WHERE name=$1',
      [type]
    )

    if result.to_a.empty?
      sql = "INSERT INTO invoice_frequency (name) VALUES ($1)"
      conn.exec_params(sql, [type])
    end
  end
end

db_connection do |conn|
  # iterate over CSV data
  csv_records.each do |record|
    customer_and_account_no = record["customer_and_account_no"]
    product_name = record["product_name"]
    sale_date = record["sale_date"]
    sale_amount = record["sale_amount"]
    units_sold = record["units_sold"]
    invoice_no = record["invoice_no"]
    invoice_frequency = record["invoice_frequency"]

    # grab the correct foreign key values from each table
    customer_and_account_no_id = conn.exec_params(
      'SELECT id FROM customer_and_account_no WHERE name=$1',
      [customer_and_account_no]
    )[0]["id"]

    product_name_id = conn.exec_params(
      'SELECT id FROM product_name WHERE name=$1',
      [product_name]
    )[0]["id"]

    sale_date_id = conn.exec_params(
      'SELECT id FROM sale_date WHERE name=$1',
      [sale_date]
    )[0]["id"]

    sale_amount_id = conn.exec_params(
      'SELECT id FROM sale_amount WHERE name=$1',
      [sale_amount]
    )[0]["id"]

    units_sold_id = conn.exec_params(
      'SELECT id FROM units_sold WHERE name=$1',
      [units_sold]
    )[0]["id"]

    invoice_no_id = conn.exec_params(
      'SELECT id FROM invoice_no WHERE name=$1',
      [invoice_no]
    )[0]["id"]

    invoice_frequency_id = conn.exec_params(
      'SELECT id FROM invoice_frequency WHERE name=$1',
      [invoice_frequency]
    )[0]["id"]

    # insert new account record
    name = record["name"]
    conn.exec_params(
      'INSERT INTO accounts (name, customer_and_account_no, product_name, sale_date, sale_amount, units_sold, invoice_no, invoice_frequency) VALUES($1, $2, $3, $4, $5, $6, $7, $8)',
      [name, zoning_type_id, construction_type_id]
    )
    end
  end
end
