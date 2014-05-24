class UrlsController < ApplicationController
  before_action :set_url, only: [:edit, :update, :destroy, :redirect]

  # redirection
  def redirect
    if @url
      # increment view count
      @url.update(views: @url.views + 1)
      redirect_to @url.href, status: 301
    else
      index
      redirect_to Url, notice: params[:id].to_s + ' does not exist'
    end
  end

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  def show
    redirect_to Url, notice: "URL updated!"
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)

    # if alias is left blank, then we should reuse the alias if one is already created
    if @url.alias.chomp.empty?
      result = Url.find_by href: @url.href
      if not result.nil?
        @url = result
        redirect_to @url, notice: 'One is already created'
        return
      end
    end

    if @url.save
      redirect_to @url, success: 'URL was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /urls/1
  def update
    if @url.update(url_params)
      redirect_to @url, success: 'URL was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    if @url.destroy
      redirect_to Url, notice: 'Url destroyed' #urls_url
    else
      redirect_to Url, notice: 'Error in destroy'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find_by(alias: params['id'])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:href, :alias, :views, :sticky)
    end
end
