class Patron

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(another_name)
    self.name == another_name.name
  end

  def Patron.all
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    returned_patrons.each() do |patron|
      name = patron['name']
      id = patron['id'].to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def update(attributes)
    @name = attributes[:name]
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{self.id};")
  end

end
