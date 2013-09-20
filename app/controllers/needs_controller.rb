class NeedsController < ApplicationController
  before_filter :find_need, :only => [:show, :edit, :update]

  def index
    @needs = Need.all
  end

  def show
    # find_need
  end

  def new
    @need = Need.new
  end

  def create
    @need = Need.new(params[:need])

    modify_annotations(:new) and return if params[:annotation_action]

    if @need.save
      flash[:notice] = "Need has been created"
      redirect_to need_path(@need)
    else
      flash.now[:alert] = "There were problems creating this need. Please check the form."
      render :action => :new
    end
  end

  def edit
    # find_need
  end

  def update
    @need.assign_attributes(params[:need])

    modify_annotations(:edit) and return if params[:annotation_action]

    if @need.save
      flash[:notice] = "Need has been saved"
      redirect_to need_path(@need)
    else
      flash.now[:alert] = "There were problems updating this need. Please check the form."
      render :action => :edit
    end
  end

  private
  def find_need
    @need = Need.find(params[:id])
  end

  def modify_annotations(action)
    case params[:annotation_action]
    when "Add link"
      @need.annotations << Annotation::Link.new
    when "Add priority"
      @need.annotations << Annotation::Priority.new
    when "Add legislation"
      @need.annotations << Annotation::Legislation.new
    end

    @need.annotations.each {|a| a.errors.clear }
    render :action => action
  end
end
