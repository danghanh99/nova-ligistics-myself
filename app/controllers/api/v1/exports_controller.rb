class Api::V1::ExportsController < ApplicationController
  def create
    export = Export.create!(export_params)
    render_resource export, :created, ExportSerializer
  end

  private

  def export_params
    params.permit(:sell_price, :quantity, :description, :exported_date, :user_id, :import_id, :inventory_id, :customer_id)
  end
end
