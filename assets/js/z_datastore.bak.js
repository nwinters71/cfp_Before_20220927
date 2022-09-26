// This stores information that needs to be shared among multiple vuex components

const store = new Vuex.Store({

	state: {
		l2List: [],
		selectedL2: "AARP",
		currL3: 0,
		selectedL3s: [],
		passengerList: {},
		loyaltyVendorCodes: [],
		profileFields: [],
		currSyncSite: 10,
		currClientEmail: 0,
		currClientSetting: 0,
		currCustomField: 0,
		currClientDomain: 0,
		tsSyncSite: Date.now(),
		tsClientEmail: Date.now(),
		tsClientSetting: Date.now(),
		tsCustomField: Date.now(),
		tsClientDomain: Date.now()
	},
	mutations: {
		
	},

	actions: {
		init: function(scope) {
			console.log("Initializing data store");
			// console.log("Get Profile Fields");
			store.dispatch('getProfileFields');
			// console.log("Get Vendor Codes");
			store.dispatch('getLoyaltyVendorCodes');
		},
		emptyPassengerList: function(scope) {
			this.state.selectedL3s = [];
			this.state.passengerList = {}
		},
		updatePassengerList: function(scope, plObj) { // I don't how/why, but dispatch has a default first parameter of scope that is not passed in explicity.
			if (plObj.PROFILEID in this.state.passengerList) {
				Vue.delete(this.state.passengerList, plObj.PROFILEID);
				const index = this.state.selectedL3s.indexOf(plObj.PROFILEID);
				if (index > -1) {
				  this.state.selectedL3s.splice(index, 1);
				}
			} else {
				Vue.set(this.state.passengerList, plObj.PROFILEID, plObj)
			}
			event.stopPropagation();
		},
		getLoyaltyVendorCodes: function () {
			var tmp = {"action":"getLoyaltyVendorCodes"};
			Framework7.request.json("api/util.cfm", tmp,
				function(response) {
					store.state.loyaltyVendorCodes = response.data;
				},
				function(response) {
					console.log("Fail");
					console.log(response);
				}
			);
		},
		getProfileFields: function () {
			var tmp = {"action":"getProfileFields"};
			Framework7.request.json("api/util.cfm", tmp,
				function(response) {
					securityCheck(response);
					store.state.profileFields = response.data;
				},
				function(response) {
					console.log("Fail");
					console.log(response);
				}
			);
		},

	},
	mounted: function() {
		// *** NOTE: I don't think this gets called ***
		// console.log('Data Store has been Mounted!');
		// alert("Hi there!");
		// this.getProfileFields();
	}

});