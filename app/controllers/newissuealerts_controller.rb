class NewissuealertsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize
  before_filter :find_newissuealert, :only => [ :edit, :update, :destroy]

  def index
    render 'projects/settings/_newissuealerts'
  end

  def new
    @newissuealert = Newissuealert.new(:project_id => @project.id )
  end

  def create
    @newissuealert = Newissuealert.new(:project_id => @project.id)
    @newissuealert.attributes = params[:newissuealert].except(:project_id)
    if @newissuealert.save
      flash[:notice] = l(:newissuealerts_creation_success)
      redirect_to settings_project_path(:id => @project, :tab => 'newissuealerts')
    else
      render :controller => :new
    end
  end

  def edit
  end

  def update
    if @newissuealert.update_attributes(params[:newissuealert])
      flash[:notice] = l(:newissuealerts_save_success)
      redirect_to settings_project_path(:id => @project, :tab => 'newissuealerts')
    else
      render :controller => :edit
    end
  end

  def destroy
    if @newissuealert.destroy
      flash[:notice] = l(:newissuealerts_deletion_success)
      redirect_to settings_project_path(:id => @project, :tab => 'newissuealerts')
    else
      flash.now[:error] = l(:newissuealerts_deletion_failed)
      redirect :back
    end
  end


  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_newissuealert
    @newissuealert = Newissuealert.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
