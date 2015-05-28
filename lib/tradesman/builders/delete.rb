module Tradesman
  module Builders
    class Delete < Base
      private

      def template_class(args)
        Class.new do
          include ::Tzu
          include ::Tzu::Validation

          class << self
            attr_reader :store

            def adapter
              Tradesman.adapter.new(store)
            end
          end

          @store = Tradesman.adapter.context_for_entity(args[:subject])

          def call(params)
            self.class.adapter.delete!(params[:id])
          rescue Horza::Errors::RecordNotFound => e
            invalid! e
          end
        end
      end
    end
  end
end
