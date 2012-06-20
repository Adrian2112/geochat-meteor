Template.messages.messages = ->
  Messages.find({place_id: Session.get("place_id")})

Template.chat.events =
  'submit #input' : (event) ->
    Messages.insert(message: $('#input input').val(), place_id: Session.get("place_id"))
    $("#input input[type=text]").val("")
    event.preventDefault()

Template.chat.show = ->
  Session.get("place_id") || false

Template.chat.place_name = ->
  Session.get("place_name")

Template.select_place.show = ->
  !Session.get("place_id")

Template.select_place.places = ->
  Session.get("show_places")

Template.select_place.events =
  'click a' : (event) ->
    Session.set("place_id", this.id)
    Session.set("place_name", this.name)
    return false

  'keyup #query' : (event) ->
    query = $("#query").val()
    Session.set("show_places", find_place(query))

  'submit .query' : (event) ->
    query = $("#query").val()
    foursquare_api({query: query})
    event.preventDefault()

