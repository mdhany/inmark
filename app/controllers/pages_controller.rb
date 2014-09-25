class PagesController < ApplicationController
  def show
    @page = Admin::Page.find_by_url params[:url]
  end

  def index
    @page = Admin::Page.find_by_url 'inicio'
    @ter = Admin::Page.find_by_url 'terminos'

    render layout: false

  end
end
