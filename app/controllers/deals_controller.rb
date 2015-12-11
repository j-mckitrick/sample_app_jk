class DealsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index]

  def import_photo
    if @photo_param
      photos = Photo.where(:deal_id => @deal.id)
      if photos
        photos.destroy_all
      end
      @photo = Photo.new
      @photo.image_file = @photo_param
      @photo.deal_id = @deal.id
      @photo.save
    end
  end
  
  def extract_photo
    if params[:deal][:image_file]
      params[:deal].each do |k, v|
        if k == 'image_file'
          @photo_param = params[:deal][:image_file]
          params[:deal].delete(k)
        end
      end
    end
  end

  def index
    @deals = current_user.deals.order(:name)
    return redirect_to "/developers/next-steps" if @deals.length < 1
  end

  def create
    extract_photo

    @deal = Deal.new(permitted_params.merge({ user_id: current_user.id }))
    create! do |success, failure|
      success.html {
        # This is *not* the ideal place to put this,
        # but it will work for now.
        import_photo
        flash.now[:success] = "Your proposal was created."
        redirect_to deals_path
      }
      failure.html {
        flash.now[:error] = "Your project was not created. Please address the errors listed below and try again: <br><span>#{@deal.errors.full_messages.join('<br>')}</span>"
        render :new
      }
    end
  end

  def new
    @deal = Deal.new
  end

  def update
    extract_photo

    @deal = current_user.deals.where(:id => params[:id]).first || Deal.new(permitted_params.merge({user_id: current_user.id }))

    @deal.assign_attributes(permitted_params)
    @deal.validate_project
    if @deal.save
      # This is *not* the ideal place to put this,
      # but it will work for now.
      import_photo
      flash[:success] = "Your proposal was updated."
      redirect_to deals_path
    else
      flash.now[:error] = "Your project was not updated. Please address the errors listed below and try again: <br><span>#{@deal.errors.full_messages.join('<br>')}</span>"
      render :edit
    end
  end

  def destroy
    destroy!(:info => "Your project was removed.") do |format|
      @deals = current_user.deals.order(:name)

      if @deals.length < 1
        format.html { redirect_to "/developers/next-steps" }
      else
        format.html { redirect_to deals_path }
      end
    end

  end

  def publish
    flash[:notice]="Great News!  Your deal has been published to our website."
    @deal = current_user.deals.find(params[:deal_id])
    @deal.publish
    redirect_to deal_path(@deal)
  end

  def unpublish
    @deal = current_user.deals.find(params[:deal_id])
    @deal.unpublish
    flash[:notice] = "Your deal has successfully been unpublished and will no longer appear on the public website"
    redirect_to deals_path
  end

  def show_photo
    @image_data = Photo.where(:deal_id => params[:id]).first
    @image = @image_data.binary_data
    send_data(@image, :type => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline')
  end

  protected
    def permitted_params
      params.require(:deal).permit!
    end

  private :permitted_params

end
