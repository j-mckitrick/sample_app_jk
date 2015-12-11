class DealsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index]

  def import_photo
    if params[:deal][:image_file]
      params[:deal].each do |k, v|
        logger.info "Checking #{k} #{v}"
        if k == 'image_file'
          logger.info "Image file params #{params[:deal][:image_file].inspect}"
          @photo = Photo.new
          @photo.image_file = params[:deal][:image_file]
          @photo.save
          params[:deal].delete(k) 
          logger.info "DELETED #{k} #{v}"
        end
      end
    end
    logger.info "Params #{params}"
  end
  
  def index
    @deals = current_user.deals.order(:name)
    return redirect_to "/developers/next-steps" if @deals.length < 1
  end
  
  def create
    logger.info "Params #{params}"
    import_photo

    @deal = Deal.new(permitted_params.merge({ user_id: current_user.id }))
    #@deal = Deal.new(permitted_params.delete(:image_file).merge({ user_id: current_user.id }))
    #@deal = Deal.new(permitted_params.merge({ user_id: current_user.id }).reject{|k,v| k == :image_file})
    create! do |success, failure|
      success.html { 
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
    logger.info "Update params #{params}"
    logger.info "Update Params #{params[:image_file].inspect}"
    logger.info "Update Params #{params['image_file'].inspect}"
    import_photo

    @deal = current_user.deals.where(:id => params[:id]).first || Deal.new(permitted_params.merge({user_id: current_user.id }))

    @deal.assign_attributes(permitted_params)
    @deal.validate_project
    if @deal.save
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
      logger.debug("Deals: #{@deals.length}")

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
    @image_data = Photo.find(1)
    @image = @image_data.binary_data
    send_data(@image, :type => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline')
  end
  
  protected
    def permitted_params
      params.require(:deal).permit!
    end
    
  private :permitted_params
  
end
