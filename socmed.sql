--Menghitung skala kesehatan mental rata-rata berdasarkan gender--
SELECT ud.gender, AVG(mhf.scale_feel_depressed) AS avg_depressed
FROM user_dim ud
JOIN mental_health_fact mhf ON ud.user_id = mhf.user_id
GROUP BY ud.gender;

