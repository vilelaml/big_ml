require 'big_ml/base'

module BigML
  class Project < Base
    PROJECT_PROPERTIES = [
      :category, :description, :name, :resource, :status, :tags
    ]

    attr_reader *PROJECT_PROPERTIES

    def add_source(url)
      Source.create(url,{},{:project => self.resource})
    end

    class << self
      def create(name,options = {})
        response = client.post("/#{resource_name}", {}, options.merge(:name => name))
        self.new(response) if response.success?
      end
    end
  end
end
