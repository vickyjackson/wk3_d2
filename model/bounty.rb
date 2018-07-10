require('pry-byebug')
require('pg')

class Bounty

  # attr_reader :name, :species, :danger_level, :bounty_value
  attr_writer :name, :species, :danger_level, :bounty_value

  # Initialise with options
  def initialize(options)
    @name = options['name'] if options['name']
    @species = options['species']
    @danger_level = options['danger_level']
    @bounty_value = options['bounty_value']
  end

  # Create
  def save
    # connect to DB
    db = PG.connect( { dbname: 'bounty_hunters', host: 'localhost' } )
    sql = "INSERT INTO bounty_hunters (name, species, danger_level, bounty_value) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@name, @species, @danger_level, @bounty_value]
    db.prepare( "save" ,sql)
    hashes = db.exec_prepared("save", values)

    @id = hashes.first['id'].to_i
    # disconnect from DB
    db.close()
  end

  # Read

  def Bounty.all_names(name)
    db = PG.connect ({ dbname: 'bounty_hunters', host: 'localhost' })
    sql = "SELECT * FROM bounty_hunters WHERE name = $1"
    values = [ name ]
    db.prepare("all_names", sql)
    orders_array_of_name_hashes = db.exec_prepared("all_names", values)
    db.close()
    orders_array_of_objects = orders_array_of_name_hashes.map { |db_result| Bounty.new(db_result) }
    return orders_array_of_objects
  end

  def Bounty.all_ids(id)
    db = PG.connect ({ dbname: 'bounty_hunters', host: 'localhost' })
    sql = "SELECT * FROM bounty_hunters WHERE id = $1"
    values = [ id ]
    db.prepare("all_ids", sql)
    orders_array_of_name_hashes = db.exec_prepared("all_ids", values)
    db.close()
    orders_array_of_objects = orders_array_of_name_hashes.map { |db_result| Bounty.new(db_result) }
    return orders_array_of_objects
  end

  # Update
  def update()
    db = PG.connect ({ dbname: 'bounty_hunters', host: 'localhost' } )
    sql = "UPDATE bounty_hunters SET (name, species, danger_level, bounty_value) = ($1,$2,$3,$4) WHERE id = $5"
    values = [ @name, @species, @danger_level, @bounty_value , @id]
    db.prepare( "update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  # Delete
  def delete()
    db = PG.connect ({ dbname: 'bounty_hunters', host: 'localhost' } )
    sql = "DELETE FROM bounty_hunters WHERE id = $1"
    values = [ @id ]
    db.prepare( "delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

end
