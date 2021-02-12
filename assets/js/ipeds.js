function vueNavIPEDS() {

	var IPEDS = new Vue({
		el: '#vueNavIPEDS',
		data: {
			// searchParams: {
			// 	ProfileType: "Profiles",
			// 	ProfileActive: "Active",
			// },
			Tables: [],
			Fields: [],
			Values: [],
			selectedTable: 0,
			selectedField: 0,
		},

		computed: {
		},
		methods: {
			sayHello: function () {
				console.log("Hi There");
			},
			getTables: function () {
				var tmp = {"action":"tables"};
				Framework7.request.json("api/ipeds.cfm", tmp,
					function(response) {
						console.log(response);
						IPEDS.Tables = response.data;
						// IPEDS.getL3s();
						// console.log(IPEDS);
					},
					function(response) {
						console.log("Fail");
						console.log(response);
					}
				);
			},
			getFields: function () {
				var tmp = {"action":"fields", "table":IPEDS.selectedTable};
				console.log(tmp);
				Framework7.request.json("api/ipeds.cfm", tmp,
					function(response) {
						console.log(response);
						IPEDS.Fields = response.data;
						// IPEDS.getL3s();
						// console.log(IPEDS);
					},
					function(response) {
						console.log("Fail");
						console.log(response);
					}
				);
			},
			getValues: function () {
				var tmp = {"action":"values", "field":IPEDS.selectedField};
				console.log(tmp);
				Framework7.request.json("api/ipeds.cfm", tmp,
					function(response) {
						console.log(response);
						IPEDS.Values = response.data;
						// IPEDS.getL3s();
						console.log(IPEDS);
					},
					function(response) {
						console.log("Fail");
						console.log(response);
					}
				);
			}
		},

		mounted: function() {
			console.log('NavIPEDS component has been Mounted!');
			// store.dispatch('init');
			this.getTables();
		}

	});

	return IPEDS;
}
