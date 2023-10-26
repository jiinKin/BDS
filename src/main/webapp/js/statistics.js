var book_img;
var book_seq;
window.onload = function(){
//     구글차트 
    google.charts.load('current', {'packages':['corechart']}); 
    google.charts.setOnLoadCallback(drawGenderChart);
    
    function drawGenderChart() {
 //        Ajax요청하기
        $.get('/BookDeliverySystem/genderChart.do', function(data) {
            
            var genderData = new google.visualization.DataTable();
            genderData.addColumn('string', 'Gender');
            genderData.addColumn('number', 'Count');
  //           1위책 남,녀
            genderData.addRow([data[0].user_gender,parseInt(data[0].percent)]);
            genderData.addRow([data[1].user_gender,parseInt(data[1].percent)]);
//             차트 옵션 설정
            var options = {
			    title: '성별 통계',
			    chartArea: {
			        width: '80%', 
			        height: '80%'
			    },
			    width: 400, 
			    height: 300,
			    legend: 'none',
			    titlePosition: 'out',
			    is3D:true,
			    colors: ['#74b9ff', '#81ecec', '#a29bfe', '#dfe6e9', '#00cec9'],
	          	fontSize: 15,
	          	pieSliceText: 'label'
	          	
			};
//             차트 그리기
            var chart = new google.visualization.PieChart(document.getElementById('genderChart'));
            chart.draw(genderData, options);
            
            var bookTitle = data[0].book_title;
            $('#bookTitle').text('['+ bookTitle + ']');
        
        	book_seq = data[0].book_seq;
            book_img = data[0].book_img;
        });
    };
};

//     구글차트 
    google.charts.load('current', {'packages':['corechart']}); 
    google.charts.setOnLoadCallback(drawAgeChart);
    
    function drawAgeChart() {
//         Ajax 요청하기
        $.get('/BookDeliverySystem/ageChart.do', function(data) {
            var ageData = new google.visualization.DataTable();
            ageData.addColumn('string', 'Age');
            ageData.addColumn('number', 'Percent(%)');
            ageData.addColumn({type: 'string', role: 'style'});

			var colorPalette = ['#00b894', '#00d2d3', '#74b9ff', '#55efc4', '#81ecec'];

			for (var i = 0; i < data.length; i++) {
				var colorIndex = i % colorPalette.length;
            	var color = colorPalette[colorIndex];
   			 ageData.addRow([data[i].age_group, parseInt(data[i].percent), color]);
}

 //            차트 옵션 설정
           var options = {
			    title:'연령별 통계',
			    chartArea: {
			        width: '80%', 
			        height: '80%'
			    },
			    width: 400, 
			    height: 300,
			    titlePosition: 'out',
			    legend: { position: "none" },
			    colors: ['#00b894', '#00d2d3', '#74b9ff', '#55efc4', '#81ecec'],
	          	fontSize: 15,
	          	animation: {
	                 duration: 1000,
	                 easing: 'in',
	                startup: true
	          	}
				};
            var chart = new google.visualization.ColumnChart(document.getElementById('ageChart'));
            chart.draw(ageData, options);
        });
    };

