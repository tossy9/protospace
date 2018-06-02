class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :edit, :destroy]

  def index
    @prototypes = Prototype.page(params[:page]).per(4).order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    respond_to do |format|
      format.html
      format.json { render json: @prototype}
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: :new }), alert: 'New prototype was unsuccessfully created'
    end
  end

  def show
    @comments = @prototype.comments.includes(:user)
    @comment  = @prototype.comments.build(user_id: current_user.id) if current_user
  end

  def edit
    unless @prototype.user_id == current_user.id
      redirect_to ({action: :show}), alert: "Your account can not edit"
    end
    
    sub_total = 3
    
    1.upto(sub_total) do |i|
      if @prototype.captured_images[i].nil?
        @prototype.captured_images.build
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @prototype}
    end
  end

  def update
    @prototype.update(prototype_params)
    redirect_to ({action: :show}), notice: "Prototype was successfully updated"
  end

  def destroy
    @prototype.destroy if @prototype.user_id == current_user.id
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end
end
