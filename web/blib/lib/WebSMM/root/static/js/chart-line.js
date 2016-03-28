$(document).ready(function() {
	function loadLineGraph(id,c_labels,c_data){
		var ctx = [],
			myLineChart = [];
		
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

		var c_color = ["red","darkblue","green","bluelight"];
		
		
		var options = {
			datasetFill : false,
			responsive: true
		};
					  
		var item = $(id);
			
		var canvas_id = $(item).find("canvas").attr("id"),
			get_color = $(item).attr("color");
			
		var datasets = [];
		$.each(c_data, function(index,item){
			datasets.push({
				strokeColor: colors[c_color[index]].color_a,
				pointColor:  colors[c_color[index]].color_a,
				pointStrokeColor: "#fff",
				data: item
			});
		});

		var data = {
			labels: c_labels,
			datasets: datasets
				};

		ctx[canvas_id] = document.getElementById(canvas_id).getContext("2d");

		myLineChart[canvas_id] = new Chart(ctx[canvas_id]).Line(data,options);

	}
	var data_graph = {
						0: [10,20,30,40,50,60,70,80,90,100,110,12],
						1: [5,10,60,50,45,35,20,40,60,110,85,60]
					};
	loadLineGraph(".timeline .chart",["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],data_graph);
});
