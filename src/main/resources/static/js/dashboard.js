let lineChart;
let isChartReady = false;

const seriesHidden = {
  Transactions: false,
  Earnings: false,
  'Total Revenue': false
};

$(document).ready(function () {

  const today = new Date();
  const localOffset = today.getTimezoneOffset() * 60000;
  const localToday = new Date(today.getTime() - localOffset);

  const sixMonthsAgo = new Date(localToday);
  sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);

  $('#dash-end-date').val(localToday.toISOString().split('T')[0]);
  $('#dash-start-date').val(sixMonthsAgo.toISOString().split('T')[0]);

  $('#btn-update-dashboard').click(function() {
     loadDashboardData();
  });

  function loadDashboardData() {
    isChartReady = false;

    const startDate = $('#dash-start-date').val();
    const endDate = $('#dash-end-date').val();

    $.ajax({
      url: `/api/admin/dashboard/metrics?startDate=${startDate}&endDate=${endDate}`,
      method: 'GET',
      dataType: 'json',
      success: function (data) {
        data.sort((a, b) => {
          const dateA = new Date(Date.parse(a.monthLabel));
          const dateB = new Date(Date.parse(b.monthLabel));
          return dateA - dateB;
        });

        const labels = data.map(item => item.monthLabel);
        const transactionsData = data.map(item => item.transactionCount);
        const earningsData = data.map(item => item.earnings);
        const revenueData = data.map(item => item.totalRevenue);

        let grandTotalTransactions = 0;
        let grandTotalEarnings = 0;
        let grandTotalRevenue = 0;

        data.forEach(item => {
          grandTotalTransactions += Number(item.transactionCount);
          grandTotalEarnings += Number(item.earnings);
          grandTotalRevenue += Number(item.totalRevenue);
        });

        $('.stat-box[style*="box-1"] .stat-value').text(grandTotalTransactions.toLocaleString());
        $('.stat-box[style*="box-2"] .stat-value').text('₱' + grandTotalEarnings.toLocaleString());
        $('.stat-box[style*="box-3"] .stat-value').text('₱' + grandTotalRevenue.toLocaleString());

        initializeChart(labels, transactionsData, earningsData, revenueData);
      }
    });
  }

  function initializeChart(labels, transactions, earnings, revenue) {

    const formattedSeriesData = labels.map((label, index) => {
       const timestamp = new Date(Date.parse(label)).getTime();
       return timestamp;
    });

    var chartOptions = {
      chart: {
        height: 450,
        type: 'line',
        fontFamily: 'DM Sans, sans-serif',
        foreColor: '#9FA2B4',
        background: 'transparent',
        toolbar: { show: true, autoSelected: 'zoom' },
        zoom: { enabled: true, type: 'x', autoScaleYaxis: true }
      },

      tooltip: { theme: 'dark', x: { show: true } },

      styles: [
        `.apexcharts-menu { 
          background: #181926 !important; 
          color: #ffffff !important; 
          border: 1px solid rgba(255,255,255,0.1) !important; 
         }`,
        `.apexcharts-menu-item:hover { 
          background: #25273c !important; 
         }`,
        `.apexcharts-toolbar svg { 
          fill: #9FA2B4 !important; 
         }`,
        `.apexcharts-toolbar svg:hover { 
          fill: #8C00FF !important; 
         }`
      ],

      stroke: { curve: 'smooth', width: 3 },
      colors: ['#FF0077', '#8C00FF', '#1900FF'],
      series: [
        { name: 'Transactions', data: transactions.map((val, idx) => ({ x: formattedSeriesData[idx], y: val })) },
        { name: 'Earnings', data: earnings.map((val, idx) => ({ x: formattedSeriesData[idx], y: val })) },
        { name: 'Total Revenue', data: revenue.map((val, idx) => ({ x: formattedSeriesData[idx], y: val })) }
      ],
      title: {
        text: 'Analytics Overview',
        align: 'left',
        style: { fontSize: '18px', fontWeight: '300', color: '#ffffff' }
      },
      markers: { size: 4, strokeWidth: 0, hover: { size: 7 } },

      xaxis: {
        type: 'datetime',
        tooltip: { enabled: false },
        labels: {
          style: { colors: '#9FA2B4' },
          datetimeFormatter: {
            year: 'yyyy',
            month: "MMM 'yy",
            day: 'dd MMM',
            hour: 'HH:mm'
          }
        },
        tickAmount: 'dataPoints'
      },

      legend: { show: false },
      grid: {
        borderColor: 'rgba(255, 255, 255, 0.08)',
        padding: { bottom: 0 },
        xaxis: { lines: { show: true } }
      }
    };

    if (lineChart) {
      lineChart.destroy();
    }
    lineChart = new ApexCharts($('#line-chart-render')[0], chartOptions);
    lineChart.render();

    Object.keys(seriesHidden).forEach(name => {
      if (seriesHidden[name]) lineChart.toggleSeries(name);
    });

    isChartReady = true;
  }

  loadDashboardData();

  $('[style*="grid-area: box-1"]').css('cursor', 'pointer').click(function() {
    if (!isChartReady) return;
    seriesHidden.Transactions = !seriesHidden.Transactions;
    $(this).toggleClass('filter-disabled', seriesHidden.Transactions);
    lineChart.toggleSeries('Transactions');
  });

  $('[style*="grid-area: box-2"]').css('cursor', 'pointer').click(function() {
    if (!isChartReady) return;
    seriesHidden.Earnings = !seriesHidden.Earnings;
    $(this).toggleClass('filter-disabled', seriesHidden.Earnings);
    lineChart.toggleSeries('Earnings');
  });

  $('[style*="grid-area: box-3"]').css('cursor', 'pointer').click(function() {
    if (!isChartReady) return;
    seriesHidden['Total Revenue'] = !seriesHidden['Total Revenue'];
    $(this).toggleClass('filter-disabled', seriesHidden['Total Revenue']);
    lineChart.toggleSeries('Total Revenue');
  });
});