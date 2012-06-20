#setea los attributos de location
lat = null
lon = null
success = (position) ->
  lat = position.coords.latitude
  lon = position.coords.longitude

  #peticion de lugares a foursqueare
  $.ajax({
    url: "https://api.foursquare.com/v2/venues/search",
    data: "ll=#{lat},#{lon}&client_id=IHMMPIGOYA2LOITCNDCUFNTHWLERW0MLTGB2CGINJCZT03V4&client_secret=OVSYIKEBFTRPYCVBDBT0LMHO3I23Z0JIHOQTBYZ02YPFLOQD&v=20120620&limit=50",
    dataType: "json",
    success: (data) ->
      places = $.map data.response.venues, (e, i) ->
        {name: e.name, id: e.id}

      Session.set("foursquare_places", places)
      Session.set("show_places", places)
  })

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
