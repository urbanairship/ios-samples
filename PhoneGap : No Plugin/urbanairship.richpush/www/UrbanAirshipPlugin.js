// Update (replace) token attributes
// Alias
var aliasPlugin = {
    aliasPluginFunction: function(types, success, fail) {
        return Cordova.exec(success, fail, "UrbanAirshipPlugin", "printAlias", types);
    }
};

// Tags
var tagsPlugin = {
    tagsPluginFunction: function(types, success, fail) {
        return Cordova.exec(success, fail, "UrbanAirshipPlugin", "printTags", types);
    }
};