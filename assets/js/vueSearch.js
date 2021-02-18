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
		},
		methods: {
			getSchools: function () {
				// console.log(this.stillWaiting);
				openTab("SearchResults");
				if (!Search.stillWaiting) {
					console.log("Keyword: " + this.keyword);
					Search.stillWaiting = true;
					setTimeout(function () {
						var params = {"action":"getSchools", "keyword":Search.keyword};
						var tmp = $.ajax({
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

			getMySchools: function () {
				var params = {"action":"myschools"};
				var tmp = $.ajax({
	              url:"api/search.cfm",
	              dataType: "json",
	              type: "get",
	              data: params
	            })
				.done(function(data) {
					console.log("myschools: ");
					console.log(data);
					Search.mySchools = data;
				});
			},			
		},

		mounted: function() {
			console.log('vueSearch component has been Mounted!');
			this.getMySchools();
			// store.dispatch('init');
			// this.getTables();
		}

	});

	return Search;
}
