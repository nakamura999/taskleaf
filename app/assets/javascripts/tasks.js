// tasks/index task一覧カーソル合わせ時色変更
document.addEventListener('turbolinks:load', function() {
	document.querySelectorAll('td').forEach(function(td) {
		td.addEventListener('mouseover', function(e) {
			e.currentTarget.style.backgroundColor = '#eff';
		});
		td.addEventListener('mouseout', function(e) {
			e.currentTarget.style.backgroundColor = '';
		});
	});
});

// tasks/index task一覧削除非同期
document.addEventListener('turbolinks:load', function() {
	document.querySelectorAll('.delete').forEach(function(a) {
		a.addEventListener('ajax:success', function() {
			var td = a.parentNode;
			var tr = td.parentNode;
			tr.style.display = 'none';
		});
	});
});