class Moderation::WebsitesController < Moderation::BaseController
  def index
    @websites = Website.limit(10).order(id: :desc)
  end

  def new
    @website_form = Moderation::WebsiteForm.new
  end

  def create
    @website_form = Moderation::WebsiteForm.new(website_params, params[:commit] == "Save")

    if @website_form.valid? && params[:commit] == "Save"
      @website_form.save!

      redirect_to moderation_websites_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def website_params
    params.require(:website).permit(:url, :feed_url, :feed_title)
  end
end
