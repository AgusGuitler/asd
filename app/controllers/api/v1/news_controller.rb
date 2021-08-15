# frozen_string_literal: true

module Api
  module V1
    class NewsController < ApiController
      def index
      end

      def show
        render json: new, serializer: NewSerializer, status: :ok
      end

      def create
        create_new = New.create(create_new_params)

        if create_new.persisted?
          render json: create_new, serializer: NewSerializer, status: :created
        else
          render json: { errors: create_new.errors }, status: :unprocessable_entity
        end
      end

      def update
      end

      def destroy
      end

      private
        def new
          @new ||= New.find(params[:id])
        end

        def create_new_params
          params.permit(
            :name,
            :content,
            :category_id
          ).merge(user: current_user)
        end
    end
  end
end
