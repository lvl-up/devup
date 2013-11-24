module GSettings
  class << self
    def schemas
      @schemas ||= {}
    end

    def load_schema user, schema_name
      puts "loading #{schema_name}"
      schemas[schema_name] ||= run(%Q{sudo -u #{user} -i gsettings list-keys #{schema_name}}).split("\n")
      schemas[schema_name]
    end

    def key user, schemas, value
      schemas.each do |schema|
        #TODO cache values?
        key = load_schema(user, schema).find do |key|
          ["['#{value}']", "'#{value}'"].include?(run(%Q{sudo -u #{user} -i gsettings get #{schema} #{key}}).chomp)
        end
        return key if key
      end
      nil
    end

    def clear(user, schemas, key)
      schemas.each do |schema|
        load_schema(user, schema)
      end
      schemas().each do |name, keys|
        puts "name is: #{name}"
        if keys.include?(key)
          run(%Q{sudo -u #{user} -i dbus-launch gsettings set #{name} #{key} "[]"})
          break
        end
      end

    end

    private
    def run command
      puts "running #{command}"
      `#{command}`
    end

  end
end