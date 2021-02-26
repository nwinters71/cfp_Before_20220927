// This stores information that needs to be shared among multiple vuex components

const store = new Vuex.Store({

	state: {
		mySchoolList: [{"hello":"world"},{"hello1":"world1"},{"hello2":"world2"}],
		mySchoolCodes: ["xxxxx","jrbeu"],
		currSchoolCode: "jrbeu",
		currSchoolIndex: 0,
	},
	mutations: {
		
	},
	actions: {
		init: function(scope) {
			// console.log("Initializing data store");
			// console.log("Get Profile Fields");
			// store.dispatch('getProfileFields');
			// console.log("Get Vendor Codes");
			// store.dispatch('getLoyaltyVendorCodes');
		},
		emptyMySchoolList: function(scope) {
			this.state.mySchoolCodes = [];
			this.state.mySchoolList = [];
		},
		getMySchoolsList: function () {
			// console.log("GETTING MY SCHOOLS LIST");
			var params = {"action":"myschools"};
			$.ajax({
				url:"api/search.cfm",
				dataType: "json",
				type: "get",
				data: params
			})
			.done(function(data) {
				// console.log("get myschools: ");
				// console.log(data);
				store.state.mySchoolList = JSON.parse(JSON.stringify(data));
				store.state.mySchoolCodes = [];
				for (let d in data) {
					// Vue.set(store.state.mySchoolList, data[d].SchoolCode, data[d]);
					store.state.mySchoolCodes.push(data[d].SchoolCode);
				}
				store.state.currSchoolCode = store.state.mySchoolCodes[0];
				store.state.mySchoolList.$watch
				// $("#tabMySchools").trigger("click");
			});
		},
		updateMySchoolList: function(scope, msObj) { // I don't how/why, but dispatch has a default first parameter of scope that is not passed in explicity.
			// console.log("updateMySchoolList...");
			// console.log(msObj);
			let params = {};
			params.type = "school";
			params.schoolcode = msObj.SchoolCode;

			if (this.state.mySchoolCodes.includes(msObj.SchoolCode)) {
				// console.log(" remove school");
				params.action = 'remove';
			} else {
				// console.log(" add school");
				params.action = 'add';			
				// Vue.set(this.state.mySchoolList, msObj.SchoolCode, msObj)
			}

			// Save to database
			$.ajax({
				url:"api/faves.cfm",
				data:params,
				type:"post",
				success: function(data) {
					store.dispatch('getMySchoolsList');
				}
			});
			// event.stopPropagation();
		},
	},
	mounted: function() {
		// *** NOTE: I don't think this gets called ***
		// console.log('Data Store has been Mounted!');
		// store.dispatch('getMySchoolsList');
		// console.log('Data Store has been Mounted2!');
		// alert("Hi there!");
		// this.getProfileFields();
	}

});


