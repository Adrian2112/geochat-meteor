#setea los attributos de location
lat = null
lon = null
success = (position) ->
  lat = position.coords.latitude
  lon = position.coords.longitude

  foursquare_api()

error = () ->
    "error"

navigator.geolocation.getCurrentPosition(success, error)

find_place = (query) ->
  places = Session.get("foursquare_places")
  re = new RegExp(query, "i")
  matched_places = []
  $.each places, (i,e) ->
    if e.name.match(re)
      matched_places.push(e)
  return matched_places

#peticion de lugares a foursqueare
foursquare_api = (params) ->

  if typeof params != typeof {}
    params = {}

  api_params = {
    client_id: "clientId"
    client_secret: "clientSecret"
    v: moment().format("YYYYmmdd")
    limit: 50
    ll: "#{lat},#{lon}"
  }
  $.extend(api_params,params)
  
  $.ajax({
    url: "https://api.foursquare.com/v2/venues/search",
    data: api_params,
    dataType: "json",
    success: (data) ->
      places = $.map data.response.venues, (e, i) ->
        {name: e.name, id: e.id}

      Session.set("foursquare_places", places)
      Session.set("show_places", places)
  })
