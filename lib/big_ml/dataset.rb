require 'big_ml/base'

module BigML
  class Dataset < Base
    DATASET_PROPERTIES = [
      :category, :code, :columns, :created, :credits,
      :description, :fields, :locale, :name, :number_of_models,
      :number_of_predictions, :private, :resource, :rows, :size,
      :source, :source_status, :status, :tags, :updated
    ]

    attr_reader *DATASET_PROPERTIES

    def to_model(options = {}, body = {})
      Model.create(resource,options,body)
    end

    def to_ensemble(options = {})
      Ensemble.create(resource,options)
    end

    def to_deepnet(options = {})
      Deepnet.create(resource,options)
    end

    def to_optiml(options = {})
      OptiML.create(resource,{},options)
    end

    def train_test_split(sample_rate = 0.8, train_set_name = "Training", test_set_name = "Test")
      body = {
        :origin_dataset => self.resource,
        :sample_rate => sample_rate,
        :seed => SecureRandom.urlsafe_base64(nil, false)
      }
      train_set = Dataset.create_with_body(body.merge(
        :name => "#{self.name} | #{train_set_name} (#{(sample_rate*100).to_i}%)"))
      test_set = Dataset.create_with_body(body.merge(
        :name => "#{self.name} | #{test_set_name} (#{(100 - sample_rate*100).to_i}%)",
        :out_of_bag => true))

      return {:train_set => train_set.resource.split('/').last, :test_set => test_set.resource.split('/').last}

    end

    class << self
      def create(source, options = {})
        response = client.post("/#{resource_name}", options, { :source => source })
        self.new(response) if response.success?
      end
      def create_with_body(body, options = {})
        response = client.post("/#{resource_name}", options, body)
        self.new(response) if response.success?
      end

    end
  end
end
