Meteor.methods

  # upload to cloudinary
  upload: (blob) ->
    path = Npm.require 'path'
    Future = Npm.require('fibers/future')
    cloudinary = Npm.require 'cloudinary'
    future = new Future()
    cloudinary.config
      cloud_name: Vector.privateSettings.cloudinary.cloud
      api_key: Vector.privateSettings.cloudinary.key
      api_secret: Vector.privateSettings.cloudinary.secret
    cloudinary.uploader.upload(blob, (result) -> 
      future.return(result) )
    future.wait()

  # remove from cloudinary  
  remove: (id) ->
    cloudinary = Npm.require 'cloudinary'
    cloudinary.config
      cloud_name: Vector.privateSettings.cloudinary.cloud
      api_key: Vector.privateSettings.cloudinary.key
      api_secret: Vector.privateSettings.cloudinary.secret
    cloudinary.uploader.destroy id, (r) ->
      v = r
