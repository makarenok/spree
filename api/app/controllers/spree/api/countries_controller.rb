module Spree
  module Api
    class CountriesController < Spree::Api::BaseController

      def index
        @countries = Country.accessible_by(current_ability, :read).ransack(params[:q]).result.
                     includes(:states).order('name ASC').
                     page(params[:page]).per(params[:per_page])
        country = Country.order("updated_at ASC").last
        if stale?(country)
          respond_with(@countries)
        end
      end

      def show
        @country = Country.accessible_by(current_ability, :read).find(params[:id])
        respond_with(@country)
      end
    end
  end
end
