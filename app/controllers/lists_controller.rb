class ListsController < ApplicationController
  
  layout "two_panel_layout"
  before_filter :common_actions
  before_filter :can_access_list, :only => [:show]
  
  def common_actions
    @tags = Tag.all.map(&:name).join(", ")
  end  
  
  def can_access_list
    list = List.find_by_id(params[:id])
    if current_user 
      r = current_user.can_view_list?(list)
    else
      r = list.public?
    end
    if !r
      render :template => "lists/access_error", :layout => "application"  and return
    end
  end
  
   # {"authenticity_token"=>"ouPriOfMUkogu4Abz1PjPgIjJhI9XdX4Rp4BFkFSs+8=", "utf8"=>"\342\234\223", 
   # "id"=>"22", "email"=>"sdfds@sdsdfsd.com"}
  def create_participation_or_invitation
    @list = List.find_by_id(params[:id])
    if participant = User.find_by_email(params[:email])
      @list.add_editor!(participant)
      respond_to do |format|
        format.html { render(:partial => "lists/participant", :locals => { :participant => participant, :p => @list.participations.find_by_user_id(participant.id) })}
      end
    else
      invitation = @list.invitations.create(:email => params[:email], :role => ROLES[:editor], :inviter => current_user )
      respond_to do |format|
        format.html { render(:partial => "lists/invitation", :locals => { :invitation => invitation })}
      end
    end
  end
  
  def browse
    @lists = List.active.public.recent
    @list = @lists.first
    render  :template => "lists/browse"
  end
  
  def search
    q = params[:q]
    @lists = List.search(q, :with => {:public => true })
    @lists = @lists + List.public.tagged_with(q).to_a
    @list = @lists.first
    render  :template => "lists/browse"
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
    @lists = List.active.public.recent
    @list_item = @list.list_items.build
    @edit_mode = true
    respond_to do |format|
      format.html { request.xhr? ? render(:partial => "lists/show") : render(:template => "lists/browse") }
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    if @copy_list = List.find_by_id(params[:copy_list_id])
      @list = List.new(:title => @copy_list.title + " copy", :description => @copy_list.description, 
                       :creator => current_user, :tag_list => @copy_list.tag_list, 
                       :style => @copy_list.style, :public =>  @copy_list.public )                 
      @copy_list.list_items.each do |c_li|
        @list.list_items.build(:body => c_li.body, :creator => current_user, :position => c_li.position,  :checked_off => c_li.checked_off)
      end               
    else
      @list = List.new(:style => "numbers")
      @list.creator = current_user
      1.times { @list.list_items.build } 
    end
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
    return if !current_user.can_edit_list?(@list)
    if params[:commit] == "Delete List"
      return if !current_user.creator_for_list?(@list)
      @list.update_attribute(:state, "deleted")
      redirect_to(home_user_path(current_user), :notice => 'List was deleted.') 
    else
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
    
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      if request.xhr?
        format.html{ render :nothing => true }
      else
        format.html { redirect_to(lists_url) }  
        format.xml  { head :ok }
      end
    end
  end
end
