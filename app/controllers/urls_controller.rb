class UrlsController < ApplicationController
  before_action :set_url, only: [:edit, :update, :destroy]

  # redirection
  def redirect
    @url = Url.find_by(alias: params['alias'])

    if @url
      # increment view count
      @url.update(views: @url.views + 1)
      redirect_to @url.href, status: 301
    else
      index
      redirect_to Url, error: params[:id].to_s + ' does not exist'
    end
  end

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET
  def splash
    @url = Url.new
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
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

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, success: 'Url was successfully created.' }
        format.json { render action: 'index', status: :created, location: @url }
      else
        format.html { render action: 'new' }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
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
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:href, :alias, :views)
    end
end