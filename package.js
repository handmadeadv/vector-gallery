Package.describe({
  summary: "Vector gallery",
  environments: ['client', 'server'] // optional. Supposedly specifies environments to load package, but i did not find any package that specifies this key.
});

Npm.depends({
  cloudinary: "1.0.5"});

Package.on_use(function (api, where){

  api.use(['coffeescript','underscore'], ['client','server']);
  api.use(['templating','stylus','handlebars','iron-router','vector'], 'client');

  api.add_files([
    'methods.coffee',], 'server');

  api.add_files([
    'fields.html',
    'fields.coffee',], 'client');

});