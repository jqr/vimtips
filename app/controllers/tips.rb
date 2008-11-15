class Tips < Application
  # provides :xml, :yaml, :js

  def index
    @tips = Tip.all
    display @tips
  end

  def show(id)
    @tip = Tip.get(id)
    raise NotFound unless @tip
    display @tip
  end

  def new
    only_provides :html
    @tip = Tip.new
    display @tip
  end

  def edit(id)
    only_provides :html
    @tip = Tip.get(id)
    raise NotFound unless @tip
    display @tip
  end

  def create(tip)
    @tip = Tip.new(tip)
    if @tip.save
      redirect resource(:tips), :message => {:notice => "Tip was successfully created"}
    else
      message[:error] = "Tip failed to be created"
      render :new
    end
  end

  def update(id, tip)
    @tip = Tip.get(id)
    raise NotFound unless @tip
    if @tip.update_attributes(tip)
       redirect resource(:tips), :message => { :notice => "Tip was successfully updated" }
    else
      display @tip, :edit
    end
  end

  def destroy(id)
    @tip = Tip.get(id)
    raise NotFound unless @tip
    if @tip.destroy
      redirect resource(:tips)
    else
      raise InternalServerError
    end
  end

end # Tips
