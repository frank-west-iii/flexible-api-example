class Api::V1::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    render({json: @contacts}.merge(serializer_includes))
  end

  def show
    @contact = Contact.find(params[:id])
    render({json: @contact}.merge(serializer_includes))
  end

  private

  def serializer_includes
    Array(params[:includes]).reduce({}) do |results, include|
      results["include_#{include}"] = true
      results
    end
  end

  def symbolize_includes
    Array(params[:includes]).collect(&:to_sym)
  end
end
