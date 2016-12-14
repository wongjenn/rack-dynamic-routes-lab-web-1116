require 'pry'

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_item = req.path.split("/items/").last
      result = search_items(search_item)
            # binding.pry
      if result != false
        resp.write "#{result}"
      else
        resp.write("Item not found")
        resp.status = 400
      end
    else
      resp.write("Route not found")
      resp.status = 404
    end
    resp.finish
  end

  def search_items(search_item)
    @@items.find do |item|
      if item.name == search_item
        return item.price
      end
    end
    return false
  end

end
