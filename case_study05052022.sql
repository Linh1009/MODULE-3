use furamamanagers;
-- 2.Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
SELECT 
ho_ten
FROM nhan_vien  WHERE ho_ten REGEXP  '^[htk]';

-- 3.Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khach_hang 
where ( year(now()) - year(ngay_sinh)) between 18 and 50
and dia_chi REGEXP 'Đà Nẵng|Quảng Trị$';

-- 4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
 select kh.ma_khach_hang,kh.ho_ten, Max(t.so_lan_dat_phong) as so_lan_dat_phong from khach_hang kh
RIGHT JOIN ( 
select hd.ma_khach_hang as makh, count(hd.ma_khach_hang) as so_lan_dat_phong from hop_dong hd
inner join khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
inner join loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach
where lk.ten_loai_khach = 'Diamond'
group by hd.ma_khach_hang
) as T ON t.makh = kh.ma_khach_hang
group by kh.ho_ten
order by so_lan_dat_phong asc;

-- 5.Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

select 
		T.ma_khach_hang,
		T.ho_ten,
		T.ten_loai_khach,
		T.ma_hop_dong ,
		T.ten_dich_vu,
		T.ngay_lam_hop_dong,
		T.ngay_ket_thuc,
 		T.tong_tien from (

SELECT
		kh.ma_khach_hang,
		kh.ho_ten,
		lk.ten_loai_khach,
		hd.ma_hop_dong ,
		dv.ten_dich_vu,
		hd.ngay_lam_hop_dong,
		hd.ngay_ket_thuc,
 		(dv.chi_phi_thue + (ct.so_luong * di_kem.gia)) as tong_tien
	FROM
		hop_dong hd
		LEFT JOIN khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
		LEFT JOIN loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach 
		LEFT JOIN dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
		LEFT JOIN hop_dong_chi_tiet ct ON ct.ma_hop_dong = hd.ma_hop_dong
		LEFT JOIN dich_vu_di_kem di_kem ON di_kem.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem
		GROUP BY hd.ma_hop_dong
	UNION
	select kh.ma_khach_hang,kh.ho_ten,null,null,null,null,null, 0
		 from khach_hang kh
		WHERE kh.ma_khach_hang NOT IN (select hd.ma_khach_hang from hop_dong hd)
) as T
ORDER BY T.ma_khach_hang;

-- 6.Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
	SELECT
		dv.ma_dich_vu,
		dv.ten_dich_vu,
		dv.dien_tich,
		dv.chi_phi_thue,
		ldv.ten_loai_dich_vu
	FROM
		 dich_vu dv 
		LEFT JOIN loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu 
	WHERE dv.ma_dich_vu not in (
		select dv.ma_dich_vu from dich_vu dv
		INNER JOIN hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
		INNER JOIN loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu 
		WHERE MONTH(hd.ngay_lam_hop_dong) IN (1,2,3)
		)
		GROUP BY dv.ten_dich_vu;
        
        -- 7.Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
SELECT
dv.ma_dich_vu,
dv.ten_dich_vu,
dv.dien_tich,
dv.so_nguoi_toi_da,
dv.chi_phi_thue,
ldv.ten_loai_dich_vu 
FROM
	dich_vu dv
	LEFT JOIN loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu 
WHERE
	1 = 1 
	AND dv.ma_dich_vu NOT IN (
	SELECT
		dv.ma_dich_vu 
	FROM
		dich_vu dv
		INNER JOIN hop_dong hd ON hd.ma_dich_vu = dv.ma_dich_vu
		INNER JOIN loai_dich_vu ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu 
	WHERE
		YEAR ( hd.ngay_lam_hop_dong ) IN (2021)
		AND YEAR ( hd.ngay_lam_hop_dong ) NOT IN (2020)
	) 
GROUP BY
	dv.ten_dich_vu
    
    -- 8.Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.