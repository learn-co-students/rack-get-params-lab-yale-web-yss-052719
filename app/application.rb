class Application

  @@items = ["Apples","Carrots","Pears"]
  # new class array to hold items in cart
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      #create a new route /cart to respond with a cart is empty message
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        # If cart is not empty, iterate through each item and print out item
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
      elsif req.path.match(/add/)
      # Create a new route /add to add an item that is in the @@items list
        item = req.params["item"]
        # Takes in a GET param with the key item.
        if @@items.include?(item)
          # Check to see if the item is in @@items
        @@cart << item
        # Add to cart if it is
        resp.write "added #{item}"
        else
          # Return an error message if it isn't 
          resp.write "We don't have that item."
        end
      else
        resp.write "Path Not Found"
    end
      resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
