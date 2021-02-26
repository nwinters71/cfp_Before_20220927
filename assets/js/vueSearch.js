function vueSearch() {

	var Search = new Vue({
		el: '#vueSearch',
		data: {
			// searchParams: {
			// 	ProfileType: "Profiles",
			// 	ProfileActive: "Active",
			// },
			keyword: "",
			matches: [],
			mySchools: [],
			stillWaiting: false,
		},

		computed: {
			mySchoolCodes: {
				get: function() { return store.state.mySchoolCodes; },
				set: function(newValue) {
					store.state.mySchoolCodes = newValue;
				}
			},
			mySchoolList: {
				get: function() { return store.state.mySchoolList; },
				set: function(newValue) {
					store.state.mySchoolList = newValue;
				}
			},
		},

		watch: {
			// mySchoolCodes: function(newL2, oldL2) {
			// 	console.log("watch mySchoolCodes");
			// 	this.getSchools();
			// },
			// mySchoolCodes: {
				// handler() {
					// store.dispatch('getMySchoolsList');
				// },
				// deep: true
			// }
		},
		methods: {
			getSchools: function () {
				// console.log(this.stillWaiting);
				// openTab("SearchResults");
				$("#tabSearchResults").trigger("click");
				if (!Search.stillWaiting) {
					// console.log("Keyword: " + this.keyword);
					Search.stillWaiting = true;
					setTimeout(function () {
						var params = {"action":"getSchools", "keyword":Search.keyword};
						$.ajax({
							url:"api/search.cfm",
							dataType: "json",
							type: "post",
							data: params
						})
						.done(function(data) {
							// console.log("getSchools: ");
							// console.log(data);
							Search.matches = data;
							Search.stillWaiting = false;
						});
					}, 300);
				}
			},
			updateMySchoolList: function(pObj) {
				store.dispatch('updateMySchoolList', pObj);
				store.dispatch('getMySchoolsList');
			},

			test: function () {
				console.log(document.cookie);
				// console.log(this.mySchoolList);
				// for (let x in this.mySchoolList) {
				// 	console.log(x);
				// }
			}
/*
			mySchoolsAdd: function () {
				console.log("Adding School");

				console.log(this.value);
				return;

				// $("table#tblSearchResults").on("click", ".cbSchoolID", function(){
					let params = {};
					params.type = "school";
					params.action = ((this.checked == true) ? 'add' : 'remove');
					params.schoolcode = this.value;
					$.ajax({
						url:"api/faves.cfm",
						data:params,
						type:"post",
						success: function(data) {}          
					});
				// });
			},
			mySchoolsRemove: function () {
				console.log("Remove School");
			},
*/
		// 	getMySchools: function () {
		// 		var params = {"action":"myschools"};
		// 		$.ajax({
		// 			url:"api/search.cfm",
		// 			dataType: "json",
		// 			type: "get",
		// 			data: params
		// 		})
		// 		.done(function(data) {
		// 			console.log("myschools: ");
		// 			console.log(data);
		// 			Search.mySchools = data;
		// 			// $("#tabMySchools").trigger("click");
		// 		});
		// 	},
		},

		mounted: function() {
			console.log('vueSearch component has been Mounted!');
			store.dispatch('getMySchoolsList');

			// this.getMySchools();
			// store.dispatch('init');
			// this.getTables();

		}

	});

	return Search;
}
