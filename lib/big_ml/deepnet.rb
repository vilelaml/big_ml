require 'big_ml/base'

module BigML
  class Deepnet < Base
    DEEPNET_PROPERTIES = [
      :category, :code, :columns, :created, :credits,
      :dataset, :dataset_status, :description, :dev, :excluded_fields,
      :fields, :fields_meta, :importance,
      :input_fields, :locale, :max_columns, :max_rows, :name,
      :number_of_batchpredictions, :number_of_evaluations,
      :number_of_predictions, :objective_field, :objective_field_name,
      :ordering, :out_of_bag, :price, :private, :project, :range,
      :replacement, :resource, :rows, :sample_rate, :shared,
      :size, :source, :source_status, :status, :subscription, :tags, :updated
    ]

    attr_reader *DEEPNET_PROPERTIES

    def to_prediction(options)
      Prediction.create(resource, options)
    end

    def evaluate(dataset,options = {})
      Evaluation.create(self.resource,dataset,options)
    end

    class << self
      def create(dataset, options = {})
        response = client.post("/#{resource_name}", {}, options.merge(dataset: dataset))
        self.new(response) if response.success?
      end
    end
  end
end
