require 'big_ml/base'

module BigML
  class Model < Base
    MODEL_PROPERTIES = [
      :category, :code, :columns, :created, :credits,
      :dataset, :dataset_status, :description, :holdout, :importance,
      :input_fields, :locale, :max_columns, :max_rows, :model,
      :name, :number_of_predictions, :objective_fields, :private,
      :range, :resource, :rows, :size, :source, :source_status,
      :status, :tags, :updated
    ]

    attr_reader *MODEL_PROPERTIES

    def to_prediction(options)
      Prediction.create(resource, options)
    end

    def evaluate(dataset,options = {})
      Evaluation.create(self.resource,dataset,options)
    end

    class << self
      def create(dataset, options = {}, body = {})
        response = client.post("/#{resource_name}", options, body.merge(:dataset => dataset))
        self.new(response) if response.success?
      end
    end
  end
end
