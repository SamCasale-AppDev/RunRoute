class TrailsController < ApplicationController
  def index
    matching_trails = Trail.all

    @list_of_trails = matching_trails.order({ :created_at => :desc })

    render({ :template => "trails/index.html.erb" })
  end

  def show
      

    the_id = params.fetch("path_id")

    matching_trails = Trail.where({ :id => the_id })

    @the_trail = matching_trails.at(0)

    render({ :template => "trails/show.html.erb" })
  end

  def create
    the_trail = Trail.new
    @start = params.fetch("query_route1")
    @finish = params.fetch("query_route2")

    if @start == "" or @finish == ""
      redirect_to("/routes", { :notice => "Please Enter a Starting and Ending Location" })
      
    else
   

    @url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + @start + "&destination=" + @finish +"&mode=walking&key=AIzaSyCkSAc26ecU7b7czq8Uvl8eBoOrCC55tRg"
    @raw_data = open(@url).read
    @parsed =  JSON.parse(@raw_data)
    @results=@parsed.fetch("routes")
    @first_result = @results.at(0)
    
    @legs = @first_result.fetch("legs")
    @distance = @legs[0]["distance"]
    @miles = @distance.fetch("text").to_f

   
    @map_url = "https://www.google.com/maps/dir/?api=1&origin=" + @start + "&destination=" + @finish + "&dirflg=w"
    t= params.fetch("query_pr").to_i
    @pr = Time.at(t).utc.strftime("%H:%M:%S")

    #it should be noted that comments_count has been turned into estimated duration, as I felt it was more important and didn't want to risk changing it
    @duration = @legs[0]["duration"]
    @time_to_walk = @duration.fetch("value").to_i
    
    the_trail.route = @map_url
    the_trail.name = params.fetch("query_name")
    the_trail.disc = params.fetch("query_disc")
    the_trail.length = @miles
    the_trail.pr = params.fetch("query_pr")
    the_trail.owner_id = params.fetch("query_owner_id")
    the_trail.comments_count = @time_to_walk

    

    if the_trail.valid?
      the_trail.save
      redirect_to("/routes", { :notice => "Route created successfully." })
    else
      redirect_to("/routes", { :notice => "Route failed to create successfully." })
    end

  end

  end

  def update
    the_id = params.fetch("path_id")
    the_trail = Trail.where({ :id => the_id }).at(0)
    
    @start = params.fetch("query_route1")
    @finish = params.fetch("query_route2")

    
    @url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + @start + "&destination=" + @finish +"&mode=walking&key=AIzaSyCkSAc26ecU7b7czq8Uvl8eBoOrCC55tRg"
    
    @map_url = "https://www.google.com/maps/dir/?api=1&origin=" + @start + "&destination=" + @finish + "&dirflg=w"
    
    @raw_data = open(@url).read
    @parsed =  JSON.parse(@raw_data)
    @results=@parsed.fetch("routes")
    @first_result = @results.at(0)
    
    @legs = @first_result.fetch("legs")
    @distance = @legs[0]["distance"]
    @miles = @distance.fetch("text").to_f

    @duration = @legs[0]["duration"]
    @time_to_walk = @duration.fetch("value").to_i

    the_trail.route = @map_url
    the_trail.name = params.fetch("query_name")
    the_trail.disc = params.fetch("query_disc")
    the_trail.length = @miles
    the_trail.pr = params.fetch("query_pr")
    the_trail.owner_id = params.fetch("query_owner_id")
    the_trail.comments_count = @time_to_walk
    
    if the_trail.valid?
      the_trail.save
      redirect_to("/routes/#{the_trail.id}", { :notice => "Trail updated successfully."} )
    else
      redirect_to("/routes/#{the_trail.id}", { :alert => "Trail failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_trail = Trail.where({ :id => the_id }).at(0)

    the_trail.destroy

    redirect_to("/routes", { :notice => "Trail deleted successfully."} )
  end


end
