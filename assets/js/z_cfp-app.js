// Theme: default to aurora or specify in querystring (theme=_____)
var theme = 'aurora';
if (document.location.search.indexOf('theme=') >= 0) {
  theme = document.location.search.split('theme=')[1].split('&')[0];
}

// Init App
var app = new Framework7({
  id: 'com.collegefastpass.ipeds',
  root: '#app',
  theme: theme,
  data: function () {
    return {
      user: {
        firstName: 'Bugs',
        lastName: 'Bunny',
      },
    };
  },
  methods: {
    helloWorld: function (msg) {
      // app.dialog.alert('Hello World!', 'Peekaboo');
      app.dialog.alert(msg, 'Message to ' + app.data.user.firstName);
      // alert('Hello World!');      
    },
  },
  routes: routes,
  popup: {
    closeOnEscape: true,
  },
  sheet: {
    closeOnEscape: true,
  },
  popover: {
    closeOnEscape: true,
  },
  actions: {
    closeOnEscape: true,
  },
  vi: {
    enabled: false,
    // placementId: 'pltd4o7ibb9rc653x14',
  },
});

// var mainView = app.views.create('.view-main');

// Dom7
var $$ = Dom7;

