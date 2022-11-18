# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :tag, only: %i[edit update destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
    authorize @tag
  end

  def create
    @tag = Tag.new(tag_params)
    authorize @tag
    if @tag.save
      redirect_to tags_path , notice: 'Tag was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @tag
  end

  def update
    authorize @tag
    if tag.update(tag_params)
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    authorize @tag
    tag.destroy

    redirect_to tags_path
  end

  private

  def tag
    @tag ||= Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :avatar)
  end
end
