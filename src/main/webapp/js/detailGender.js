window.onload = function(){
//     구글차트 
    google.charts.load('current', {'packages':['corechart']}); 
    google.charts.setOnLoadCallback(detailGenderChart);
    
    function detailGenderChart() {
 //        Ajax요청하기
        $.get('/BookDeliverySystem/detailGenderChart.do?book_seq=' +book_seq, function(data) {
            
            
            var detailGender = new google.visualization.DataTable();
            detailGender.addColumn('string', 'Gender');
            detailGender.addColumn('number', 'Count');
  //           1위책 남,녀
            detailGender.addRow([data[0].user_gender,parseInt(data[0].percent)]);
            detailGender.addRow([data[1].user_gender,parseInt(data[1].percent)]);
//             차트 옵션 설정
            var options = {
			    title: '성별 통계',
			    backgroundColor: 'white',
			    titleTextStyle: {
        		color: '#222831' 
    			},
			    chartArea: {
			        width: '70%', 
			        height: '70%'
			    },
			    width: 280, 
			    height: 280,
			    legend: 'none',
			    titlePosition: 'out',
			    is3D:true,
			    colors: ['#74b9ff', '#81ecec', '#a29bfe', '#dfe6e9', '#00cec9'],
	          	fontSize: 15,
	          	pieSliceText: 'label',
	          	
			};
//             차트 그리기
            var chart = new google.visualization.PieChart(document.getElementById('detailGenderChart'));
            chart.draw(detailGender, options);
        });
    };
};

//     구글차트 
    google.charts.load('current', {'packages':['corechart']}); 
    google.charts.setOnLoadCallback(detailAgeChart);
    
    function detailAgeChart() {
//         Ajax 요청하기
        $.get('/BookDeliverySystem/detailAgeChart.do?book_seq='+ book_seq, function(data) {
		if (data.length > 0) {
	
            var detailAge = new google.visualization.DataTable();
            detailAge.addColumn('string', 'Age');
            detailAge.addColumn('number', 'Percent(%)');
            detailAge.addColumn({type: 'string', role: 'style'});

			var colorPalette = ['#00b894', '#00d2d3', '#74b9ff', '#55efc4', '#81ecec'];

			for (var i = 0; i < data.length; i++) {
				var colorIndex = i % colorPalette.length;
            	var color = colorPalette[colorIndex];
            	detailAge.addRow([data[i].age_group, parseInt(data[i].percent), color]);
        }
 //            차트 옵션 설정
           var options = {
			    title:'연령별 통계',
			    backgroundColor: 'white',
			    titleTextStyle: {
        		color: '#222831' 
    			},
			    chartArea: {
			        width: '70%', 
			        height: '70%'
			    },
			    width: 280, 
			    height: 280,
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
            var chart = new google.visualization.ColumnChart(document.getElementById('detailAgeChart'));
            chart.draw(detailAge, options);
        } else {
            document.getElementById('detailAgeChart').style.display = 'none';
        }
    });
}