class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new
    @advertisement.title = params[:advertisement][:title]
    @advertisement.copy = params[:advertisement][:copy]
    @advertisement.price = params[:advertisement][:price]

    if @advertisement.save
      flash[:notice] = "New advertisement has saved"
      redirect_to @advertisement
    else
      flash.now[:alert] = "There was an error saving a new data. Try again."
      render :new
    end
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end
end
