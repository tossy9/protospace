class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
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
  end

  def edit
    unless @prototype.user_id == current_user.id
      redirect_to ({action: :show}), alert: "Your account can not edit"
    end

    num = 0
    if @prototype.captured_images[1].nil?
      num = 3
    elsif @prototype.captured_images[2].nil?
      num = 2
    elsif @prototype.captured_images[3].nil?
      num = 1
    end

    unless num == 0 then
      1.upto(num) do |i|
        @prototype.captured_images.build
      end
    end
  end

  def update
    @prototype.update(prototype_params)
    redirect_to ({action: :show}), notice: "Prototype was successfully updated"
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
