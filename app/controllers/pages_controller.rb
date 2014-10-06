class PagesController < ApplicationController
  def show
    @page = Admin::Page.find_by_url params[:url]
  end

  def index
    @page = Admin::Page.find_by_url 'inicio'
    @ter = Admin::Page.find_by_url 'terminos'
    @inm = Admin::Page.find_by_url 'preter'

    render layout: false

  end

  def terminos
    @page = Admin::Page.find_by_url 'terminos'
    render layout: false
  end
end
