class GrablistsController < ApplicationController
  # GET /grablists
  # GET /grablists.xml
  def index
    @grablists = Grablist.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grablists }
    end
  end

  # GET /grablists/1
  # GET /grablists/1.xml
  def show
    @grablist = Grablist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grablist }
    end
  end

  # GET /grablists/new
  # GET /grablists/new.xml
  def new
    @grablist = Grablist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grablist }
    end
  end

  # GET /grablists/1/edit
  def edit
    @grablist = Grablist.find(params[:id])
  end

  # POST /grablists
  # POST /grablists.xml
  def create
    @grablist = Grablist.new(params[:grablist])

    respond_to do |format|
      if @grablist.save
        flash[:notice] = 'Grablist was successfully created.'
        format.html { redirect_to(@grablist) }
        format.xml  { render :xml => @grablist, :status => :created, :location => @grablist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grablist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grablists/1
  # PUT /grablists/1.xml
  def update
    @grablist = Grablist.find(params[:id])

    respond_to do |format|
      if @grablist.update_attributes(params[:grablist])
        flash[:notice] = 'Grablist was successfully updated.'
        format.html { redirect_to(@grablist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grablist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grablists/1
  # DELETE /grablists/1.xml
  def destroy
    @grablist = Grablist.find(params[:id])
    @grablist.destroy

    respond_to do |format|
      format.html { redirect_to(grablists_url) }
      format.xml  { head :ok }
    end
  end
end
