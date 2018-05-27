require 'big_ml/base'

module BigML
  class OptiML < Base
    OPTIML_PROPERTIES = [
      :category,:code,:composites,:created,:dataset,:dataset_status,:datasets,
      :description,:updatable,:evaluations,:excluded_fields,:fields_meta,
      :input_fields,:model_count,:models,:models_meta,:name,
      :objective_field,:objective_field_details,:objective_field_name,
      :objective_field_type,:objective_fields,:optiml,:private,:project,
      :resource,:shared,:shared_clonable,:shared_hash,:sharing_key,:size,:source,
      :source_status,:status,:subscription,:tags,:test_dataset,:type,:updated
    ]

    attr_reader *OPTIML_PROPERTIES

    class << self
      def create(dataset, options = {}, body = {})
        response = client.post("/#{resource_name}", options, body.merge(:dataset => dataset))
        self.new(response) if response.success?
      end

    end
  end
end
