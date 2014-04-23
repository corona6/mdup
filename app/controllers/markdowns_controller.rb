class MarkdownsController < ApplicationController
  before_action :set_markdown, only: [:show, :edit, :destroy]
  before_action :set_markdown_id, only: [:update, :destroy]

  # GET /markdowns
  # GET /markdowns.json
  def index
    @markdowns = Markdown.all
  end

  # GET /markdowns/1
  # GET /markdowns/1.json
  def show
  end

  # GET /markdowns/new
  def new
    @markdown = Markdown.new
  end

  # GET /markdowns/1/edit
  def edit
  end

  # POST /markdowns
  # POST /markdowns.json
  def create
    markdown = params[:data]
    a = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    code = (
             Array.new(8) do
               a[rand(a.size)]
             end
            ).join
    @markdown = Markdown.new
    @markdown.key = code
    @markdown.data = markdown.read
    @markdown.pass = params[:markdown][:pass]

    respond_to do |format|
      if @markdown.save
        format.html { redirect_to @markdown, notice: 'Markdown was successfully created.' }
        format.json { render action: 'show', status: :created, location: @markdown }
      else
        format.html { render action: 'new' }
        format.json { render json: @markdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markdowns/1
  # PATCH/PUT /markdowns/1.json
  def update
    respond_to do |format|
      if @markdown.pass == params[:markdown][:pass] && @markdown.update_attribute(:data, params[:data].read)
        format.html { redirect_to @markdown, notice: 'Markdown was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @markdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markdowns/1
  # DELETE /markdowns/1.json
  def destroy
    if @markdown.pass == params[:markdown][:pass]
      @markdown.destroy
      respond_to do |format|
        format.html { redirect_to markdowns_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_markdown
      @markdown = Markdown.find_by(key: params[:id])
    end

    def set_markdown_id
      @markdown = Markdown.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def markdown_params
      params.require(:markdown).permit(:key, :data, :pass)
    end
end
