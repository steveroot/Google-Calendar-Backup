class SnapshotsController < ApplicationController
  # GET /snapshots
  # GET /snapshots.xml


  def parse


    require "rexml/document"
    require 'net/https'
    require 'uri'
    #include REXML
    #
  #show is a simple array for holding information about what's happening
    @show = []
    @show.push("Starts now: #{Time.now}<br />")


    #https://www.google.com/calendar/feeds/steve%40rkbb.co.uk/private-71bf8e01d284c1deeac882a763bdaa2f/full?fields=link,entry(@gd:etag,id,title,summary,published,updated)

@grablists = Grablist.all
    @grablists.each do |grabed|

      
#Get the xml feed
    uri = URI.parse(grabed.feedurl)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
file = response.body


    doc = REXML::Document.new(file)

#iterate through the xml elements, put them into the snapshot object
     doc.elements.each("feed") do |glug|
       #each entry needs to be processed and put into our dateabase
       glug.elements.each("entry") do |glog|
              logger.debug "----------New Snapshot object-----"
              @snapshot = Snapshot.new
              @snapshot.entryfull = glog.to_s

                glog.elements.each("entry") do |element|
                  #This appears on the page during processing just for
                  #information of what's been happening. We've already saved 
                  # the whole entry element
                @show.push("The title is: #{element.text}<br />")
                end
                glog.elements.each("id") do |element|
                @snapshot.entryid = element.text
                end
                glog.elements.each("title") do |element|
                @show.push("The title is: #{element.text}<br />")
                @snapshot.title = element.text
                end
                glog.elements.each("summary") do |element|
                  #this appears not to work with the composite format feed
                end
               
                glog.elements.each("published") do |element|
                  if element.text == "1900-01-01T12:00:00.000Z" then
                    #This is an empty published date, fudge it create a current
                    #millenium date.  I had one when an appointment was accepted
                    #that had been created by a user outside our domain (eg the
                    #appointment message was sent by email, probably from an
                    #outlook user
                    @snapshot.entrycreated = Time.parse("2000-06-18T06:30:00.000Z").to_s(:db)
                  else
                    @snapshot.entrycreated =  Time.parse(element.text).to_s(:db)
                  end          
                end
                glog.elements.each("updated") do |element|
                #@show.push("The updated is: #{element.text}<br />")
                @snapshot.entryupdated = Time.parse(element.text).to_s(:db)
                end
                #finally, create a key from the id and updated time, for deduplication later.
                @snapshot.dedupkey = @snapshot.entryid + @snapshot.entryupdated.to_s(:db)
              @show.push("<hr />")

        #save this snapshot object into the db (=one database row)
              @snapshot.save
      end #end of glog
    end #end of glug

    @show.push("ends now: #{Time.now}<br />")


        #take out any duplicates we just added into the database
        duplicate_groups = Snapshot.find(:all).group_by { |element| element.dedupkey }.select{ |gr| gr.last.size > 1 }
        redundant_elements = duplicate_groups.map { |group| group.last - [group.last.first] }.flatten
        redundant_elements.each(&:destroy)
    end #end of graber

  respond_to do |format|
     format.html # index.html.erb
     end
  end

  def index
    @snapshots = Snapshot.find(:all, :order => 'entryid')
    #, :conditions => "title like '%hig%'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snapshots }
    end
  end

  # GET /snapshots/1
  # GET /snapshots/1.xml
  def show
    @snapshot = Snapshot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snapshot }
    end
  end

  # GET /snapshots/new
  # GET /snapshots/new.xml
  def new
    @snapshot = Snapshot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @snapshot }
    end
  end

  # GET /snapshots/1/edit
  def edit
    @snapshot = Snapshot.find(params[:id])
  end

  # POST /snapshots
  # POST /snapshots.xml
  def create
    @snapshot = Snapshot.new(params[:snapshot])

    respond_to do |format|
      if @snapshot.save
        flash[:notice] = 'Snapshot was successfully created.'
        format.html { redirect_to(@snapshot) }
        format.xml  { render :xml => @snapshot, :status => :created, :location => @snapshot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @snapshot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /snapshots/1
  # PUT /snapshots/1.xml
  def update
    @snapshot = Snapshot.find(params[:id])

    respond_to do |format|
      if @snapshot.update_attributes(params[:snapshot])
        flash[:notice] = 'Snapshot was successfully updated.'
        format.html { redirect_to(@snapshot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snapshot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /snapshots/1
  # DELETE /snapshots/1.xml
  def destroy
    @snapshot = Snapshot.find(params[:id])
    @snapshot.destroy

    respond_to do |format|
      format.html { redirect_to(snapshots_url) }
      format.xml  { head :ok }
    end
  end
end
