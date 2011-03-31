class ListsController < ApplicationController
  
  layout "two_panel_layout"
  before_filter :common_actions
  
  def common_actions
    @tags = Tag.all.map(&:name).join(", ")
  end  
  
   # {"authenticity_token"=>"ouPriOfMUkogu4Abz1PjPgIjJhI9XdX4Rp4BFkFSs+8=", "utf8"=>"\342\234\223", 
   # "id"=>"22", "email"=>"sdfds@sdsdfsd.com"}
  def create_participation_or_invitation
    @list = List.find_by_id(params[:id])
    if participant = User.find_by_email(params[:email])
      @list.add_editor!(participant)
    else
      # invitation
    end
    
    respond_to do |format|
      format.html { render(:partial => "lists/participant", :locals => { :participant => participant, :p => @list.participations.find_by_user_id(participant.id)})}
    end
  end
  
  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find(params[:id])
    @list_item = @list.list_items.build
    @edit_mode = true
    respond_to do |format|
      format.js { render :partial => "lists/show" }# show.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.new
    @list.creator = current_user
    1.times { @list.list_items.build } 
    @tags = Tag.all.map(&:name).join(", ")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    @list.creator = current_user
    respond_to do |format|
      if @list.save
        format.html { redirect_to(home_user_path(current_user), :notice => 'List was successfully created.') }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])
    
    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to(home_user_path(current_user, :list_id => @list.id), :notice => 'List was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
      format.xml  { head :ok }
    end
  end
end
