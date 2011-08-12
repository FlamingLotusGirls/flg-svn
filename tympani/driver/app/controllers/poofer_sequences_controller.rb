class PooferSequencesController < ApplicationController
  # GET /poofer_sequences
  # GET /poofer_sequences.xml
  def index
    @poofer_sequences = PooferSequence.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poofer_sequences }
    end
  end

  # GET /poofer_sequences/1
  # GET /poofer_sequences/1.xml
  def show
    @poofer_sequence = PooferSequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poofer_sequence }
    end
  end

  # GET /poofer_sequences/new
  # GET /poofer_sequences/new.xml
  def new
    @poofer_sequence = PooferSequence.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poofer_sequence }
    end
  end

  # GET /poofer_sequences/1/edit
  def edit
    @poofer_sequence = PooferSequence.find(params[:id])
  end

  # POST /poofer_sequences
  # POST /poofer_sequences.xml
  def create
    @poofer_sequence = PooferSequence.new(params[:poofer_sequence])

    respond_to do |format|
      if @poofer_sequence.save
        format.html { redirect_to(@poofer_sequence, :notice => 'Poofer sequence was successfully created.') }
        format.xml  { render :xml => @poofer_sequence, :status => :created, :location => @poofer_sequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poofer_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poofer_sequences/1
  # PUT /poofer_sequences/1.xml
  def update
    @poofer_sequence = PooferSequence.find(params[:id])

    respond_to do |format|
      if @poofer_sequence.update_attributes(params[:poofer_sequence])
        format.html { redirect_to(@poofer_sequence, :notice => 'Poofer sequence was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poofer_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poofer_sequences/1
  # DELETE /poofer_sequences/1.xml
  def destroy
    @poofer_sequence = PooferSequence.find(params[:id])
    @poofer_sequence.destroy

    respond_to do |format|
      format.html { redirect_to(poofer_sequences_url) }
      format.xml  { head :ok }
    end
  end
end
