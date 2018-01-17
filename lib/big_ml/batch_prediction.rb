require 'big_ml/base'

module BigML
  class BatchPrediction < Base
    BATCH_PREDICTION_PROPERTIES = [
      :category, :code, :created, :credits, :dataset, :dataset_status,
      :description, :fields, :dataset, :model, :model_status, :name,
      :objective_field, :prediction, :prediction_path, :private, :resource,
      :source, :source_status, :status, :tags, :updated
    ]

    attr_reader *BATCH_PREDICTION_PROPERTIES

    class << self
      def create(resource, dataset, options = {})
        arguments = { dataset: dataset }
        if resource.start_with? 'model'
          arguments[:model] = resource
        elsif resource.start_with? 'ensemble'
          arguments[:ensemble] = resource
        elsif resource.start_with? 'deepnet'
          arguments[:deepnet] = resource
        else
          raise ArgumentError, "Expected model, ensemble or deepnet, got #{resource}"
        end
        response = client.post("/#{resource_name}", {}, arguments.merge(options))
        self.new(response) if response.success?
      end

      def download(id)
        response = client.get("/#{resource_name}/#{id}/download")
        response.body if response.success?
      end
    end

    def download
      self.class.download(id)
    end

  end
end
