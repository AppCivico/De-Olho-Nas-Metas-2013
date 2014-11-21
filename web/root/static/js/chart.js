$(document).ready(function() {
	var ctx = [],
		myDoughnutChart = [];
	
	var colors = {
					"darkblue" : {
									color_a: "#2c3e50",
									highlight_a: "#3c536b",
									color_b: "#ecf0f1",
									highlight_b: "#dbdfe0"
								  }
					,
					"red" : {
									color_a: "#ef4836",
									highlight_a: "#f75b4b",
									color_b: "#fbccbf",
									highlight_b: "#dbb2a7"
								  }
					,
					"greenlight" : {
									color_a: "#3fc380",
									highlight_a: "#45d78d",
									color_b: "#b1f8b1",
									highlight_b: "#9ddc9d"
								  }
					,
					"bluelight" : {
									color_a: "#1e8bc3",
									highlight_a: "#209ad8",
									color_b: "#d2e4fb",
									highlight_b: "#bdcfe5"
								  }
					,
					"green" : {
									color_a: "#1bbc9b",
									highlight_a: "#20d7b1",
									color_b: "#c3e5e5",
									highlight_b: "#afd1d1"
								  }
				  };
				  
	var values = {"chart1": {
								value_a: 45,
								value_b: 55
							 }
				  ,
				  "chart2": {
								value_a: 7,
								value_b: 93
							 }
				  };
	
	
	var options = {
		segmentShowStroke : false
	};
				  
	$.each($(".statistics .chart-stats"), function(index,item){
		
		var canvas_id = $(item).find("canvas").attr("id"),
			get_color = $(item).attr("color");
			
		var data = [
						{
							value: values[canvas_id].value_a,
							color: colors[get_color].color_a,
							highlight: colors[get_color].highlight_a
						},
						{
							value: values[canvas_id].value_b,
							color: colors[get_color].color_b,
							highlight: colors[get_color].color_b
						}
					];
		ctx[canvas_id] = document.getElementById(canvas_id).getContext("2d");
	
		myDoughnutChart[canvas_id] = new Chart(ctx[canvas_id]).Doughnut(data,options);
	});
});
