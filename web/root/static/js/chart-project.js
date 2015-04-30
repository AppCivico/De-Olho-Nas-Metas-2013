$(document).ready(function() {
	var ctx = [],
		myDoughnutChart = [],
		helpers = Chart.helpers,
		$id = function(id){
			return document.getElementById(id);
		};
	
	var colors = {
					"darkblue" : {
									color: "#2c3e50",
									highlight: "#3c536b"
								  }
					,
					"red" : {
									color: "#ef4836",
									highlight: "#f75b4b"
								  }
					,
					"greenlight" : {
									color: "#3fc380",
									highlight: "#45d78d"
								  }
					,
					"bluelight" : {
									color: "#5bc0de",
									highlight: "#89d7ee"
								  }
					,
					"green" : {
									color: "#8cc63f",
									highlight: "#9ed357"
								  }
					,
					"yellow" : {
									color: "#ffcc00",
									highlight: "#ffdf60"
								  },
					"disabled" : {
									color: "#cccccc",
									highlight: "#aaaaaa"
								  },

				  };
	
	var options = {
		segmentShowStroke : false,
		animation: false,
		tooltipTemplate : "<%if (label){%><%=label%>: <%}%><%= value %>%"
	};
				  
	$.each($(".chart-stats"), function(index,item){

		var legend = true;
		
		var canvas_id = $(item).find("canvas").attr("id"),
			value_late = parseInt($(item).find("canvas").attr("value-late")),
			value_progress = parseInt($(item).find("canvas").attr("value-progress")),
			value_completed = parseInt($(item).find("canvas").attr("value-completed"));

		if (value_late == 0 && value_progress == 0 && value_completed == 0){
			var data = [
							{
								value: 0,
								color: colors["red"].color,
								highlight: colors["red"].highlight,
								label: "atrasado"
							},
							{
								value: 0,
								color: colors["yellow"].color,
								highlight: colors["yellow"].highlight,
								label: "em progresso"
							},
							{
								value: 0,
								color: colors["green"].color,
								highlight: colors["green"].highlight,
								label: "concluído"
							},
							{
								value: 100,
								color: colors["disabled"].color,
								highlight: colors["disabled"].highlight,
								label: "Nenhuma opinião registrada"
							}
						];
		}else{
			var data = [
							{
								value: value_late,
								color: colors["red"].color,
								highlight: colors["red"].highlight,
								label: "atrasado"
							},
							{
								value: value_progress,
								color: colors["yellow"].color,
								highlight: colors["yellow"].highlight,
								label: "em progresso"
							},
							{
								value: value_completed,
								color: colors["green"].color,
								highlight: colors["green"].highlight,
								label: "concluído"
							}
						];
		}
		ctx[canvas_id] = document.getElementById(canvas_id).getContext("2d");
	
		myDoughnutChart[canvas_id] = new Chart(ctx[canvas_id]).Doughnut(data,options);

		if (legend){
			var legendHolder = document.createElement('div');
			legendHolder.innerHTML = myDoughnutChart[canvas_id].generateLegend();
			// Include a html legend template after the module doughnut itself
			helpers.each(legendHolder.firstChild.childNodes, function(legendNode, index){
				helpers.addEvent(legendNode, 'mouseover', function(){
					var activeSegment = myDoughnutChart[canvas_id].segments[index];
					activeSegment.save();
					activeSegment.fillColor = activeSegment.highlightColor;
					myDoughnutChart[canvas_id].showTooltip([activeSegment]);
					activeSegment.restore();
				});
			});
			helpers.addEvent(legendHolder.firstChild, 'mouseout', function(){
				myDoughnutChart[canvas_id].draw();
			});
			var canvas = $id(canvas_id);
			canvas.parentNode.parentNode.appendChild(legendHolder.firstChild);
		}
	});
});