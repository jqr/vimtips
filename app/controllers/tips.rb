class Tips < Application
  # provides :xml, :yaml, :js

  before :ensure_authenticated, :exclude => :tweeted

  def index
    @tips = Tip.all
    display @tips
  end

  def tweeted
    @tips = Tip.tweeted
    @tips = @tips.select { |t| t.tweeted_at.year == params[:year].to_i } if params[:year]
    @tips = @tips.select { |t| t.tweeted_at.year == params[:year].to_i && t.tweeted_at.month == params[:month].to_i } if params[:month]
    @tips = @tips.select do |t| 
      t.tweeted_at.year == params[:year].to_i && 
        t.tweeted_at.month == params[:month].to_i &&
        t.tweeted_at.day == params[:day].to_i 
    end if params[:day]
    display @tips
  end

  def untweeted
    @tips = Tip.untweeted
    render @tips, :template => 'tips/index'
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
