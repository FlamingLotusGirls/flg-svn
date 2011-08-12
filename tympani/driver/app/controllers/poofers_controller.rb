class PoofersController < ApplicationController
  # GET /poofers
  # GET /poofers.xml
  def index
    @poofers = Poofer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poofers }
    end
  end

  # GET /poofers/1
  # GET /poofers/1.xml
  def show
    @poofer = Poofer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poofer }
    end
  end

  # GET /poofers/new
  # GET /poofers/new.xml
  def new
    @poofer = Poofer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poofer }
    end
  end

  # GET /poofers/1/edit
  def edit
    @poofer = Poofer.find(params[:id])
  end

  # POST /poofers
  # POST /poofers.xml
  def create
    @poofer = Poofer.new(params[:poofer])

    respond_to do |format|
      if @poofer.save
        format.html { redirect_to(@poofer, :notice => 'Poofer was successfully created.') }
        format.xml  { render :xml => @poofer, :status => :created, :location => @poofer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poofer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poofers/1
  # PUT /poofers/1.xml
  def update
    @poofer = Poofer.find(params[:id])

    respond_to do |format|
      if @poofer.update_attributes(params[:poofer])
        format.html { redirect_to(@poofer, :notice => 'Poofer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poofer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poofers/1
  # DELETE /poofers/1.xml
  def destroy
    @poofer = Poofer.find(params[:id])
    @poofer.destroy

    respond_to do |format|
      format.html { redirect_to(poofers_url) }
      format.xml  { head :ok }
    end
  end
end
