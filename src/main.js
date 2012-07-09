requirejs.config({
    paths: {
        'backbone': 'vendor/backbone',
        'coffee-script': 'vendor/coffee-script',
        'cs': 'vendor/cs',
        'Handlebars': 'vendor/Handlebars',
        'hbs': 'vendor/hbs',
        'jquery': 'vendor/jquery',
        'underscore': 'vendor/underscore'
    },

    shim: {
        backbone: {
            deps: ['jquery', 'underscore'],
            exports: 'Backbone'
        },
        jquery: {
            exports: '$'
        },
        underscore: {
            exports: '_'
        }
    },

    hbs: {
        disableI18n: true,
        templateExtension: 'handlebars',
        helperPathCallback: function(name) {
            "templates/helpers/#{name}"
        }
    }
});

require(['cs!app'], function(app) {
    app.start();
});