
Template.gallery.helpers
  images: ->
    cloud = Vector.settings.cloudinary.cloud
    images = []
    for i,image of @data[@field.key]
      images.push
        image: image
        key: @field.key
        cloud: cloud
    images

Template.gallery.events
  'click .galleryDelete': (e,t) ->
    collectionName = Router.getData().collectionName
    doc = Router.getData().document
    key = @key
    name = this.image
    query = {}
    query[key] = name
    Vector.collections[collectionName].update({_id:doc._id},{$pull:query})
    Meteor.call 'remove', name.public_id
  'click .galleryFakeInput': (e) ->
    button = $(e.target)
    input = button.siblings("input")
    input.trigger("click")
  'change .galleryInput': (e) ->
    doc = @data
    key = @field.key
    max = e.srcElement.files.length
    collection = Vector.collections[@collectionName]
    count = 0
    Meteor.setTimeout (-> Vector.notifications.hold 'Loading..'), 300
    _.each(e.srcElement.files, (file) ->
      query = {}
      reader = new FileReader()
      reader.onload = (e) ->
        data = e.target.result
        Meteor.call "upload",data, (error,result) ->
          query[key] = result
          collection.update {_id:doc._id},{$push: query}
          count++
          if count is max then  Vector.notifications.send 'Finish'
      reader.onerror = (d) ->
        count++
        if count is max then Meteor.Message.release()
      reader.readAsDataURL(file)
    )
