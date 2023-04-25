# frozen_string_literal: true

class SitesController < ApplicationController
  before_action :set_site, only: %i[show edit update destroy]

  def index
     if params[:keyword].present?
        @sites = Site.search(params[:keyword]).order(updated_at: :desc).page(params[:page])
     else
        @sites = Site.order(updated_at: :desc).page(params[:page])
     end
    if  @sites.empty?
        flash.now[:alert] = '沒有找到符合條件的景點' and return
    end
     @site_type = @sites.map { |site|
      if site.site_types.present?
      site.site_types
      end
    }
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_parames)
    if @site.save
      redirect_to sites_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show;
  end

  def edit;
  end

  def update
    if @site.update(site_parames)
      redirect_to sites_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    set_site
    @site.destroy
    redirect_to sites_path, notice: '已刪除!'
  end

  private

  def set_site
    @site = Site.find(params[:id])
  end

  def site_parames
    params.require(:site).permit(:name, :website, :address, :image, :parking, :tel, :latitude, :longitude, :stay_duration, :intro, :pet_freindly, site_types: [])
  end
end